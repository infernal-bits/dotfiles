import pyfiglet
from pyfiglet import figlet_format as fig4
from art import text2art
import blessed

terminal = blessed.Terminal()

def create_tui_element():
    return terminal.text("Hello, TUI!")

tui_element = create_tui_element()
print(tui_element)


# Create a banner
banner = text2art("Welcome to My App", font="block")
print(banner)

# Create ASCII art
ascii_art = text2art("Hello, World!", font="small")
print(ascii_art)


# Create a banner
text = "Hello, World!"
banner = pyfiglet.fig4(text)

print(banner)

font = "slant"
banner = pyfiglet.fig4("Hello, World!", font=font)
print(banner)

with open("banner.txt", "w") as f:
    f.write(pyfiglet.fig4("Hello, World!"))


terminal = blessed.Terminal()

def create_combined_ui():
    ascii_banner = text2art("Welcome to My TUI App", font="block")
    tui_input = terminal.input("Enter your name: ")
    welcome_message = f"Hello, {tui_input}!"
    
    return ascii_banner + "\n\n" + welcome_message

combined_ui = create_combined_ui()
print(combined_ui)

def create_ascii_art(text, width=80):
    lines = []
    words = text.split()
        
    while words:
        line = ""
        for _ in range(width // len(words)):
            line += " ".join(words[:width]) + "\n"
            words = words[width:]
        lines.append(line.strip())
        
    return lines
    
    text = "This is a sample ASCII art created using string manipulation."
    ascii_lines = create_ascii_art(text)
    for line in ascii_lines:
        print(line)
