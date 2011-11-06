export ZSH=$HOME/.rc/submodules/zsh-oh-my-zsh

export ZSH_THEME="fishy"
export DISABLE_AUTO_UPDATE="true"

plugins=(git osx vi-mode)
source $ZSH/oh-my-zsh.sh

source $ZSH/../zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/../zsh-history-substring-search/zsh-history-substring-search.zsh

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/texlive/2011basic/bin/universal-darwin:/usr/local/bin

# use macvim if possible on a mac
#MACVIM_SHELL=/Applications/MacVim.app/Contents/MacOS/vim 
#if [ -f $MACVIM_SHELL ]; then
#  alias vim=$MACVIM_SHELL
#elif [ -f ~$MACVIM_SHELL ]; then
#  alias vim=~$MACVIM_SHELL
#fi
