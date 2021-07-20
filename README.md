
# Remove git branches locally

Script to add as alias for cleaning up local branches. It is customizable if users prefers to do so.
By default script uses -d, which will not delete branches if it has unmerged changes.

## Setup
### Clone repository
  - Clone repository
  - Open .zsh or .bash_profile or other.
  - Add `alias remove-git-branch=[ABSOLUTE_PATH_TO_REPOSITORY]/remove-git-branch.sh`
  - Restart terminal


### Copy Script
- Create file `remove-git-branch.sh`
- chmod +x [ABSOLUTE_PATH_TO_THE_FILE]/remove-git-branch.sh
- Open .zsh or .bash_profile or other.
- Add alias=[ABSOLUTE_PATH_TO_THE_FILE]/remove-git-branch.sh
- Restart terminal


## Features

- "-b (--branches)" - Branches to remove separated by **`,`**. It has priority over pattern.
- "-p (--pattern)" - Regex pattern to define witch branches should be removed.
- "-a (--all)" - Remove all branches, expect **master**, **main**, and **current**.
- "-e (--exclude)" - Branches to avoid deleting.
- "-h (--help)" - Available flags.
- "-c (--check)" Print branches that will be deleted. But **DOES NOT** delete them.
- "-f (--force)" Force delete (-D) the specified branch, even if it has unmerged changes.

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

## License

[MIT](https://choosealicense.com/licenses/mit/)

  