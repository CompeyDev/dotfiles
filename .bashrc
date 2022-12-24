
#       .o8                                                                         
#      "888                                                                         
#  .oooo888   .ooooo.  oooo    ooo  .ooooo.   .ooooo.  ooo. .oo.  .oo.   oo.ooooo.  
# d88' `888  d88' `88b  `88.  .8'  d88' `"Y8 d88' `88b `888P"Y88bP"Y88b   888' `88b 
# 888   888  888ooo888   `88..8'   888       888   888  888   888   888   888   888 
# 888   888  888    .o    `888'    888   .o8 888   888  888   888   888   888   888 
# `Y8bod88P" `Y8bod8P'     `8'     `Y8bod8P' `Y8bod8P' o888o o888o o888o  888bod8P' 
#                                                                         888       
#                      ~/.bashrc                                         o888o


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '


# Aliases
alias ls='ls --color=auto'
alias neofetch="neofetch | lolcat"
alias pokete="pokete.py"
alias cat="bat"

# Path & Binaries
export GOPATH=~/sdk/go1.19.4/
export PATH=$PATH:~/Discord
export PATH=$PATH:$GOPATH/bin
export PNPM_HOME="/home/jay/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH=$PATH:/usr/bin/pokete
alias go="~/sdk/go1.19.4/bin/go"
export DONT_PROMPT_WSL_INSTALL=true
. "$HOME/.cargo/env"

# Other environment variables
export LANG="en_US.utf8"
export DISPLAY=:0

# Initialize starship
eval "$(starship init bash)"

# Show a cool intro :)
sl -eFa
