from utils import db
from utils import receiver
import asyncio

async def handler(reader: asyncio.StreamReader, writer: asyncio.StreamWriter):
    payload = await receiver.receive_all(reader)
    # use payload

async def start_server():
    loop = asyncio.get_event_loop()
    await db.init_db(loop)
    server = await asyncio.start_server(handler, '0.0.0.0', port=5050)
    async with server:
        await server.serve_forever()

async def close_server(server: asyncio.Server):
    server.close()
    await server.wait_closed()

if __name__ == '__main__':
    asyncio.run(start_server())