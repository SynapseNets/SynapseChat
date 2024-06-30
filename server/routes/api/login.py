from werkzeug.security import generate_password_hash
from flask import request, jsonify
from utils.models import User, Session, db
import asyncio, os, pyotp, datetime

def login():
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

    # TODO: add tool anti-DDoS
    if pyotp.TOTP(user.otp_secret, name=user.username, issuer=os.getenv('ISSUER')).verify(otp):
        session = Session(
            user_id=user.id,
            token=(token := generate_password_hash(os.urandom(20).hex())),
            expiration=datetime.datetime.now().timestamp() + (3600 * 24) # 1 day
        )
        db.session.add(session)
        db.session.commit()
        return jsonify({'auth': token}), 200 # token of user
    else:
        return jsonify({'message': 'Invalid OTP'}), 403