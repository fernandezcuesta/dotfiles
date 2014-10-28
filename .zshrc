# The following lines were added by compinstall
zstyle :compinstall filename '/home/fernandezjm/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

bindkey -e
prompt grml

alias clcat="grep -vE '^(\s*#|\s*$|;)'"
alias lstree='ls -R | grep ":$" | sed -e '"'"'s/:$//'"'"' -e '"'"'s/[^-][^\/]*\//--/g'"'"' -e '"'"'s/^/   /'"'"' -e '"'"'s/-/|/'"'"
alias open="xdg-open"
alias vpn="ssh vpnrouter vpnc"
alias vpnoff='ssh vpnrouter vpnc-disconnect'
alias kill='kill -9'

export PATH=$PATH:/home/fernandezjm/.gem/ruby/2.1.0/bin/
#export TERM=xterm-256color #disabled due to output jumbles (PgUp/PgDn) with nano, ncmpcpp, ...
export EDITOR=/usr/bin/vim
export knock_sequence="20121 20119 20120"
myproxy='http://eu-vsip-dpx01.intinfra.com:3128'
#myproxy='http://proxyinternet.tesa:8080'

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
