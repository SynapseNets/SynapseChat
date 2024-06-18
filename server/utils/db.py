import aiomysql, asyncio, os

async def init_db(loop: asyncio.AbstractEventLoop):
    conn = await aiomysql.connect(
        host=os.getenv('DB_HOST', 'database'),
        user=os.getenv('DB_USER', 'root'), 
        password=os.getenv('DB_PASSWORD', 'password'),
        db=os.getenv('DB_DATABASE', 'test'),
        port=os.getenv('DB_PORT', 3306),
        loop=loop
    )
    
    async with conn.cursor() as cur:
        with open('server/db/db.sql', 'r') as f:
            sql = f.read().split('\n\n')
            for i in sql:
                await cur.execute(i)
        await conn.commit()    
    conn.close()