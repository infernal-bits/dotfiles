import json
import bip39
from tronpy import Tron
from rich.console import Console
from rich.prompt import Prompt

# Assuming these local imports based on function usage and project structure
from .trxdata import get_balance
from .trc20 import get_usdt_balance


console = Console()


def validate_address(address: str) -> bool:
    """Validates a TRON address using tronpy's static method."""
    return Tron.is_address(address)


def create_new_wallet():
    """
    Generates a new TRON wallet including a mnemonic phrase, private key, and address.
    """
    # 1. Generate a new 12-word mnemonic phrase
    mnemonic = bip39.generate_mnemonic()

    # 2. Use tronpy to derive the private key and address from the mnemonic
    # This follows the standard derivation path for TRON.
    client = Tron()
    wallet = client.generate_address_from_mnemonic(mnemonic)

    return {
        "mnemonic": mnemonic,
        "private_key": wallet['private_key'],
        "address": wallet['base58check_address']
    }
f

def save_wallet_to_file(wallet_data: dict, filename: str):
    """Saves wallet data to a JSON file."""
    try:
        with open(filename, 'w') as f:
            json.dump(wallet_data, f, indent=4)
        console.print(f"[green]Wallet details saved to [bold]{filename}[/bold][/green]")
        console.print("[bold red]WARNING: This file contains your private key and mnemonic. Keep it secret and secure![/bold red]")
    except IOError as e:
        console.print(f"[bold red]Error saving file: {e}[/bold red]")


def check_wallet_balance():
    """Handler for checking wallet balances."""
    address = Prompt.ask("[bold green]Enter TRON Address to check[/bold green]")
    if validate_address(address):
        console.print(f"\n[bold]Address:[/bold] {address} is valid.")
        
        trx_balance = get_balance(address)
        console.print(f"[bold]TRX Balance:[/bold] {trx_balance} TRX")

        usdt_balance = get_usdt_balance(address)
        console.print(f"[bold]USDT Balance:[/bold] {usdt_balance} USDT")
    else:
        console.print("[bold red]Error:[/] Invalid TRON address.")


def create_wallet_flow():
    """Handler for creating and saving a new wallet."""
    console.print("\n[bold yellow]Creating a new wallet...[/bold yellow]")
    wallet_info = create_new_wallet()
    check = validate_address(wallet_info['address'])
    if check: 
        console.print("\n[bold]New Wallet Created![/bold]")
        console.print(f"  [cyan]Address:[/cyan] {wallet_info['address']}")
        console.print(f"  [cyan]Mnemonic:[/cyan] {wallet_info['mnemonic']}")
        console.print(" [cyan]Private Key:[/cyan] [red]REDACTED FOR SECURITY[/red]")
    else:
        console.print("[bold red] Error! New Wallet does not conform to Tron standards. [/bold red]")
        if Prompt.ask("\nDo you want to try again? (yes/no)", choices=["yes", "no"], default="no") == "yes":
            create_wallet_flow()
        
    if Prompt.ask("\nDo you want to save this wallet to a file? (yes/no)", choices=["yes", "no"], default="no") == "yes":
        filename = Prompt.ask("Enter filename to save (e.g., wallet.json)")
        save_wallet_to_file(wallet_info, filename)

def wallet_menu():
    banner("On the second day... Wallets were created, and it was good...")
    while True:
        console.print("\n[bold magenta]-- Wallet Menu --[/bold magenta]")
        console.print("1. Create new 
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        Wallet")
        console.print("2. ")
        console.print("3. Exit")
        choice = Prompt.ask("Choose an option", choices=["1", "2", "3"], default="3")

        match choice:
            case "1":
                check_wallet_balance()
            case "2":
                create_wallet_flow()
            case "3":
                console.print("[yellow]Exiting. Goodbye![/yellow]")
                break
            case _:
                # This case is not strictly necessary because of `Prompt.ask` with `choices`,
                # but it's good practice for robustness.ASSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSCCCCCCCCCCCSSSSSasSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSassssssscssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssszzzzzzzzzzzzzzzz
                console.print("[bold red]Invalid choice. Please try again.[/bold red]")AAAAAAAAAAAA