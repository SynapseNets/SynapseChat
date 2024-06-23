from flask import request, jsonify
from utils.models import Group, UserGroup, db
from datetime import datetime
import uuid

def create_group(user_id):
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
    user_group = UserGroup(user_id=user_id, group_id=group.id, last_time=datetime.now())
    
    db.session.add(group)
    db.session.add(user_group)
    db.session.commit()
    
    return jsonify({'message': 'Group created', 'invite_code': invite_code, 'id': group.id}), 201