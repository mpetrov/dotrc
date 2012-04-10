set-option -g default-command "reattach-to-user-namespace -l zsh"
bind C-c run "tmux show-buffer | reattach-to-user-namespace pbcopy"
bind C-v run "reattach-to-user-namespace pbpaste | tmux load-buffer - && tmux paste-buffer"
