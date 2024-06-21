from flask import Flask, request, jsonify
from base64 import b32encode
from utils.db import get_db_path
from utils.models import *
import ssl, pyotp, os, uuid, re

context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain('server_cert.pem', 'server_key.pem')
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = get_db_path()
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

@app.route('/api/login', methods=['POST'])
def login():
    data = request.get_json()
    if not isinstance(data, dict):
        return jsonify({'message': 'Invalid JSON'}), 400
    
    username = data.get('username')
    password = data.get('password')
    otp = data.get('otp')

    if not username or (not password and not otp):
        return jsonify({'message': 'Missing username and an authentication method'}), 400
    
    user: User = User.query.filter_by(username=username).first()
    if not user:
        return jsonify({'message': 'User not found'}), 404

    if not password:
        if not isinstance(otp, str):
            return jsonify({'message': 'Invalid OTP'}), 400
        otp_server = pyotp.TOTP(user.otp_secret, name=username, issuer=os.getenv('ISSUER')).now()

        if otp_server == otp:
            return jsonify({'message': 'Logged in'}), 200 # TODO: add session
        else:
            return jsonify({'message': 'Invalid OTP'}), 401 # TODO: add check for bruteforce (attack) since the OTP is valid for 30 seconds
    else:
        if not isinstance(username, str) or not isinstance(password, str):
            return jsonify({'message': 'Invalid username or password'}), 400
        # TODO: finish

@app.route('/api/register', methods=['POST'])
def register():
    data = request.get_json()
    if not isinstance(data, dict):
        return jsonify({'message': 'Invalid JSON'}), 400
    
    username = data.get('username')
    password = data.get('password')
    
    if not username:
        return jsonify({'message': 'Missing username'}), 400
    
    # TODO: decide register policy

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

    while True:
        invite_code = str(uuid.uuid4())
        if not Group.query.filter_by(invite_code=invite_code).first():
            break

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
        return jsonify({'message': 'Invalid invite code'}), 400
    
    group = Group.query.filter_by(invite_code=invite_code).first()
    if not group:
        return jsonify({'message': 'Group not found'}), 404
    else:
        group_id = group.id
        # TODO : add user in group by its id

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5050, ssl_context=context)