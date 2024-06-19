import random

async def generate_key(g: int, p: int, A: int) -> tuple[int, int]:
    """
    Generates a key pair for the Diffie-Hellman key exchange.

    Args:
        g (int): The base value.
        p (int): The prime modulus.
        A (int): The public key of the other party.

    Returns:
        tuple[int, int]: A tuple containing the generated public key (B) and the shared secret key (K).
    """
    b = random.randint(2, p - 1)
    B = pow(g, b, p)
    K = pow(A, b, p)
    return [B, K]