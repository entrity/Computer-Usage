# Capistrano

A tool for automating deploy processes.

```bash
# Minimal command
bundle exec cap production deploy
# Specify a single host, branch, task
HOSTS=insureio.two:4000 bundle exec cap -s branch=master production deploy:restart
```
