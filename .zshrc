# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias redis-cli="docker exec -it -rm redis redis-cli"

# set proxy 命令行终端翻墙
proxy () {
    export ALL_PROXY="http://10.64.144.165:8123"
    export HTTP_PROXY="http://10.64.144.165:8123"
    export HTTPS_PROXY="http://10.64.144.165:8123"
    export NO_PROXY="https://goproxy.cn,git.verystar.cn,172.17.0.0/16"
    echo "Proxy on to verystar"
}

# 取消命令行终端翻墙
unproxy () {
    unset ALL_PROXY
    unset HTTP_PROXY
    unset HTTPS_PROXY
    echo "Proxy off"
}
# Nacos Pull Config
export VERY_ALIYUN_ACCESS_KEY=xx
export VERY_ALIYUN_ACCESS_SECRET=xx
export VERY_ACM_NAMESPACE=xx
export VERY_ACM_ENDPOINT="http://acm.aliyun.com:8080"
# docker 清理
dclear () {
    docker ps -qf status=exited | xargs docker rm
    docker ps -qf status=created | xargs docker rm
    docker images | grep '<none>' | awk '{print $3}' | xargs docker rmi -f
}

# php项目路径
export WEBPATH=~/wwwroot

# 开发环境配置中心
export VERY_PAY_NACOS_NAMESPACE="pay-dev"
export VERY_PAY_NACOS_USERNAME="xx"
export VERY_PAY_NACOS_PASSWORD="xx"
export VERY_PAY_NACOS_SERVER="https://nacos.verystar.net"

# 开发环境数据库
export DEV_DATABASE_HOST="10.64.144.105"
export DEV_DATABASE_USERNAME="xx"
export DEV_DATABASE_PASSWORD="xx"
export DEBUG_SQL="true"

#私有化部署项目数据库
export DEV_DATABASE_HOST2="10.64.144.124"
export DEV_DATABASE_USERNAME2="xx"
export DEV_DATABASE_PASSWORD2="xx"

#go 
export GOPATH=$HOME/go
export PATH=${GOROOT}/bin:${GOPATH}/bin:${PATH}
export GOPROXY=https://goproxy.verystar.net,https://goproxy.cn,https://goproxy.io,direct
export GOPRIVATE=git.verystar.cn
export GOROOT=$HOME/go/go1.23.0
# nvm配置
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# node配置
export NODE_OPTIONS=--openssl-legacy-provider

#docker配置
export DOCKER_DEFAULT_PLATFORM=linux/amd64

#json辅助函数

function json() {
  case $1 in
  "req")
    pbpaste | jq -rC .request_body | jq -r .
    ;;
  "resp")
    pbpaste | jq -rC .response_body | jq -r .
    ;;
  "compact")
    pbpaste | jq -c .
    ;;
  "pretty")
    pbpaste | jq .
    ;;
  "unescape")
    pbpaste | jq -r .
    ;;
  "escape")
    pbpaste | jq -R .
    ;;
  *)
    echo "Usage: json [req|resp|compact|pretty|unescape|escape]"
    pbpaste | jq .
    ;;
  esac
}



replace () {  

pbpaste | sed 's/.*/"&",/' | pbcopy

}



# curl请求 

alias curltrace='curl -w "@$HOME/.curl-format" -o /dev/null -s'


