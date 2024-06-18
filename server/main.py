from utils import db
import asyncio

async def handler(reader, writer):
    pass

async def start_server():
    loop = asyncio.get_event_loop()
    await db.init_db(loop)
    server = await asyncio.start_server(handler, '0.0.0.0', port=5050)

async def close_server(server: asyncio.Server):
    server.close()
    await server.wait_closed()

if __name__ == '__main__':
    asyncio.run(start_server())