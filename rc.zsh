# Import Google-specific configuration {{{1
GOOGLE_RC=~/.google_rc/google_rc.zsh
if [ -f $GOOGLE_RC ]; then
  source $GOOGLE_RC
fi


# Load oh-my-zsh and plugins {{{1
DOTRC=$HOME/.rc
export ZSH=$DOTRC/submodules/zsh-oh-my-zsh

export DISABLE_AUTO_TITLE="true"
export DISABLE_AUTO_UPDATE="true"
export ZSH_THEME="fishy"

plugins=(git osx vi-mode brew)
source $ZSH/oh-my-zsh.sh
source $ZSH/../zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/../zsh-history-substring-search/zsh-history-substring-search.zsh

setopt INC_APPEND_HISTORY

# Make it more Vim-like {{{1
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey '^Xe' edit-command-line

export EDITOR="vim -X"


# Update the path {{{1
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/texlive/2013basic/bin/universal-darwin:/usr/local/bin:/usr/local/sbin:$PREFIX/bin:/prefix/sbin:/usr/local/gcc-4.5.2-for-linux32/bin:/usr/local/gcc-4.5.2-for-linux64/bin:$HOME/prefix/bin:$HOME/prefix/sbin:/usr/local/bin

PATH=/usr/local/buildtools/java/jdk/bin:$PATH
PATH=$PATH:$HOME/.rvm/bin
PATH=$PATH:$HOME/.rc/bin
PATH=$PATH:$HOME/local/bin

export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH" 
export LD_LIBRARY_PATH=../libdwarf/libdwarf:$PREFIX/lib:/usr/lib/local:$PKG_CONFIG_PATH  

# Utility function {{{1

gitsetup() {
  git config --global color.ui true
  git config --global merge.tool vimdiff
  git config --global alias.ll "log --stat --abbrev-commit"
  git config --global alias.s status
  
  git config --global user.name "Martin Petrov"
  git config --global user.email mpetrov@google.com
}

# Aliases {{{1

alias g=git
alias vi=vim
alias e=vim
alias :e=vim
alias recent_branches='git for-each-ref --sort=-committerdate refs/heads/'
alias c=osc52.sh

export TERM=screen-256color

export JAVA_HOME=`/usr/libexec/java_home -v 1.6`
# export HADOOP_HOME=/usr/local/Cellar/hadoop/1.2.1
export HIVE_HOME=/usr/local/Cellar/hive/0.11.0/libexec
