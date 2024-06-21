from flask import current_app
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import Mapped, mapped_column

db = SQLAlchemy(current_app)

class User(db.Model):
    id: Mapped[int] = mapped_column(nullable=False, unique=True, autoincrement=True, primary_key=True)
    username: Mapped[str] = mapped_column(nullable=False, unique=True)
    password: Mapped[str] = mapped_column(nullable=True) # hash of the actual password
    # the password is optional for every user since we use OTPs
    otp_secret: Mapped[str] = mapped_column(nullable=False, unique=True) # base32 encoded secret
    
    def __repr__(self) -> str:
        return f"<User {self.username}, id {self.id}>"

class Group(db.Model):
    id: Mapped[int] = mapped_column(nullable=False, unique=True, autoincrement=True, primary_key=True)
    name: Mapped[str] = mapped_column(nullable=False)
    invite_code: Mapped[str] = mapped_column(nullable=False, unique=True)
    
    def __repr__(self) -> str:
        return f"<Group {self.name}, id {self.id}>"

class UserGroup(db.Model):
    user_id: Mapped[int] = mapped_column(nullable=False, primary_key=True)
    group_id: Mapped[int] = mapped_column(nullable=False, primary_key=True)
    last_time: Mapped[str] = mapped_column(nullable=False)
    
    def __repr__(self) -> str:
        return f"<UserGroup user {self.user_id}, group {self.group_id}, last_time {self.last_time}>"