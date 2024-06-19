from utils import db
from utils import receiver
from utils import encoder
import asyncio, ssl

async def handler(reader: asyncio.StreamReader, writer: asyncio.StreamWriter):
    code, payload = await receiver.receive_all(reader)
    
    if code == 0: # init connection
        g, p, A = payload.split(b',')
        g = int.from_bytes(g, 'big')
        p = int.from_bytes(p, 'big')
        A = int.from_bytes(A, 'big')
        keys = await encoder.generate_key(g, p, A)
    
async def load_cert() -> ssl.SSLContext:
    ssl_ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    ssl_ctx.options |= ssl.OP_NO_TLSv1
    ssl_ctx.options |= ssl.OP_NO_TLSv1_1
    ssl_ctx.options |= ssl.OP_SINGLE_DH_USE
    ssl_ctx.options |= ssl.OP_SINGLE_ECDH_USE
    ssl_ctx.load_cert_chain('server_cert.pem', keyfile='server_key.pem')
    ssl_ctx.load_verify_locations(cafile='server_ca.pem')
    ssl_ctx.check_hostname = False
    ssl_ctx.verify_mode = ssl.VerifyMode.CERT_REQUIRED
    ssl_ctx.set_ciphers('ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384')
    return ssl_ctx    
    
async def start_server():
    loop = asyncio.get_event_loop()
    await db.init_db(loop)
    ssl_ctx = load_cert()
    server = await asyncio.start_server(
        handler, 
        '0.0.0.0', 
        port=5050, 
        ssl=ssl_ctx,
        loop=loop
    )
    async with server:
        await server.serve_forever()

async def close_server(server: asyncio.Server):
    server.close()
    await server.wait_closed()

if __name__ == '__main__':
    asyncio.run(start_server())