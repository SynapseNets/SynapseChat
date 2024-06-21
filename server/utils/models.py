from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Column, Integer, String

db = SQLAlchemy()

class User(db.Model):
    id          = Column(Integer, nullable=False, unique=True, autoincrement=True, primary_key=True)
    username    = Column(String(20), nullable=False, unique=True)
    otp_secret  = Column(String(53), nullable=False, unique=True) # base32 encoded secret
    
    def __repr__(self) -> str:
        return f"<User {self.username}, id {self.id}>"

class Session(db.Model):
    id          = Column(Integer, nullable=False, unique=True, autoincrement=True, primary_key=True)
    user_id     = Column(Integer, nullable=False)
    token       = Column(String(36), nullable=False, unique=True)
    expiration  = Column(Integer, nullable=False)
    
    def __repr__(self) -> str:
        return f"<Session user {self.user_id}, token {self.token}>"

class Group(db.Model):
    id          = Column(Integer, nullable=False, unique=True, autoincrement=True, primary_key=True)
    name        = Column(String(20), nullable=False)
    invite_code = Column(String(36), nullable=False, unique=True)
    
    def __repr__(self) -> str:
        return f"<Group {self.name}, id {self.id}>"

class UserGroup(db.Model):
    user_id     = Column(Integer, nullable=False, primary_key=True)
    group_id    = Column(Integer, nullable=False, primary_key=True)
    last_time   = Column(Integer, nullable=False)
    
    def __repr__(self) -> str:
        return f"<UserGroup user {self.user_id}, group {self.group_id}, last_time {self.last_time}>"