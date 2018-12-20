# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ruby autojump osx rbenv z)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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

eval "$(rbenv init -)"

# pod

alias open_workspace="open *.xcworkspace"
pod_clean(){
    rm -rf ./*.xcworkspace
    rm -rf Podfile.lock
    rm -rf Pods
}



alias gl_list="git fsck --lost-found"
# alias gl_recover="git checkout -B recover "

function gl_recover(){
    pushd "$1" || exit  # push the path
    git checkout -B recover "$2"
    git checkout SARRS
    popd || exit
}

function gl_clean(){
    pushd "$1" || exit # push the path
    git checkout SARRS
    git reflog expire --expire=now --all
    git gc --prune=now
    git fsck --lost-found
    popd || exit
}
function pod_search_x(){
    echo "$1"
    pod search --regex "^$1"
}
alias chmodx="chmod u+rx"
function xcode_plugin_enable(){
    mv "$HOME/Library/Application Support/Developer/Shared/Xcode/Plug-ins.tmp" "$HOME/Library/Application Support/Developer/Shared/Xcode/Plug-ins"
}

function xcode_plugin_disable(){
    mv "$HOME/Library/Application Support/Developer/Shared/Xcode/Plug-ins" "$HOME/Library/Application Support/Developer/Shared/Xcode/Plug-ins.tmp"
}

#ssh-add -k "$HOME/.ssh/wangchao9_legitlab"
#ssh-add -K "$HOME/.ssh/id_rsa"
find $HOME/.ssh -type f | grep -v ".pub" | grep -v "known_hosts"  | xargs -n1 -I{} ssh-add -k {}

export PATH="/usr/local/bin:/usr/local/sbin:/Applications/hack:/Applications/hack/theos/bin/:$PATH"
export PYTHONPATH=$HOME/cpip/bin
export PATH="$HOME/.fastlane/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK=$ANDROID_HOME
export ANDROID_NDK=$ANDROID_HOME/ndk-bundle

export GOPATH=$HOME/workspace-go
export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
export PYENV_ROOT=/usr/local/var/pyenvexport PATH="/usr/local/opt/qt/bin:$PATH"

export ANDROID_HVPROTO=ddm
export PS4='+{$LINENO:${FUNCNAME[0]}} '

# usfull function

function xcode_clear_derived_data(){
    rm -rf "$HOME/Library/Developer/Xcode/DerivedData/$1"*
}

function h2b(){
    value=$(awk '{print toupper($1)}' <<< "$1")
    bits=${2:-64}
    export BC_LINE_LENGTH=$((bits+2))

    printf "%${bits}s" "$(bc <<< "obase=2;ibase=16;$value")" | sed -E "s/ /0/g;s/(.{8})/\\1 /g"
}
function h2d(){
    value=$(awk '{print toupper($1)}' <<< "$1")
    bc <<<  "obase=10;ibase=16;$value"
}

function d2b(){
    value="$1"
    bits=${2:-64}
    export BC_LINE_LENGTH=$((bits+2))
    printf "%${bits}s" "$(bc <<< "obase=2;ibase=10;$value")" | sed -E "s/ /0/g;s/(.{8})/\\1 /g"
}
function d2h(){
    bc <<< "obase=16;ibase=10;$1"
}

function b2d(){
    bc <<< "obase=10;ibase=2;${*// /}"
}

function b2h(){
    bc <<< "obase=16;ibase=2;${*// /}"
}

function ip(){
    ifconfig|grep cast|awk '{print $2}'
}

# date parse
function date_parse_int(){
    if [[ $# -lt 1 ]]; then
        echo "Usage:date_parse_int value"
        exit 1
    fi
    value="$1"
    len=${#value}
    if [[ len -gt 10 ]]; then
        date -jf "%s" "$((value/1000))"
    else
        date -jf "%s" "$1"
    fi
}

function date_parse_str(){
    if [[ $# -lt 2 ]]; then
        echo "Usage:date_parse_str fmt value"
        exit 1
    fi
    date -jf "$@"
}

# pick line
function pick_line(){
    if [[ $# -lt 2 ]]; then
        echo "usage:pick_line line_no file"
        return
    fi
    line=$1
    file=$2
    if [[ $line =~ ^[0-9]+$ ]]; then
        echo -n
    else
        line=$2
        file=$1
    fi

    sed "${line:-0}q;d" "$file"
}

function history_grep(){
    if [[ $# -gt 0 ]]; then
        history |grep "$@"
        #statements
    else
        history
    fi
}

alias clean="clear && printf '\\e[3J'"
alias cl=clean
alias cr=clear
alias h=history_grep

# configure proxy for git while on corporate network
# From https://gist.github.com/garystafford/8196920
function proxy_on(){
   # assumes $USER_DOMAIN, $USER_NAME, $USER_DNS_DOMAIN
   # are existing Windows system-level environment variables

   # assumes $PASSWORD, $PROXY_SERVER, $PROXY_PORT
   # are existing Windows current user-level environment variables (your user)

   # environment variables are UPPERCASE even in git bash
   export http_proxy="http://127.0.0.1:1087"
   export https_proxy=$http_proxy

   export ftp_proxy=$http_proxy
   export socks_proxy="socks5://127.0.0.1:1086"

   export no_proxy="localhost,127.0.0.1,$USERDNSDOMAIN"

   # Update git and npm to use the proxy
   #git config --global http.proxy "$http_proxy"

   # Proxy  a specific domain
   git config --global http.https://github.com.proxy "$http_proxy"
   git config --global http.https://github.com.sslVerify false

   #git config --system http.sslcainfo /bin/curl-ca-bundle.crt
   #git config --global http.sslcainfo /bin/curl-ca-bundle.crt

   # npm config set proxy $http_proxy
   # npm config set https-proxy $http_proxy
   # npm config set strict-ssl false
   # npm config set registry "http://registry.npmjs.org/"

   # optional for debugging
   export GIT_CURL_VERBOSE=1

   # optional Self Signed SSL certs and
   # internal CA certificate in an corporate environment
   export GIT_SSL_NO_VERIFY=1


   env | grep -e _PROXY -e GIT_ | sort
   # echo -e "\nProxy-related environment variables set."

   # clear
}

# Enable proxy settings immediately
# proxy_on

# Disable proxy settings
function proxy_off(){
   variables=( \
      "http_proxy" "https_proxy" "ftp_proxy" "socks_proxy" \
      "no_proxy" "GIT_CURL_VERBOSE" "GIT_SSL_NO_VERIFY" \
   )

   for i in "${variables[@]}"
   do
      unset "$i"
   done

   env | grep -e _PROXY -e GIT_ | sort
   echo -e "\\nProxy-related environment variables removed."
}
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

