from flask import Flask, request, redirect, url_for, render_template
import sqlite3
  
app = Flask(__name__)
  
DATABASE = 'database.db'
  
def get_db():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn
  
def init_db():
    with app.app_context():
        db = get_db()
        with open('schema.sql', 'r') as f:
            db.executescript(f.read())
        db.commit()
  
@app.route('/')
def index():
    return render_template('index.html')
  
@app.route('/add', methods=['GET', 'POST'])
def add_user():
    if request.method == 'POST':
        student_id = request.form['student_id']
        github_account = request.form['github_account']
        notes = request.form.get('notes', '')
  
        db = get_db()
        db.execute('INSERT INTO users (student_id, github_account, notes) VALUES (?, ?, ?)',
                   (student_id, github_account, notes))
        db.commit()
        return redirect(url_for('index'))
  
    return render_template('add.html')
  
@app.route('/update/<int:user_id>', methods=['GET', 'POST'])
def update_user(user_id):
    db = get_db()
    if request.method == 'POST':
        student_id = request.form['student_id']
        github_account = request.form['github_account']
        notes = request.form.get('notes', '')
  
        db.execute('UPDATE users SET student_id = ?, github_account = ?, notes = ? WHERE id = ?',
                   (student_id, github_account, notes, user_id))
        db.commit()
        return redirect(url_for('index'))
  
    user = db.execute('SELECT * FROM users WHERE id = ?', (user_id,)).fetchone()
    return render_template('update.html', user=user)
  
@app.route('/delete/<int:user_id>')
def delete_user(user_id):
    db = get_db()
    db.execute('DELETE FROM users WHERE id = ?', (user_id,))
    db.commit()
    return redirect(url_for('index'))
  
@app.route('/query')
def query_users():
    db = get_db()
    users = db.execute('SELECT * FROM users').fetchall()
    return render_template('query.html', users=users)
  
if __name__ == '__main__':
    init_db()
    app.run(debug=True)
