# Luke's config for the Zoomer Shell

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"


# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' '^ulfcd\n'

bindkey -s '^a' '^ubc -lq\n'

bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# Button repeating rate when holded
xset r rate 200 50

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete


# Switching Caps_Lock with Escape
#xmodmap ~/.config/Xmodmap/Xmodmap #2>/dev/null

# Aliases

#alias xmrminer="cd ~/Downloads/xmrig/build ; sudo ./xmrig -o gulf.moneroocean.stream:10128 -u 48KAhpBKeReQrdpJqTyTEFGHYLKscEqfBefnFzoD3fNaUj4ySkmZ7CAfsPShbUgfZNQr5EJiq6DQiZJpdmXrdFVKNG5WnKn"
alias xmrminer="cd ~/Downloads/xmrig-6.16.4-mo1/build ; sudo ./xmrig"
alias yt="cd ~/yt/ ; yt-dlp --audio-quality best -f 399+251"

alias cmp="gcc *.c; ./a.out"
alias ssh_melns="ssh -p 2222 melns@192.168.8.107"
alias ms="cd ~/Documents/Minecraft_server/; ./start.sh"
alias c="cd /home/rihards/Downloads/ran/programming/python_projects/minecraft_miner; python crafter.py"

alias v="nvim"
alias ..="cd .."
alias ls="exa -al --color=always --group-directories-first"
alias ll="exa -l --color=always --group-directories-first"
alias cal="cal -m"
alias p="python3"
alias g="go run"
alias pul="pulsemixer"
alias pulse="pulsemixer"
alias mb1="sudo mount /dev/sdb1 /mnt/sdb"
alias mc1="sudo mount /dev/sdc1 /mnt/sdc"
alias ub1="sudo umount /dev/sdb1"
alias uc1="sudo umount /dev/sdc1"
alias glcmp="g++ main.cpp -lglfw -lGL -lm -lX11 -pthread -lXi -lXrandr -ldl"
alias mount_phone="simple-mtpfs --device 1 ~/phone"
alias untar="tar -xvzf"


# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh 2>/dev/null
