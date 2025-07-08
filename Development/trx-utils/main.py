from rich.console import Console
from rich.prompt import Prompt
import pyfiglet

from utils.wallet_manager import check_wallet_balance, create_wallet_flow, wallet_menu

console = Console()

def banner(text, font='standard'):
    """Prints a banner using pyfiglet."""
    console.print(pyfiglet.figlet_format(text, font=font), style="bold cyan")


def menu():
    banner("On the first day... Tron was made, and it was good...")
    while True:
        console.print("\n[bold magenta]-- Menu --[/bold magenta]")
        console.print("1. Check Wallet Balance (TRX & USDT)")
        console.print("2. Create New Wallet")
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
                # but it's good practice for robustness.
                console.print("[bold red]Invalid choice. Please try again.[/bold red]")

def main():
    menu()


if __name__ == "__main__":
    main()
