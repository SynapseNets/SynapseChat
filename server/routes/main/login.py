from flask import request, jsonify, redirect, render_template
from flask_login import current_user, login_user

def login():
    if current_user.is_authenticated:
        return redirect('main.dashboard')
    
    if request.method == 'POST':
        # Login logic
        return jsonify({'status': 'success'})
    
    return render_template('login.html')