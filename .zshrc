#       .o8
#      "888
#  .oooo888   .ooooo.  oooo    ooo  .ooooo.   .ooooo.  ooo. .oo.  .oo.   oo.ooooo.
# d88' `888  d88' `88b  `88.  .8'  d88' `"Y8 d88' `88b `888P"Y88bP"Y88b   888' `88b
# 888   888  888ooo888   `88..8'   888       888   888  888   888   888   888   888
# 888   888  888    .o    `888'    888   .o8 888   888  888   888   888   888   888
# `Y8bod88P" `Y8bod8P'     `8'     `Y8bod8P' `Y8bod8P' o888o o888o o888o  888bod8P'
#                                                                         888
#                      ~/.zshrc                                          o888o

# A slightly modified version of .bashrc with zsh related tweaks

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export PNPM_HOME="/home/compey/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

## VARIABLES
export ANDROID_HOME=/usr/local/share/android-sdk
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/build-tools/23.0.0:$PATH
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
export PATH="$PATH:$HOME/.cargo/bin/"
export PATH=$PATH:/opt/riscv/bin
export PATH=$PATH:$HOME/bin
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$PATH:~/.foreman/bin"
export PATH="$PATH:~/.cargo/bin"
export PATH="$PATH:~/.luau/bin"

export EDITOR=nvim
export VISUAL=nvim

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export VIRTUAL_ENV_DISABLE_PROMPT=1

export color_prompt=yes

export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:ow=30;44:'


## ZSH
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3~" delete-char

zstyle :compinstall filename '/home/compey/.zshrc'

autoload -Uz compinit
compinit

## ALIASES
alias grep="/usr/bin/grep $GREP_OPTIONS"
alias ls='exa'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias cat='bat'
alias neofetch="screenfetch -a /home/compey/.screenfetchrc"

alias android_ssh="ssh 192.168.29.108 -p 8022 -i $HOME/.ssh/aur"

## INIT
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"
