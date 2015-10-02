# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/
export ZSH

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
if [[ $EUID -ne 0 ]]; then
   ZSH_THEME="agnoster"
else
   ZSH_THEME="candy"
fi

# Powerline
#if [[ -r /usr/lib/python3.4/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
#    source /usr/lib/python3.4/site-packages/powerline/bindings/zsh/powerline.zsh
#fi


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh
source /usr/share/oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

# Path to zsh cache
zstyle ':completion::complete:*' cache-path ~/.cache/zsh

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias ls='ls --group-directories-first --color=tty'
alias clcat="grep -vE '^(\s*#|\s*$|;)'"
alias lstree='ls -R | grep ":$" | sed -e '"'"'s/:$//'"'"' -e '"'"'s/[^-][^\/]*\//--/g'"'"' -e '"'"'s/^/   /'"'"' -e '"'"'s/-/|/'"'"
alias open="xdg-open"
alias vpn="ssh vpnrouter vpnc"
alias vpnoff='ssh vpnrouter vpnc-disconnect'
alias kill='kill -9'
export PATH=$PATH:/home/fernandezjm/.gem/ruby/2.1.0/bin/:/home/fernandezjm/.gem/ruby/2.2.0/bin/:/usr/local/heroku/bin
#export TERM=screen-256color #disabled due to output jumbles (PgUp/PgDn) with nano, ncmpcpp, ...
export EDITOR=/usr/bin/vim
export WORKON_HOME=/data/virtualenv
export knock_sequence="20121 20119 20120"
myproxy='http://ng-dpx01.intinfra.com:3128' # 'http://proxyinternet.tesa:8080'

# Enable syntax highlighting with less
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '



function proxy(){
 export no_proxy="localhost, 127.0.0.1, *.local, 10.* ,192.168.*"
 export all_proxy="$myproxy"
 export ALL_PROXY="$myproxy"
 export http_proxy="$myproxy"
 export HTTP_PROXY="$myproxy"
 export ftp_proxy="$myproxy"
 export FTP_PROXY="$myproxy"
 export https_proxy="$myproxy"
 export HTTPS_PROXY="$myproxy"
 echo -e "\nProxy environment variables set."
}
function proxyoff(){
 unset HTTP_PROXY
 unset http_proxy
 unset HTTPS_PROXY
 unset https_proxy
 unset FTP_PROXY
 unset ftp_proxy
 unset all_proxy
 unset ALL_PROXY
 echo -e "\nProxy environment variable removed."
} 


#function virtual_env_prompt () {
#    REPLY=${VIRTUAL_ENV+(${VIRTUAL_ENV:t}) }
#}
#grml_theme_add_token  virtual-env -f virtual_env_prompt '%F{magenta}' '%f'

#zstyle ':prompt:grml:left:setup' items rc virtual-env change-root user at host path vcs percent

bindkey -M menuselect 'h' vi-backward-char        # left
bindkey -M menuselect 'k' vi-up-line-or-history   # up
bindkey -M menuselect 'l' vi-forward-char         # right
bindkey -M menuselect 'j' vi-down-line-or-history # bottom

# Coloured manpages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[30;46m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}


[[ -f /usr/bin/virtualenvwrapper_lazy.sh ]] && source /usr/bin/virtualenvwrapper_lazy.sh

setopt auto_menu
setopt nocaseglob
setopt HIST_IGNORE_DUPS
setopt completealiases

which alsi &>/dev/null
if [[ $? -eq 0 ]] && [[ $EUID -eq 0 ]]; then alsi -a -u; fi


#temporal fix for oh-my-zsh
alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

if [[ -z "$TMUX" ]] && [[ $TERM != screen* ]] ;then
    ID="`tmux ls 2>/dev/null | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
    if [[ -z "$ID" ]] ;then # if not available create a new one
        tmux -2 new-session
    else
        tmux -2 attach-session -t "$ID" # if available attach to it
    fi
fi
