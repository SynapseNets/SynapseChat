from utils.decorators import token_required
from flask import Blueprint
from . import createGroup
from . import getGroups
from . import getMessages
from . import joinGroup
from . import leaveGroup
from . import login
from . import register
from . import sendMessage

api = Blueprint('api', __name__)

api.route('/create_group', methods=['POST'])(token_required(createGroup.create_group))
api.route('/get_groups', methods=['POST'])(token_required(getGroups.get_groups))
api.route('/get_messages', methods=['POST'])(token_required(getMessages.get_messages))
api.route('/join_group', methods=['POST'])(token_required(joinGroup.join_group))
api.route('/leave_group', methods=['POST'])(token_required(leaveGroup.leave_group))
api.route('/login', methods=['POST'])(login.login)
api.route('/register', methods=['POST'])(register.register)
api.route('/send_message', methods=['POST'])(token_required(sendMessage.send_message))