#Add ~/.local/bin to $PATH
typeset -U path PATH
path=(~/.local/bin $path)
path=(~/.local/bin/multimc/UltimMC $path)
export PATH
