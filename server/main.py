from werkzeug.security import generate_password_hash
from flask import Flask
from flask_socketio import SocketIO
from utils.db import get_db_path
from utils.models import db, UserPanel
from utils import login
import ssl, os, time

context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain('server_cert.pem', 'server_key.pem')
app = Flask(__name__)
socketio = SocketIO(app)
app.config['SQLALCHEMY_DATABASE_URI'] = get_db_path()
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.secret_key = os.urandom(32).hex()
    
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