export DOTFILES="$HOME/Code/dotfiles"
export PATH="$PATH:./node_modules/.bin"

for config_file ($DOTFILES/{aliases,colors,exports,functions}) source $config_file

# Completions
autoload -U promptinit
promptinit

autoload -U compinit
compinit

# Prompt Functions
precmd() {
    chpwd
    PROMPT='%(?.%F{blue}.%F{red})❯%f '
}

chpwd() {
    # Set Terminal title to current directory dynamically
    print -Pn "\e]0; %~\a"
}

fpath=(/usr/local/share/zsh-completions $fpath)

# expand functions in the prompt
setopt prompt_subst

# ignore duplicate history entries
setopt histignoredups

# automatically pushd
setopt auto_pushd

# automatically enter directories without cd
setopt auto_cd

# Enable extended globbing
setopt EXTENDED_GLOB

# Source Pure.zsh
source $DOTFILES/pure/pure.zsh

# Increase file limit
ulimit -n 8192

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

eval "$(rbenv init -)"
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export NVM_DIR=$(brew --prefix)/var/nvm
source $(brew --prefix nvm)/nvm.sh

# postgres app bin (pg_conf, pg_dump)
PATH+=":/Applications/Postgres.app/Contents/Versions/9.4/bin"

# NVM
alias ne='PATH=$(npm bin):$PATH'

function setjdk() {
  if [ $# -ne 0 ]; then
   removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
   if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath $JAVA_HOME
   fi
   export JAVA_HOME=`/usr/libexec/java_home -v $@`
   export PATH=$JAVA_HOME/bin:$PATH
  fi
}
function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" != "N/A" ] && [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm install
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

