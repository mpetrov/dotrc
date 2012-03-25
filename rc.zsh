export ZSH=$HOME/.rc/submodules/zsh-oh-my-zsh

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

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/texlive/2011basic/bin/universal-darwin:/usr/local/bin:/usr/local/sbin:$HOME/prefix/bin:$HOME/prefix/sbin

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
fi


