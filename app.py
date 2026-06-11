from flask import Flask, render_template, request, redirect, url_for, session
import mysql.connector
from config import DB_CONFIG

app = Flask(__name__)
app.secret_key = 'ams_secret_key'

def get_db():
    return mysql.connector.connect(**DB_CONFIG)

@app.route('/')
def index():
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        db = get_db()
        cursor = db.cursor()
        cursor.execute("SELECT * FROM users WHERE username=%s AND password=%s", (username, password))
        user = cursor.fetchone()
        db.close()
        if user:
            session['user'] = username
            return redirect(url_for('dashboard'))
        else:
            error = 'Invalid username or password'
    return render_template('login.html', error=error)

@app.route('/dashboard')
def dashboard():
    if 'user' not in session:
        return redirect(url_for('login'))
    db = get_db()
    cursor = db.cursor()
    cursor.execute("SELECT COUNT(*) FROM student")
    total_students = cursor.fetchone()[0]
    from datetime import date
    today = date.today()
    cursor.execute("SELECT COUNT(*) FROM attendance WHERE date=%s AND status='Present'", (today,))
    present_today = cursor.fetchone()[0]
    db.close()
    return render_template('dashboard.html', total=total_students, present=present_today, today=today)

@app.route('/mark_attendance', methods=['GET', 'POST'])
def mark_attendance():
    if 'user' not in session:
        return redirect(url_for('login'))
    db = get_db()
    cursor = db.cursor()
    if request.method == 'POST':
        date = request.form['date']
        for key, value in request.form.items():
            if key.startswith('status_'):
                student_id = key.split('_')[1]
                cursor.execute("INSERT INTO attendance (student_id, date, status) VALUES (%s, %s, %s)",
                               (student_id, date, value))
        db.commit()
        db.close()
        return redirect(url_for('dashboard'))
    cursor.execute("SELECT * FROM student")
    students = cursor.fetchall()
    db.close()
    from datetime import date
    today = date.today()
    return render_template('mark_attendance.html', students=students, today=today)

@app.route('/view_report')
def view_report():
    if 'user' not in session:
        return redirect(url_for('login'))
    db = get_db()
    cursor = db.cursor()
    cursor.execute("""
        SELECT s.name, s.roll_no, s.dept, a.date, a.status
        FROM attendance a
        JOIN student s ON a.student_id = s.student_id
        ORDER BY a.date DESC
    """)
    records = cursor.fetchall()
    db.close()
    return render_template('view_report.html', records=records)

@app.route('/logout')
def logout():
    session.pop('user', None)
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(debug=True)