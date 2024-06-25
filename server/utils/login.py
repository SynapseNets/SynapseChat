from flask_login import LoginManager
from utils.models import UserPanel

login_manager = LoginManager()
login_manager.login_view = "main.login"
login_manager.login_message_category = "info"

@login_manager.user_loader
def loadUser(id: str | int):
    return UserPanel.query.get(int(id))