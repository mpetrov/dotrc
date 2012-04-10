bind C-c run "tmux save-buffer - | ssh -p 6969 localhost pbcopy"
bind C-v run "ssh -p 6969 localhost pbcopy | tmux load-buffer - && tmux paste-buffer"
