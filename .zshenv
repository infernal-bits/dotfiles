# ╔═══════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║  ██▓ ███▄    █   █████▒▓█████  ██▀███   ███▄    █  ▄▄▄       ██▓     ██████╗ ██╗████████╗███████╗ ║
# ║ ▓██▒ ██ ▀█   █ ▓██   ▒ ▓█   ▀ ▓██ ▒ ██▒ ██ ▀█   █ ▒████▄    ▓██▒     ██╔══██╗██║╚══██╔══╝██╔════╝ ║
# ║ ▒██▒▓██  ▀█ ██▒▒████ ░ ▒███   ▓██ ░▄█ ▒▓██  ▀█ ██▒▒██  ▀█▄  ▒██░     ██████╔╝██║   ██║   ███████╗ ║
# ║ ░██░▓██▒  ▐▌██▒░▓█▒  ░ ▒▓█  ▄ ▒██▀▀█▄  ▓██▒  ▐▌██▒░██▄▄▄▄██ ▒██░     ██╔══██╗██║   ██║   ╚════██║ ║
# ║ ░██░▒██░   ▓██░░▒█░    ░▒████▒░██▓ ▒██▒▒██░   ▓██░ ▓█   ▓██▒░██████▒ ██████╔╝██║   ██║   ███████║ ║
# ║ ░▓  ░ ▒░   ▒ ▒  ▒ ░    ░░ ▒░ ░░ ▒▓ ░▒▓░░ ▒░   ▒ ▒  ▒▒   ▓▒█░░ ▒░▓  ░ ╚═════╝ ╚═╝   ╚═╝   ╚══════╝ ║
# ║  ▒ ░░ ░░   ░ ▒░ ░       ░ ░  ░  ░▒ ░ ▒░░ ░░   ░ ▒░  ▒   ▒▒ ░░ ░ ▒  ░ ╔══════════════════════════╗ ║
# ║  ▒ ░   ░   ░ ░  ░ ░       ░     ░░   ░    ░   ░ ░   ░   ▒     ░ ░    ║ github.com/infernal-bits ║ ║
# ║  ░           ░            ░  ░   ░              ░       ░  ░    ░  ░ ╚══════════════════════════╝ ║
# ╚════Dotfiles Straight From the Depths of Hell══════════════════════════════════════════════════════╝


# zsh history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# options
setopt appendhistory
setopt extended_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt auto_cd
setopt pushd_ignore_dups
setopt auto_list

# generic $PATH handling
if (( EUID != 0 )); then
  path=(
    $HOME/.bin
    $HOME/.local/bin
	$HOME/.cargo/bin
    /usr/local/bin
    /usr/bin
    /bin
    /usr/local/sbin
    /usr/sbin
    /sbin
    /usr/local/games
    /usr/games
    "${path[@]}"
  )
else
  path=(
    $HOME/bin
    $HOME/.local/bin
    /usr/local/sbin
    /usr/local/bin
    /sbin
    /bin
    /usr/sbin
    /usr/bin
    "${path[@]}"
  )
fi

# remove empty components to avoid '::' ending up + resulting in './' being in $PATH
path=( "${path[@]:#}" )

typeset -U path

# less (:=pager) options:
#  export LESS=C
typeset -a lp; lp=( ${^path}/lesspipe(N) )
if (( $#lp > 0 )) && [[ -x $lp[1] ]] ; then
    export LESSOPEN="|lesspipe %s"
elif [[ -x /usr/bin/lesspipe.sh ]] ; then
    export LESSOPEN="|lesspipe.sh %s"
fi
unset lp

export READNULLCMD=${PAGER:-/usr/bin/pager}

## END OF FILE #################################################################
