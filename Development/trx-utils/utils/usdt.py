from decimal import Decimal
import tronpy

# USDT TRC20 contract address on TRON Mainnet
USDT_CONTRACT_ADDRESS = "TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t"

client = tronpy.Tron(network='mainnet')

def get_usdt_balance(address: str) -> Decimal:
    """Gets the USDT balance for a given address."""
    try:
        contract = client.get_contract(USDT_CONTRACT_ADDRESS)
        balance_raw = contract.functions.balanceOf(address)
        # USDT has 6 decimal places
        return Decimal(balance_raw) / Decimal(10**6)
    except tronpy.exceptions.AddressNotFound:
        return Decimal(0)
    except Exception as e:
        print(f"An error occurred: {e}")
        return Decimal(0)

def create_usdt_transfer(from_addr: str, to_addr: str, amount_usdt: float):
    """Creates an unsigned USDT transfer transaction."""
    contract = client.get_contract(USDT_CONTRACT_ADDRESS)
    # Convert amount to the smallest unit (6 decimals for USDT)
    amount_raw = int(amount_usdt * (10**6))

    txn = (
        contract.functions.transfer(to_addr, amount_raw)
        .with_owner(from_addr)
        .build()
    )
    return txn