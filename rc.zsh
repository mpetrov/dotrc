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
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/texlive/2011basic/bin/universal-darwin:/usr/local/bin:/usr/local/sbin:$PREFIX/bin:/prefix/sbin:/usr/local/gcc-4.5.2-for-linux32/bin:/usr/local/gcc-4.5.2-for-linux64/bin:$HOME/prefix/bin:$HOME/prefix/sbin:/usr/local/bin

PATH=$PATH:$HOME/.rvm/bin
PATH=$PATH:$HOME/.rc/bin

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

# Copy / paste hacks {{{1

function update_display() {
  export DISPLAY=:`ls /tmp/.X11-unix | sed s/X// | head -1`
}
alias vi=vim
alias e=vim
alias :e=vim
alias recent_branches='git for-each-ref --sort=-committerdate refs/heads/'
alias xpaste=' DISPLAY=:`ls /tmp/.X11-unix | sed s/X// | head -1`  xclip -o'
alias xcopy='DISPLAY=:`ls /tmp/.X11-unix | sed s/X// | head -1` xclip -i -sel clipboard'
update_display
tmux set-option -ga update-environment 'DISPLAY SSH_ASKPASS SSH_AUTH_SOCK SSH_AGENT_PID SSH_CONNECTION WINDOWID XAUTHORITY' > /dev/null


