import asyncio

async def handler(reader, writer):
    pass

async def start_server():
    server = await asyncio.start_server(handler, '127.0.0.1', port=8888)

async def close_server(server: asyncio.Server):
    server.close()
    await server.wait_closed()

if __name__ == '__main__':
    asyncio.run(start_server())