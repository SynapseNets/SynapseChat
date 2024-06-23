from flask import Flask
from flask_socketio import SocketIO
from utils.db import get_db_path
from utils.models import db
from utils import login
import ssl

context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain('server_cert.pem', 'server_key.pem')
app = Flask(__name__)
socketio = SocketIO(app)
app.config['SQLALCHEMY_DATABASE_URI'] = get_db_path()
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    
if __name__ == '__main__':
    from routes import main
    app.register_blueprint(main.mainbp, url_prefix='/')
    from routes import api
    app.register_blueprint(api.apibp, url_prefix='/api')

    login.login_manager.init_app(app)
    db.init_app(app)
    with app.app_context():
        db.create_all()

    socketio.run(app, host='0.0.0.0', port=5050, ssl_context=context, allow_unsafe_werkzeug=True) # TODO: remove allow_unsafe_werkzeug=True