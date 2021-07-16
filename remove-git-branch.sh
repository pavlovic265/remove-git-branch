#!/bin/bash

CURRENT_BRANCH="^\*.*"
EXCLUDE_DEFAULT="$CURRENT_BRANCH|master|main"

EXCLUDE=""
PATTERN=""
DELETE=""
CHECK=""

for i in "$@"; do
  case $i in
    -b=*|--branch=*)
      BRANCHES="${i#*=}"
      shift # past argument=value
      ;;
    -p=*|--pattern=*)
      PATTERN="${i#*=}"
      shift # past argument=value
      ;;
    -a|--all)
      ALL=".*"
      shift # past argument=value
      ;;
    -e=*|--exclude=*)
      EXCLUDE="${i#*=}"
      shift # past argument=value
      ;;
    -c|--check)
      CHECK="true"
      shift # past argument=value
      ;;
    -h|--help)
    echo "usage: remove-git-branch  [-b=<pattern> | --branch=<pattern>] [-p=<pattern> | --pattern=<pattern>]
                [-a | --all] [-h | --help]"
      echo "-b (--branch) - Branches to remove separated by ','. It has priority over pattern."
      echo "-p (--pattern) - Regex pattern to define witch branches should be removed."
      echo "-a (--all) - Remove all branches, expect master, **main, and current."
      echo "-e (--exclude) - Branches to exclude from deleting."
      echo "-c (--check) Print branches that will be deleted. But DOES NOT delete them."
      echo "-h (--help) - Available flags."
      exit 1;
      ;;
    *)
      # unknown option
      ;;
  esac
done



if [[ $EXCLUDE ]]; then
  SPLIT_EXCLUDE=$(echo $EXCLUDE | tr "," "|");
  EXCLUDE="^($EXCLUDE_DEFAULT|$SPLIT_EXCLUDE)$"
else 
  EXCLUDE="^($EXCLUDE_DEFAULT)$"
fi

if [[ $BRANCHES ]]; then
  SPLIT_BRANCHES=$(echo $BRANCHES | tr "," "|");
  DELETE_BRANCHES="^($SPLIT_BRANCHES)$"
fi

if [[ $PATTERN ]]; then
  DELETE_PATTERN="$PATTERN"
fi

if [[ $DELETE_PATTERN ]] && [[ $DELETE_BRANCHES ]]; then
  DELETE="(($DELETE_BRANCHES)|($DELETE_PATTERN))"
elif [[ $DELETE_PATTERN ]]; then
    DELETE=$DELETE_PATTERN
elif [[ $DELETE_BRANCHES ]]; then
    DELETE=$DELETE_BRANCHES
fi

if [[ $ALL ]]; then
  DELETE="$ALL"
fi

if [[ $CHECK ]]; then
  echo "EXCLUDE - $EXCLUDE";
  echo "DELETE - $DELETE";
  git branch | awk '{gsub(/^[ \t]+| [ \t]+$/,""); print $0 }' | egrep -v "$EXCLUDE" | egrep "$DELETE"
else
  # git branch | egrep -v "$DEFAULT" | awk '{gsub(/^[ \t]+| [ \t]+$/,""); print $0 }' | egrep "$REGEX" | xargs git branch -d
  git branch | awk '{gsub(/^[ \t]+| [ \t]+$/,""); print $0 }' | egrep -v "$EXCLUDE" | egrep "$DELETE" | xargs git branch -d
fi



