from flask import request, jsonify
from utils.models import UserGroup, Messages
from utils.decorators import token_required

def get_messages(user_id):
    data = request.get_json()
    if not isinstance(data, dict):
        return jsonify({'message': 'Invalid JSON'}), 400
    
    group_id = data.get('group_id')
    if not group_id:
        return jsonify({'message': 'Missing group id'}), 400
    if not isinstance(group_id, int):
        return jsonify({'message': 'Invalid group id'}), 400
    
    user_group = UserGroup.query.filter_by(user_id=user_id, group_id=group_id).first()
    if not user_group:
        return jsonify({'message': 'User not in group'}), 404
    
    messages: list[Messages] = Messages.query.filter_by(group_id=group_id).all()
    return jsonify([
        {
            'username'  : message.username,
            'message'   : message.message,
            'time'      : message.time
        } 
        for message in messages
    ]), 200