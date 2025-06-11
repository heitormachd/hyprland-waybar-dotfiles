#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza'
alias lsa='eza -lasnew'
alias grep='grep --color=auto'
#alias code='code --enable-features=UseOzonePlatform --ozone-platform=wayland'
#alias code='code --disable-gpu-compositing'
alias mpvhdr='mpv --vo=gpu-next --target-colorspace-hint --gpu-api=vulkan --gpu-context=waylandvk'

# Define color escape sequences
RESET="\[\e[0m\]"    # Reset color
BOLD="\[\e[1m\]"     # Bold text
BLACK="\[\e[30m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
YELLOW="\[\e[33m\]"
BLUE="\[\e[34m\]"
MAGENTA="\[\e[35m\]"
CYAN="\[\e[36m\]"
WHITE="\[\e[37m\]"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

parse_git_branch() {
    git branch 2>/dev/null | grep '*' | sed 's/* //'
}

PS1="[\u@\h \w]\$(parse_git_branch | sed 's/^/  /') \$ "

# PS1="${BOLD}${RED}\u@\h ${WHITE}in ${CYAN}\w ${YELLOW} \n$ "
# PS1="${BOLD}${RED}\u${WHITE}@${BLUE}\h ${WHITE}in ${CYAN}\w${YELLOW}\$(parse_git_branch | sed 's/^/  /')\n➜ ${RESET}"
export PATH=$HOME/.platformio/penv/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
