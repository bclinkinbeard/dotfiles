export DOTFILES="$HOME/Code/dotfiles"

for config_file ($DOTFILES/{aliases,colors,exports,functions}) source $config_file

# Completions
autoload -U promptinit
promptinit

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

# Try to correct command line spelling
setopt CORRECT CORRECT_ALL

# Enable extended globbing
setopt EXTENDED_GLOB

# Grunt tab completion
eval "$(grunt --completion=zsh)"

# Source Pure.zsh
source $DOTFILES/pure/pure.zsh
