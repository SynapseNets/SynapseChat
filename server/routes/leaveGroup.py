from flask import request, jsonify
from utils.models import UserGroup, db

def leave_group(user_id):
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
    
    db.session.delete(user_group)
    db.session.commit()
    
    return jsonify({'message': 'Left group'}), 200