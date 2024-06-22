from flask import Flask
from flask_socketio import SocketIO
from utils.db import get_db_path
from utils.models import db
import ssl

context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain('server_cert.pem', 'server_key.pem')
app = Flask(__name__)
socketio = SocketIO(app)
app.config['SQLALCHEMY_DATABASE_URI'] = get_db_path()
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    
if __name__ == '__main__':
    from . import routes
    app.register_blueprint(routes.api, url_prefix='/api')
    
    db.init_app(app)
    with app.app_context():
        db.create_all()
    socketio.run(host='0.0.0.0', port=5050, ssl_context=context)