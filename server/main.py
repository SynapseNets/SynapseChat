from flask_socketio import SocketIO, join_room, leave_room, emit
from werkzeug.security import generate_password_hash
from utils.decorators import token_socket
from datetime import datetime
from flask import Flask
from utils.db import get_db_path
from utils.models import *
from utils import login
import ssl, os, time, re

context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain('server_cert.pem', 'server_key.pem')
app = Flask(__name__)
socketio = SocketIO(app, cors_allowed_origins='*')
app.config['SQLALCHEMY_DATABASE_URI'] = get_db_path()
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.secret_key = os.urandom(32).hex()

@socketio.on('connect')
def connect():
    emit('connected', {'status': 'ok'})

@socketio.on('send')
@token_socket
def send_message(message: dict, user_id: int):
    texts = message.get('text')
    group = message.get('group')
    timestamp = message.get('time')
    
    if not texts:
        emit('error', {'message': 'Missing text'})
        return
    if not isinstance(texts, list):
        emit('error', {'message': 'Invalid text'})
        return
    if not all(isinstance(text, str) for text in texts):
        emit('error', {'message': 'Invalid text'})
        return
    if not isinstance(timestamp, int):
        emit('error', {'message': 'Invalid timestamp'})
        return
    
    group: Group = Group.query.filter_by(id=group).first()
    if not group:
        emit('error', {'message': 'Group not found'})
        return
    
    user_group: list[UserGroup] = UserGroup.query.filter_by(group_id=group.id).all()
    user_group = [user for user in user_group if user.user_id != user_id]
    user: User = User.query.filter_by(id=user_id).first()
    for i, text in enumerate(texts):
        msg = Messages(
            sender_id=user.id, 
            reciever_id=user_group[i].user_id,
            group_id=group.id, 
            username=user.username, 
            message=text, 
            time=timestamp
        )
        emit('message', {
                'message_id': msg.id, 
                'text': text, 
                'time': timestamp, 
                'user': user.username
            }, 
            to=user_group[i].user_id,
            broadcast=False
        )
        db.session.add(msg)
        
    db.session.commit()
    emit('success', {'message': 'success'})
    
@socketio.on('received')
@token_socket
def received_message(data: dict, user_id: int):
    message_id = data.get('message_id')
    
    if not message_id:
        emit('error', {'message': 'Missing message id'})
        return
    if not isinstance(message_id, int):
        emit('error', {'message': 'Invalid message id'})
        return
    
    message: Messages = Messages.query.filter_by(id=message_id).first()
    if not message:
        emit('error', {'message': 'Message not found'})
        return
    if message.reciver_id != user_id:
        emit('error', {'message': 'Message not for this user'})
        return
    
    db.session.delete(message)
    db.session.commit()
    emit('success', {'message': 'success'})
    
@socketio.on('join')
@token_socket
def join_group(data: dict, user_id: int):
    public_key = data.get('public_key')
    invite_code = data.get('invite_code')
    
    if not invite_code:
        emit('error', {'message': 'Missing invite code'})
        return
    if not isinstance(invite_code, str):
        emit('error', {'message': 'Invalid invite code'})
        return
    if not re.match(r'^[a-f0-9]{8}-([a-f0-9]{4}-){3}[a-f0-9]{12}$', invite_code):
        emit('error', {'message': 'Invalid invite code format'})
        return
    
    if not public_key:
        emit('error', {'message': 'Missing public key'})
        return
    if not isinstance(public_key, int):
        emit('error', {'message': 'Invalid public key'})
        return
    
    group: Group = Group.query.filter_by(invite_code=invite_code).first()
    if not group:
        emit('error', {'message': 'Group not found'})
        return
    
    group_id = group.id
    user_group = UserGroup(
        user_id=user_id, 
        group_id=group_id,
        public_key=public_key,
        group_name=group.name,
        last_time=datetime.now()
    )
    
    db.session.add(user_group)
    db.session.commit()
    join_room(group_id, sid=user_id)
    emit('joined', {'key': public_key}, to=group.id, include_self=False)
    
    keys = []
    for key in UserGroup.query.filter_by(group_id=group_id).all():
        keys.append(key.public_key)
    
    emit('success', {'message': 'Joined group', 'id': group_id, 'keys': keys})

@socketio.on('leave')
@token_socket
def leave_group(data: dict, user_id: int):
    group_id = data.get('group_id')
    
    if not group_id:
        emit('error', {'message': 'Missing group id'})
        return
    if not isinstance(group_id, int):
        emit('error', {'message': 'Invalid group id'})
        return
    
    user_group: UserGroup = UserGroup.query.filter_by(user_id=user_id, group_id=group_id).first()
    if not user_group:
        emit('error', {'message': 'User not in group'})
        return 
    
    db.session.delete(user_group)
    db.session.commit()
    leave_room(group_id, sid=user_id)
        
    emit('success', {'message': 'Left group'})

if __name__ == '__main__':
    from routes import main
    app.register_blueprint(main.mainbp, url_prefix='/')
    from routes import api
    app.register_blueprint(api.apibp, url_prefix='/api')

    login.login_manager.init_app(app)
    db.init_app(app)
    
    with app.app_context():
        while True: # wait for connection to db
            try:
                db.create_all()
                break
            except:
                time.sleep(1)
                
        password = os.getenv('ADMIN_PASSWORD', os.urandom(8).hex())
        if not UserPanel.query.filter_by(username='admin').first() and password:
            admin = UserPanel(username='admin', password=generate_password_hash(password))
            db.session.add(admin)
            db.session.commit()
            print(f'Admin password: {password}')
            
    socketio.run(app, host='0.0.0.0', port=5050, ssl_context=context, allow_unsafe_werkzeug=True) # TODO: remove allow_unsafe_werkzeug=True