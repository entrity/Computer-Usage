# Git

## Preview a merge / pull request

Given two branches `SRC` and `DST` (usually some feature and `master`):

```bash
# Basic
git merge-tree $(git merge-base DST SRC) DST SRC
# With color and pager:
git merge-tree $(git merge-base DST SRC) DST SRC | colordiff | less -R
```
