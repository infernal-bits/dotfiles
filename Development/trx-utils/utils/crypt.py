from tronpy.keys import PrivateKey

def get_keys_from_private(private_key_hex: str) -> dict:
    """
    Generates public key and address from a private key.
    WARNING: Handle private keys with extreme care.
    """
    private_key = PrivateKey(bytes.fromhex(private_key_hex))
    public_key = private_key.public_key
    address = public_key.to_base58check_address()
    return {"private_key": private_key.hex(), "public_key": public_key.hex(), "address": address}
