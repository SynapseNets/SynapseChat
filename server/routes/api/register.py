from base64 import b32encode
from flask import request, jsonify
from utils.models import db
from utils.models import User
import os, pyotp

def register():
    data = request.get_json()
    if not isinstance(data, dict):
        return jsonify({'message': 'Invalid JSON'}), 400
    
    username = data.get('username')
    
    if not username:
        return jsonify({'message': 'Missing username'}), 400
    
    if not isinstance(username, str):
        return jsonify({'message': 'Invalid username'}), 400
    
    if User.query.filter_by(username=username).first():
        return jsonify({'message': 'Username already exists'}), 400
    
    otp_secret = b32encode(os.urandom(32)).decode()[:52]
    user = User(username=username, otp_secret=otp_secret)
    db.session.add(user)
    db.session.commit()
    
    return {"auth": pyotp.TOTP(otp_secret).provisioning_uri(name=username, issuer_name=os.getenv('ISSUER'))}, 201