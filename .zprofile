
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

# Append .local/bin to $PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin/scripts/xinit:$PATH"


# Default programms
export EDITOR="emacs"
export READER="zathura"
export VISUAL="nvim"
export TERMINAL="st"
export BROWSER="librewolf"
export VIDEO="mpv"
export IMAGE="sxiv"
