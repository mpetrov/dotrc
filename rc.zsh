DOTRC=$HOME/.rc
export ZSH=$DOTRC/submodules/zsh-oh-my-zsh

export DISABLE_AUTO_TITLE="true"
export DISABLE_AUTO_UPDATE="true"
export ZSH_THEME="fishy"

plugins=(git osx vi-mode brew)
source $ZSH/oh-my-zsh.sh
source $ZSH/../zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/../zsh-history-substring-search/zsh-history-substring-search.zsh

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey '^Xe' edit-command-line

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/texlive/2011basic/bin/universal-darwin:/usr/local/bin:/usr/local/sbin:$PREFIX/bin:/prefix/sbin:/usr/local/gcc-4.5.2-for-linux32/bin:/usr/local/gcc-4.5.2-for-linux64/bin:$HOME/prefix/bin:$HOME/prefix/sbin

setopt INC_APPEND_HISTORY

unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  export PREFIX=$HOME/prefix
elif [[ "$unamestr" == 'Darwin' ]]; then
  alias ssh='ssh -R 6969:localhost:22'
  alias wemux='reattach-to-user-namespace wemux'
  export PREFIX=/prefix
fi

function renv() {   
  if [[ -n $TMUX ]]; then
    NEW_SSH_AUTH_SOCK=`tmux showenv|grep ^SSH_AUTH_SOCK|cut -d = -f 2`
    if [[ -n $NEW_SSH_AUTH_SOCK ]] && [[ -S $NEW_SSH_AUTH_SOCK ]]; then 
      SSH_AUTH_SOCK=$NEW_SSH_AUTH_SOCK  
    fi
  fi
}

export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH" 
export LD_LIBRARY_PATH=../libdwarf/libdwarf:$PREFIX/lib:/usr/lib/local:$PKG_CONFIG_PATH  


PATH=$PATH:$HOME/.rvm/bin
PATH=$PATH:$HOME/.rc/bin


gitsetup() {
  git config --global color.ui true
  git config --global merge.tool vimdiff
  git config --global alias.ll "log --stat --abbrev-commit"
  git config --global alias.s status
  git config --global user.name "Martin Petrov"
  git config --global user.email mpetrov@google.com
}


portkill() { lsof | awk "/TCP \*:$1/ {print \$2}" | xargs -r -l kill $2; }


function update_display() {
  export DISPLAY=:`ls /tmp/.X11-unix | sed s/X// | head -1`
}

alias xpaste=' DISPLAY=:`ls /tmp/.X11-unix | sed s/X// | head -1`  xclip -o'
alias xcopy='DISPLAY=:`ls /tmp/.X11-unix | sed s/X// | head -1` xclip -i -sel clipboard'

update_display
tmux set-option -ga update-environment 'DISPLAY SSH_ASKPASS SSH_AUTH_SOCK SSH_AGENT_PID SSH_CONNECTION WINDOWID XAUTHORITY' > /dev/null


if [ -f /home/mpetrov/.google_zshrc ]; then
  source /home/mpetrov/.google_zshrc
fi

