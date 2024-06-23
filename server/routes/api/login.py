from werkzeug.security import generate_password_hash
from flask import request, jsonify
from utils.models import User
import asyncio, os, pyotp

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
    if pyotp.TOTP(user.otp_secret, name=user.username, issuer=os.getenv('ISSUER')).verify(otp):
        return jsonify({'auth': generate_password_hash(os.urandom(20).hex())}), 200 # token of user
    else:
        return jsonify({'message': 'Invalid OTP'}), 403