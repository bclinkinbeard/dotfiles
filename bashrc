export DOTFILES="$HOME/Code/dotfiles"
export PATH="$PATH:./node_modules/.bin"

for file in $DOTFILES/{aliases,colors,exports,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

function parse_git_branch {
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="\w \$(parse_git_branch) \@\n$ "

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

eval "$(rbenv init -)"
export NVM_DIR="/Users/ben/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/ben/.sdkman"
[[ -s "/Users/ben/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/ben/.sdkman/bin/sdkman-init.sh"
