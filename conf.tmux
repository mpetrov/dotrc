# make mouse useful in iTerm
set -g mouse-select-pane on

# allow mouse to enter copy mode and initiate selection
set-window-option -g mode-mouse on

# mouse can be used to select windows (by clicking in the status bar)
set-option -g mouse-select-window on

# mouse can be used to resize panes (by dragging dividers)
#set-option -g mouse-resize-pane on
set -g history-limit 50000

set-option -g mouse-utf8 on

# automatically set window title
setw -g automatic-rename

# act like vim
setw -g mode-keys vi
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind-key -r C-h select-window -t :-
bind-key -r C-l select-window -t :+

bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# look good
set -g default-terminal "screen-256color"

set -g terminal-overrides 'xterm*:smcup@:rmcup@'
#### COLOUR

setw -g monitor-activity on
set -g visual-activity on

setw -g aggressive-resize on

unbind [
bind Escape copy-mode
unbind p
bind p paste-buffer
bind -t vi-copy 'v' begin-selection
bind -t vi-copy 'y' copy-selection


# message text
set-option -g message-bg colour235 #base02
set-option -g message-fg colour166 #orange

#set -sg escape-time 1
set -sg escape-time 0

set -g base-index 1
setw -g pane-base-index 1

bind r source-file ~/.tmux.conf \; display "Reloaded ~/.tmux.conf"

bind -r ( switch-client -p
bind -r ) switch-client -n

bind P pipe-pane -o "cat >>~/#W.log" \; display "Toggled logging to ~/#W.log"

# use screen ctrl-a
unbind C-b
set -g prefix C-a

bind C-k clear-history

bind C-a send-keys C-a
#bind C-c run "tmux show-buffer | ssh -p 6969 localhost pbcopy"
#bind C-v run "ssh -p 6969 localhost pbpaste | tmux load-buffer - && tmux paste-buffer"
#bind C-c run "tmux show-buffer | xclip -i -selection clipboard"
#bind C-v run "tmux set-buffer -- \"$(xclip -o -selection clipboard)\"; tmux paste-buffer"

bind 0 last-window
bind a last-pane

if-shell 'test "$(uname)" = "Darwin"' 'source ~/.rc/osx.tmux'

set -g status-left-length 52
set -g status-right-length 451
set -g status-fg white
set -g status-bg colour234
set -g window-status-activity-attr bold
set -g pane-border-fg colour245
set -g pane-active-border-fg colour39
set -g message-fg colour16
set -g message-bg colour221
set -g message-attr bold
set -g status-left '#[fg=colour235,bg=colour252,bold] #(hostname) #[fg=colour245,bg=colour238,bold] #S '
set -g window-status-format "#[fg=252,bg=colour235] #I #W "
set -g window-status-current-format "#[fg=colour24,bg=colour39,noreverse,bold] #I #W #[fg=colour39,bg=colour234,nobold]"

set -g status-right '#[fg=green]#[fg=colour252,bg=colour238] %a %m/%d #[fg=colour235,bg=colour252,bold] %H:%M #[default]'


set-option -g default-shell /usr/bin/zsh
set-option -g xterm-keys on

set -g update-environment "DISPLAY SSH_ASKPASS SSH_AUTH_SOCK SSH_AGENT_PID SSH_CONNECTION WINDOWID XAUTHORITY"

# C-c: save into system clipboard (+). With preselection.
bind C-c choose-buffer "run \"tmux save-buffer -b %% - | zsh -ic 'xcopy'\" \; run \" tmux display \\\"Clipboard \(+\) filled with: $(tmux save-buffer -b %1 - | dd ibs=1 obs=1 status=noxfer count=80 2> /dev/null)... \\\" \" "
# C-v: copy from + clipboard.
bind C-v run "tmux set-buffer \"$(zsh -ic xpaste)\"; tmux paste-buffer" \; run "tmux display \"Copied from \(+\) $(zsh -ic xpaste)... \""
