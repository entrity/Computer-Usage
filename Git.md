# Git

## Preview a merge / pull request

Given two branches `SRC` and `DST` (usually some feature and `master`):

```bash
# Basic
git merge-tree $(git merge-base DST SRC) DST SRC
# With color and pager:
git merge-tree $(git merge-base DST SRC) DST SRC | colordiff | less -R
```

## Merge with conflicts

```bash
git merge --abort
git merge --strategy-option theirs "$BRANCH"
```
Note: as the man page says, the "ours" merge strategy-option is very different from the "ours" merge strategy.
