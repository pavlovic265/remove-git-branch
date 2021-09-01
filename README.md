
# Remove git branches locally

Script for cleaning up local git branches. See [Features](#features) for all the available options.
By default script uses `git branch -d` which will not delete branches with unmerged changes.

## Setup
### Clone repository
  - Clone repository

  - Create a symbolic link in one of your folders that are mentioned in `$PATH` environment variable, e.g.  

    ````bash
    ln -sf [ABSOLUTE_PATH_TO_REPOSITORY]/remove-git-branch /usr/local/bin/remove-git-branch 
    exec $SHELL
    ````

###  Copy Script

- Download the file into one of your folders that are mentioned in `$PATH` and make it executable, e.g.

  ``````bash
  curl https://raw.githubusercontent.com/pavlovic265/remove-git-branch/main/remove-git-branch -o /usr/local/bin/remove-git-branch
  chmod +x /usr/local/bin/remove-git-branch
  ``````


## Features

- "-b (--branches)" - Branches to remove separated by **`,`**. It has priority over pattern.
- "-p (--pattern)" - Regex pattern to define witch branches should be removed.
- "-a (--all)" - Remove all branches, expect **master**, **main**, and **current**.
- "-e (--exclude)" - Branches to avoid deleting.
- "-h (--help)" - Available flags.
- "-c (--check)" Print branches that will be deleted. But **DOES NOT** delete them.
- "-f (--force)" Force delete (-D) the specified branch, even if it has unmerged changes.
- "-m (--merged-only)" Branches that are already merged and deleted at origin. **Please note**, that it will run `git fetch --prune` as well.

## Usage/Examples
Branches that are always excluded from deleting are  **master**, **main**, and **current branch**.

### Branch (-b | --branch) example
Remove `branch1` and `branch2`
```zsh
remove-git-branch --branch=branch1,branch2
```

### Pattern (-p | --pattern)  example
Removes all branch names that start with `bug/`.
```zsh
remove-git-branch --pattern="^bug/*"
```

### All (-a | --all) example
Remove all branch names.
```zsh
remove-git-branch --all
```

### Exclude (-e | --exclude) example
Remove all branch names, but additional exclude **`branch1`**.

Good use case is with `--all` flag, and exclude one or two branches.

```zsh
remove-git-branch --exclude=branch1 --all
```

### Check (-c | --check) example
Before running a script for clean up, use check flag to see what branches are going to be removed.


```zsh
remove-git-branch --exclude=branch1 --all --check
```
### Force (-f | --force) example
Force delete branch1 and branch2, even if it has unmerged changes


```zsh
remove-git-branch -f --branch=branch1,branch2
```

### Merged only (-m | --merged-only) example
Delete branches that are merged and deleted at origin


```zsh
remove-git-branch -m
```

## License

[MIT](https://choosealicense.com/licenses/mit/)

  
