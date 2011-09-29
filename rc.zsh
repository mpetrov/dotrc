export ZSH=$HOME/Library/Profile/submodules/zsh-oh-my-zsh

export ZSH_THEME="fishy"
export DISABLE_AUTO_UPDATE="true"

plugins=(git osx vi-mode)
source $ZSH/oh-my-zsh.sh

source $ZSH/../zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/../zsh-history-substring-search/zsh-history-substring-search.zsh

export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/usr/local/texlive/2011basic/bin/universal-darwin

# use macvim if possible on a mac
MACVIM_SHELL=/Applications/MacVim.app/Contents/MacOS/vim 
if [ -f $MACVIM_SHELL ]; then
  alias vim=$MACVIM_SHELL
elif [ -f ~$MACVIM_SHELL ]; then
  alias vim=~$MACVIM_SHELL
fi

export EC2_HOME=~/.ec2
export PATH=$PATH:$EC2_HOME/bin
export EC2_PRIVATE_KEY=`ls $EC2_HOME/pk-*.pem`
export EC2_CERT=`ls $EC2_HOME/cert-*.pem`
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
