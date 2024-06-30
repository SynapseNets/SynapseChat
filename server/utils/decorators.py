from flask import request, make_response, jsonify
from flask_socketio import emit
from utils.models import Session, User, db
from functools import wraps
import time

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
        
        if session.expiration < int(time.time()):
            db.session.delete(session)
            db.session.commit()
            return make_response(jsonify({"message": "Token expired"}), 401)
        
        user = session.user_id
        current_user: User = User.query.filter_by(id=user).first()
        
        if not current_user: # should not happen
            return make_response(jsonify({"message": "User not found"}), 404)
        
        return f(current_user.id, *args, **kwargs)
    return decorator

def token_socket(f):
    @wraps(f)
    def decorator(message, *args, **kwargs):
        token = None
        if 'auth' in message:
            token = message.get('auth') # remove 'Bearer ' from token
        if not token:
            return emit('error', {"message": "No token provided"})
        
        session: Session = Session.query.filter_by(token=token).first()
        if not session:
            return emit('error', {"message": "Invalid token"})
        
        if session.expiration < int(time.time()):
            db.session.delete(session)
            db.session.commit()
            return emit('error', {"message": "Token expired"})
        
        user = session.user_id
        current_user: User = User.query.filter_by(id=user).first()
        
        if not current_user: # should not happen
            return emit('error', {"message": "User not found"})
        
        return f(message, current_user.id, *args, **kwargs)
    return decorator