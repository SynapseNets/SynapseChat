from flask import request, make_response, jsonify
from models import Session, User
from functools import wraps

def token_required(f):
    @wraps(f)
    def decorator(*args, **kwargs):
        token = None
        if 'Authorization' in request.headers:
            token = request.headers['Authorization'][7:] # remove 'Bearer ' from token
        if not token:
            return make_response(jsonify({"message": "No token provided"}), 401)
        
        session: Session = Session.query.filter_by(token=token).first()
        if not session:
            return make_response(jsonify({"message": "Invalid token"}), 401)
        
        user = session.user_id
        current_user: User = User.query.filter_by(id=user).first()
        
        if not current_user: # should not happen
            return make_response(jsonify({"message": "User not found"}), 404)
        
        return f(current_user.id, *args, **kwargs)
    return decorator