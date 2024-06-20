import mysql.connector
import asyncio, os

def init_db():
    conn = mysql.connector.connect(
        host=os.getenv('DB_HOST', 'database'),
        user=os.getenv('DB_USER', 'root'), 
        password=os.getenv('DB_PASSWORD', 'password'),
        database=os.getenv('DB_DATABASE', 'test'),
        port=os.getenv('DB_PORT', 3306),
    )
    
    with conn.cursor() as cur:
        with open('server/db/db.sql', 'r') as f:
            sql = f.read().split('\n\n')
            for i in sql:
                cur.execute(i)
        conn.commit()
    conn.close()