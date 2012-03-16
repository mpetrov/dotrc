# make mouse useful in iTerm
set -g mouse-select-pane on

# mouse can be used to resize panes (by dragging dividers)
set-option -g mouse-resize-pane on

# allow mouse to enter copy mode and initiate selection
set-window-option -g mode-mouse on

# mouse can be used to select windows (by clicking in the status bar)
set-option -g mouse-select-window on

# # mouse can be used to resize panes (by dragging dividers)
set-option -g mouse-resize-pane on

# automatically set window title
setw -g automatic-rename

# act like vim
setw -g mode-keys vi
setw -g mode-mouse on
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind-key -r C-h select-window -t :-
bind-key -r C-l select-window -t :+
bind < resize-pane -L 4
bind > resize-pane -R 4
bind - resize-pane -D 4
bind + resize-pane -U 4

# look good
set -g default-terminal "screen-256color"

# status indicators
#set -g status-right '#(uptime | cut -d, -f 2-)'

set -g terminal-overrides 'xterm*:smcup@:rmcup@'

#### COLOUR



# default statusbar colors
set-option -g status-bg colour235 #base02
set-option -g status-fg colour136 #yellow
set-option -g status-attr default

# default window title colors
set-window-option -g window-status-fg colour244
set-window-option -g window-status-bg default
#set-window-option -g window-status-attr dim

# active window title colors
set-window-option -g window-status-current-fg colour166 #orange
set-window-option -g window-status-current-bg default
#set-window-option -g window-status-current-attr bright

# pane border
set-option -g pane-border-fg colour235 #base02
set-option -g pane-active-border-fg colour240 #base01

# message text
set-option -g message-bg colour235 #base02
set-option -g message-fg colour166 #orange

# pane number display
set-option -g display-panes-active-colour colour33 #blue
set-option -g display-panes-colour colour166 #orange

# clock
set-window-option -g clock-mode-colour colour64 #green

# use screen ctrl-a
unbind C-b
set -g prefix C-a

set-option -g default-command "reattach-to-user-namespace -l zsh"
bind C-c run "tmux show-buffer | reattach-to-user-namespace pbcopy"
bind C-v run "reattach-to-user-namespace pbpaste | tmux load-buffer - && tmux paste-buffer"
