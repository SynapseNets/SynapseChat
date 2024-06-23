from flask_login import login_required
from flask import Blueprint
from . import dashboard
from . import index
from . import login

mainbp = Blueprint('main', __name__)

mainbp.route('/dashboard', methods=['GET'])(login_required(dashboard.dashboard))
mainbp.route('/', methods=['GET'])(index.index)
mainbp.route('/login', methods=['GET', 'POST'])(login.login)