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

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# pnpm
export PNPM_HOME="/home/compey/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export ANDROID_HOME=/usr/local/share/android-sdk
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/build-tools/23.0.0:$PATH


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# EXPORTS
export PATH="$PATH:~/.foreman/bin"
export PATH="$PATH:~/.cargo/bin"
export PATH="$PATH:~/.luau/bin"

export HISTFILESIZE=10000
export HISTSIZE=500

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

## CALLS
shopt -s checkwinsize
shopt -s histappend

unset GREP_OPTIONS

source ~/bin/ble.sh/out/ble.sh --noattach

## ALIASES
alias grep="/usr/bin/grep $GREP_OPTIONS"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

alias gitClean="git branch | grep -v "development" | xargs git branch -D"
alias spiderfoot="cd ~/Tools/spiderfoot-4.0 && python sf.py -l 127.0.0.1:5001"

alias neofetch="screenfetch -a /home/compey/.screenfetchrc"

## FUNCTIONS
function _parse_git_branch() {
        if [ -n "$(git rev-parse --git-dir 2> /dev/null)" ]; then
                echo -e "-[\033[1;35m$(git rev-parse --abbrev-ref HEAD)\033[1;32m]"
        fi
}

function _setprompt {
        local NOCOLOR="\033[0m"
        local INFO_COLOR='\033[1;34m'
        local PROMPT_COLOR='\033[1;32m'
        local PROMPT_SYMBOL=@

        if [ "$EUID" -eq 0 ]; then
                local INFO_COLOR='\033[1;31m'
                local PROMPT_COLOR='\033[;94m'
        fi

        PS1="${PROMPT_COLOR}┌──${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)${PROMPT_COLOR})}(${INFO_COLOR}\u${PROMPT_SYMBOL}\h${PROMPT_COLOR})$(_parse_git_branch)${PROMPT_COLOR}-[\[\033[0;1m\]\w${PROMPT_COLOR}]\n${PROMPT_COLOR}└─${INFO_COLOR}\$\[\033[0m\] "
        PS2='\[${DARKGRAY}\]>\[${NOCOLOR}\] '
        PS3='Number: '
        PS4='\[${DARKGRAY}\]+\[${NOCOLOR}\] '
}

## BLE-CONFIG
bleopt pager=less
bleopt editor=nvim

bleopt exec_errexit_mark=$''
bleopt exec_elapsed_mark=$'\e[94m[elapsed %s (CPU %s%%)]\e[m'
bleopt prompt_eol_mark=$''

bleopt canvas_winch_action=redraw-prev

ble-color-setface auto_complete fg=242,bg=235
ble-color-setface auto_complete fg=white,bg=69
ble-color-setface auto_complete fg=240,underline,itali

## INIT

neofetch && \
eval "$(oh-my-posh init bash --config $HOME/.local/share/ohmyposh/catppuccin_mocha.omp.json)" && \
ble-attach
