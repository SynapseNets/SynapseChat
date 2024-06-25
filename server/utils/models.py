from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from sqlalchemy import Column, Integer, String, DateTime

db = SQLAlchemy()

####################### APIs MODELS #######################

class User(db.Model):
    id          = Column(Integer, nullable=False, unique=True, autoincrement=True, primary_key=True)
    username    = Column(String(20), nullable=False, unique=True)
    otp_secret  = Column(String(53), nullable=False, unique=True) # base32 encoded secret
    
    def __repr__(self) -> str:
        return f"<User {self.username}, id {self.id}>"

class Session(db.Model):
    id          = Column(Integer, nullable=False, unique=True, autoincrement=True, primary_key=True)
    user_id     = Column(Integer, nullable=False)
    token       = Column(String(162), nullable=False, unique=True) # safe hash of random token
    expiration  = Column(Integer, nullable=False)
    
    def __repr__(self) -> str:
        return f"<Session user {self.user_id}, token {self.token}>"

class Group(db.Model):
    id          = Column(Integer, nullable=False, unique=True, autoincrement=True, primary_key=True)
    name        = Column(String(20), nullable=False)
    invite_code = Column(String(36), nullable=False, unique=True)
    
    def __repr__(self) -> str:
        return f"<Group {self.name}, id {self.id}>"

class Messages(db.Model):
    id          = Column(Integer, nullable=False, unique=True, autoincrement=True, primary_key=True)
    user_id     = Column(Integer, nullable=False)
    group_id    = Column(Integer, nullable=False)
    username    = Column(String(20), nullable=False)
    message     = Column(String(300), nullable=False)
    time        = Column(DateTime, nullable=False)
    # TODO: add status of message
    
    def __repr__(self) -> str:
        return f"<Message user {self.user_id}, group {self.group_id}, time {self.time}>"

class UserGroup(db.Model):
    user_id     = Column(Integer, nullable=False, primary_key=True)
    group_id    = Column(Integer, nullable=False, primary_key=True)
    group_name  = Column(String(20), nullable=False)
    last_time   = Column(DateTime, nullable=False)
    
    def __repr__(self) -> str:
        return f"<UserGroup user {self.user_id}, group {self.group_id}, last_time {self.last_time}>"

####################### PANEL MODELS #######################

class UserPanel(db.Model, UserMixin):
    id          = Column(Integer, nullable=False, unique=True, autoincrement=True, primary_key=True)
    username    = Column(String(20), nullable=False, unique=True)
    password    = Column(String(200), nullable=False)
    
    def __repr__(self) -> str:
        return f"<UserPanel {self.username}, id {self.id}>"

    def get_id(self):
        print(str(self.id), flush=True)
        return str(self.id)