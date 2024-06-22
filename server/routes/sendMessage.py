from flask import request, jsonify
from utils.models import UserGroup, Messages, User, db
from datetime import datetime

def send_message(user_id):
    data = request.get_json()
    if not isinstance(data, dict):
        return jsonify({'message': 'Invalid JSON'}), 400
    
    group_id = data.get('group_id')
    message = data.get('message')
    username = User.query.filter_by(id=user_id).first().username
    
    if not group_id or not message:
        return jsonify({'message': 'Missing group id or message'}), 400
    if not isinstance(group_id, int) or not isinstance(message, str):
        return jsonify({'message': 'Invalid group id or message'}), 400
    
    user_group = UserGroup.query.filter_by(user_id=user_id, group_id=group_id).first()
    if not user_group:
        return jsonify({'message': 'User not in group'}), 404
    
    message = Messages(user_id=user_id, group_id=group_id, username=username, message=message, time=datetime.now())
    db.session.add(message)
    db.session.commit()
    
    return jsonify({'message': 'Message sent'}), 200
