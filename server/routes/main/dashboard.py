from flask import render_template, redirect
from flask_login import current_user

def dashboard():
    if not current_user.is_authenticated:
        return redirect('main.login')
    
    return render_template('dashboard.html')