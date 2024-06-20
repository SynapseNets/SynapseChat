from utils import db
from utils import encoder
import asyncio, ssl

async def handler(reader: asyncio.StreamReader, writer: asyncio.StreamWriter):
    pass

def load_cert() -> ssl.SSLContext:
    ssl_context = ssl.create_default_context(ssl.Purpose.CLIENT_AUTH)
    ssl_context.load_cert_chain(certfile='server_cert.pem', keyfile='server_key.pem')
    ssl_context.load_verify_locations(cafile='server_ca.pem')
    ssl_context.check_hostname = False
    ssl_context.verify_mode = ssl.CERT_NONE
    return ssl_context
    
async def start_server():
    loop = asyncio.get_event_loop()
    # await db.init_db()
    ssl_ctx = load_cert()
    server = await asyncio.start_server(
        handler, 
        '0.0.0.0', 
        port=5050, 
        ssl=ssl_ctx
    )
    async with server:
        await server.serve_forever()

async def close_server(server: asyncio.Server):
    server.close()
    await server.wait_closed()

if __name__ == '__main__':
    asyncio.run(start_server())