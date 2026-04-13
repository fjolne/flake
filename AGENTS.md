## Git

- Commit message should reflect the problem(s) that it solves, use commit desc for extra info

## Python

- Run python via `uv run` from the root directory of the intended project
- Manage python deps via `uv`, do not use `pip`
- Prefer polars over pandas
- Use loguru for logs

## Images

- When you generate an image, via a Python script or any other means, at the end of your response you should show it to the user
- To show it to the user, use `tmux send-keys -t "$TMUX_PANE" C-z \; run-shell 'sleep 0.2' \; send-keys -t "$TMUX_PANE" 'kitty icat -- <image-path> <image-path> ...' Enter \; run-shell 'sleep 0.2' \; send-keys -t "$TMUX_PANE" 'fg' Enter`.
- You should also use this command if the user explicitly asks you to show the image
