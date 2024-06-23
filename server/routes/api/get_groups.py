from flask import jsonify
from utils.models import UserGroup

def get_groups(user_id):
    groups: list[UserGroup] = UserGroup.query.filter_by(user_id=user_id).all()
    return jsonify([
        {
            'id'    : group.group_id,
            'name'  : group.group_name
        }
        for group in groups
    ]), 200