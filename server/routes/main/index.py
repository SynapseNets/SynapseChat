from flask import render_template, redirect, url_for
from flask_login import current_user

def index():
    if current_user.is_authenticated:
        return redirect(url_for('main.dashboard'))
    else:
        return render_template('index.html')