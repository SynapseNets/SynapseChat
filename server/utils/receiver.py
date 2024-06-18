import asyncio

async def receive_all(reader: asyncio.StreamReader) -> bytes:
    """
    Reads and returns a complete message from the given `reader` stream.

    Args:
        reader (asyncio.StreamReader): The stream reader to read from.

    Returns:
        bytes: The received message as bytes.

    Raises:
        asyncio.IncompleteReadError: If the message is not received completely.
    """
    code = int.from_bytes(await reader.readexactly(1), 'big')
    num_bytes = int.from_bytes(await reader.readuntil(b'\x00'), 'big')
    payload = await reader.readexactly(num_bytes)
    assert len(payload) == num_bytes
    assert await reader.readexactly(1) == b'\x00'
    return (code, payload)

async def send_all(writer: asyncio.StreamWriter, code: int, payload: bytes) -> None:
    """
    Sends a message to the specified writer.

    Args:
        writer (asyncio.StreamWriter): The writer to send the message to.
        code (int): The code to send as the first byte of the message.
        payload (bytes): The payload to send as the content of the message.

    Returns:
        None
    """
    writer.write(code.to_bytes(1, 'big'))
    writer.write(len(payload).to_bytes(4, 'big'))
    writer.write(payload)
    writer.write(b'\x00')
    await writer.drain()