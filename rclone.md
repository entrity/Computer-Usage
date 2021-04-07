# rclone

## Useful commands/flags
```bash
rclone listremotes
rclone about sand: # See quota info
rclone config show sand # Note absence of trailing colon
rclone config reconnect sand: # Generate new auth token
rclone ls sand:
rclone ls sand:some-path # Show all contents in tree below "some-path"
rclone ls sand: --max-depth 1
rclone ls sand: --drive-shared-with-me # Show only "shared with me" items
rclone lsd sand: # Show directories
rclone copy sand:some-path local-path
```
