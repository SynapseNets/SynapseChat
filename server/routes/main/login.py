from flask import request, redirect, render_template, flash, url_for, current_app
from werkzeug.security import check_password_hash
from flask_login import current_user, login_user
from utils.models import UserPanel

def login():
    if current_user.is_authenticated:
        return redirect(url_for('main.dashboard'))
    
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        
        if not username or not password:
            flash('Username and password are required', 'error')
            return redirect(url_for('main.login'))
        if not isinstance(username, str) or not isinstance(password, str):
            flash('Username and password must be strings', 'error')
            return redirect(url_for('main.login'))
        
        # Check if user exists
        user: UserPanel = UserPanel.query.filter_by(username=username).first()
        if user and check_password_hash(user.password, password):
            login_user(user)
            return redirect(url_for('main.dashboard'))
        
        flash('Invalid username or password', 'error')
        return redirect(url_for('main.login'))
    
    return render_template('login.html')