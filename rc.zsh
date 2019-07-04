export PATH=$HOME/homebrew/bin:$PATH

ANTIGEN=$HOME/homebrew/share/antigen/antigen.zsh
[ -f $ANTIGEN ] && source $ANTIGEN

antigen use oh-my-zsh
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle vi-mode
antigen bundle mercurial
antigen theme fishy
antigen apply

setopt INC_APPEND_HISTORY
export EDITOR=nvim
alias e=nvim
alias vim=nvim

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Import Google-specific configuration {{{1
GOOGLE_RC=~/google_rc/google_rc.zsh
if [ -f $GOOGLE_RC ]; then
  source $GOOGLE_RC
fi
