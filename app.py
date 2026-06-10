from flask import Flask
import mysql.connector
from config import DB_CONFIG

app = Flask(__name__)

@app.route('/')
def home():
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        if conn.is_connected():
            return 'Flask is running and MySQL is connected!'
    except Exception as e:
        return f'Error: {e}'

if __name__ == '__main__':
    app.run(debug=True)