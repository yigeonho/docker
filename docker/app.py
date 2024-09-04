from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import pytz

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://user:1234@db/mydatabase'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# SQLAlchemy 객체 생성
db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password = db.Column(db.String(120), nullable=False)

    def __repr__(self):
        return f'<User {self.username}>'
# 메인 페이지
@app.route('/')
def main():
    return render_template('main.html')

# 로그인 페이지
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        user = User.query.filter_by(username=username, password=password).first()

        if user:
            return redirect(url_for('login_success'))
        else:
            return "Login failed. Please check your username and password."

    return render_template('login.html')

# 회원가입 페이지
@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        # 폼 데이터 수집
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']

        # 새로운 사용자 생성
        new_user = User(username=username, email=email, password=password)

        try:
            # 데이터베이스에 사용자 저장
            db.session.add(new_user)
            db.session.commit()
            return redirect(url_for('main'))
        except Exception as e:
            # 예외 처리 (예: 사용자 이름이나 이메일 중복)
            return f"An error occurred: {str(e)}"

    return render_template('register.html')
# 기본 레이아웃 페이지 (옵션)
@app.route('/base')
def base():
    return render_template('base.html')

@app.route('/login_success')
def login_success():
    korea_timezone = pytz.timezone('Asia/Seoul')
    current_time = datetime.now(korea_timezone).strftime('%Y-%m-%d %H:%M:%S')
    return render_template('login_success.html', current_time=current_time)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

