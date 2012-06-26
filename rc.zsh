DOTRC=$HOME/.rc
export ZSH=$DOTRC/submodules/zsh-oh-my-zsh

export DISABLE_AUTO_TITLE="true"

export ZSH_THEME="fishy"
export DISABLE_AUTO_UPDATE="true"

plugins=(git osx vi-mode brew)
source $ZSH/oh-my-zsh.sh


source $ZSH/../zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/../zsh-history-substring-search/zsh-history-substring-search.zsh

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey '^Xe' edit-command-line

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/texlive/2011basic/bin/universal-darwin:/usr/local/bin:/usr/local/sbin:/prefix/bin:/prefix/sbin:/usr/local/gcc-4.5.2-for-linux32/bin:/usr/local/gcc-4.5.2-for-linux64/bin


setopt INC_APPEND_HISTORY

function session() {
  if [[ "$TERM" != "screen-256color" ]] then
    tmux attach-session -t "$USER" || tmux new-session -s "$USER"
    exit
  fi
}
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  # TODO(mpetrov): Linux Specific Commands
elif [[ "$unamestr" == 'Darwin' ]]; then
  alias ssh='ssh -R 6969:localhost:22'
  alias vi='reattach-to-user-namespace vim'
  alias ls='gls --color -h'
fi

function renv() {   
  if [[ -n $TMUX ]]; then
    NEW_SSH_AUTH_SOCK=`tmux showenv|grep ^SSH_AUTH_SOCK|cut -d = -f 2`
    if [[ -n $NEW_SSH_AUTH_SOCK ]] && [[ -S $NEW_SSH_AUTH_SOCK ]]; then 
      SSH_AUTH_SOCK=$NEW_SSH_AUTH_SOCK  
    fi
  fi
}


export PKG_CONFIG_PATH="/prefix/lib/pkgconfig:$PKG_CONFIG_PATH" 
export LD_LIBRARY_PATH=../libdwarf/libdwarf:/prefix/lib:/usr/lib/local:$PKG_CONFIG_PATH  

