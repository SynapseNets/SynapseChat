from werkzeug.security import generate_password_hash, check_password_hash
from flask import Flask, request, jsonify
from utils import db
import ssl

context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain('server_cert.pem', 'server_key.pem')
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = db.get_db_path()
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

@app.route('/api/login', methods=['POST'])
def login():
    data = request.get_json()
    # TODO: add your code here lol
    return jsonify({'message': 'Login failed'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5050, ssl_context=context)