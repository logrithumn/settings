#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#DEFAULTS
alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
#END DEFAULTS


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

parse_git_branch ()
{
  local GITDIR=`git rev-parse --show-toplevel 2>&1` # Get root directory of git repo
  if [[ "$GITDIR" != '/koc' ]] # Don't show status of home directory repo
  then
    # Figure out the current branch, wrap in brackets and return it
    local BRANCH=`git branch 2>/dev/null | sed -n '/^\*/s/^\* //p'`
    if [ -n "$BRANCH" ]; then
      echo -e "($BRANCH)"
    fi
  else
    echo ""
  fi
}

function git_color ()
{
  # Get the status of the repo and chose a color accordingly
  local STATUS=`git status 2>&1`
  #echo `git status 2>&1`
  if [[ "$STATUS" == *'Not a git repository'* ]]
  then
    echo ""
  else
    if [[ "$STATUS" != *'working tree clean'* ]]
      then
        # red if need to commit
        echo -e '\033[0;31m'
    else
      if [[ "$STATUS" == *'Your branch is ahead'* ]]
        then
          # yellow if need to push
          echo -e '\033[0;33m'
      else
        # else cyan
        echo -e '\033[0;36m'
      fi
    fi
  fi
}

# Call the above functions inside the PS1 declaration

export PS1='\[\033[32m\]\
[$(date +%I:%M:%S)]\
[ \w]\
\[$(git_color)\]$(parse_git_branch)\[\033[32m\]\
\n\
[\[\e[1m\]\u\[\e[21m\]@\h]\
\[\e[0m\] λ \[\033[32m\]\
/> \[\e[0m\]'
#PS2='\[\033[32m\]'
