from utils.decorators import token_required
from flask import Blueprint
from . import create_group
from . import groups
from . import messages
from . import login
from . import register

apibp = Blueprint('api', __name__)

apibp.route('/create_group', methods=['POST'])(token_required(create_group.create_group))
apibp.route('/get_groups', methods=['POST'])(token_required(groups.groups))
apibp.route('/get_messages', methods=['POST'])(token_required(messages.messages))
apibp.route('/login', methods=['POST'])(login.login)
apibp.route('/register', methods=['POST'])(register.register)