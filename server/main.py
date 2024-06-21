from werkzeug.security import generate_password_hash
from flask import Flask, request, jsonify
from base64 import b32encode
from utils.db import get_db_path
from utils.models import *
import ssl, pyotp, os, uuid, re, asyncio

context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain('server_cert.pem', 'server_key.pem')
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = get_db_path()
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

@app.route('/api/login', methods=['POST'])
async def login():
    data = request.get_json()
    if not isinstance(data, dict):
        return jsonify({'message': 'Invalid JSON'}), 400
    
    username    = data.get('username')
    otp         = data.get('otp')

    if not username or not otp:
        return jsonify({'message': 'Missing username or the otp code'}), 400
    
    if not isinstance(username, str) or not isinstance(otp, str):
        return jsonify({'message': 'Invalid format username or otp code'}), 400
    
    user: User = User.query.filter_by(username=username).first()
    if not user:
        return jsonify({'message': 'User not found'}), 404

    await asyncio.sleep(0.5) # TODO: remove this if tool anti-DDoS is enabled
    if pyotp.TOTP(user.otp_secret).verify(otp):
        return jsonify({'auth': generate_password_hash(os.urandom(20).hex())}), 200 # token of user
    else:
        return jsonify({'message': 'Invalid OTP'}), 403

@app.route('/api/register', methods=['POST'])
def register():
    data = request.get_json()
    if not isinstance(data, dict):
        return jsonify({'message': 'Invalid JSON'}), 400
    
    username = data.get('username')
    
    if not username:
        return jsonify({'message': 'Missing username'}), 400
    
    if not isinstance(username, str):
        return jsonify({'message': 'Invalid username'}), 400
    
    # TODO : check if username is already taken
    
    otp_secret = b32encode(os.urandom(32)).decode()[:52]
    user = User(username=username, otp_secret=otp_secret)
    db.session.add(user)
    db.session.commit()
    
    return {"auth": pyotp.TOTP(otp_secret).provisioning_uri(name=username, issuer_name=os.getenv('ISSUER'))}, 201

@app.route('/api/create_group', methods=['POST'])
def create_group():
    data = request.get_json()
    if not isinstance(data, dict):
        return jsonify({'message': 'Invalid JSON'}), 400
    
    name = data.get('name')
    
    if not name:
        return jsonify({'message': 'Missing name'}), 400

    if not isinstance(name, str):
        return jsonify({'message': 'Invalid name'}), 400

    # assert that the invite code is unique
    invite_code = str(uuid.uuid4())

    group = Group(name=name, invite_code=invite_code)
    db.session.add(group)
    db.session.commit()
    # TODO: add user to the group
    
    return jsonify({'message': 'Group created'}), 201

@app.route('/api/join_group', methods=['POST'])
def join_group():
    data = request.get_json()
    if not isinstance(data, dict):
        return jsonify({'message': 'Invalid JSON'}), 400
    
    invite_code = data.get('invite_code')
    
    if not invite_code:
        return jsonify({'message': 'Missing invite code'}), 400
    if not isinstance(invite_code, str):
        return jsonify({'message': 'Invalid invite code'}), 400
    if not re.match(r'^[a-f0-9]{8}-([a-f0-9]{4}-){3}[a-f0-9]{12}$', invite_code):
        return jsonify({'message': 'Invalid invite code format'}), 403
    
    group = Group.query.filter_by(invite_code=invite_code).first()
    if not group:
        return jsonify({'message': 'Group not found'}), 404
    else:
        group_id = group.id
        # TODO : add user in group by its id

if __name__ == '__main__':
    db.init_app(app)
    with app.app_context():
        db.create_all()
    app.run(host='0.0.0.0', port=5050, ssl_context=context)