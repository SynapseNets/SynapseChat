from flask import request, jsonify
from utils.models import Group, UserGroup, db
from datetime import datetime
import re

def join_group(user_id):
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
    
    group: Group = Group.query.filter_by(invite_code=invite_code).first()
    if not group:
        return jsonify({'message': 'Group not found'}), 404
    
    group_id = group.id
    user_group = UserGroup(
        user_id=user_id, 
        group_id=group_id, 
        group_name=group.name, 
        last_time=datetime.now()
    )
    
    db.session.add(user_group)
    db.session.commit()
    
    return jsonify({'message': 'Joined group', 'id': group_id}), 200