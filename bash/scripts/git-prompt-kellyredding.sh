# bash/zsh git prompt support
#
# Copyright (C) 2013 Kelly Redding <kelly@kellyredding.com>
# Distributed under the MIT LICENSE.
#
# This script allows you to see the current branch in your prompt.
#
# To enable:
#
#    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
#    2) Add the following line to your .bashrc/.zshrc:
#        source ~/.git-prompt.sh
#    3a) Change your PS1 to call __git_ps1 as
#        command-substitution:
#        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
#        ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
#        the optional argument will be used as format string.
#
# The argument to __git_ps1 will be displayed only if you are currently
# in a git repository.  The %s token will be the name of the current
# branch.
#
# In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty value,
# changes (*) will be shown next to the branch name.
#
# You can also see if currently something is stashed, by setting
# GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is stashed,
# then a '^' will be shown next to the branch name.
#
# If you would like to see the difference between HEAD and its upstream,
# set GIT_PS1_SHOWUPSTREAM to a nonempty value.  A "<" indicates you are
# behind, ">" indicates you are ahead, "<>" indicates you have diverged
# and "=" indicates that there is no difference.
#
# If you would like to see more information about the identity of
# commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
# to one of these values:
#
#     contains      relative to newer annotated tag (v1.6.3.2~35)
#     branch        relative to newer tag or branch (master~4)
#     describe      relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
#     default       exactly matching tag


# __gitdir accepts 0 or 1 arguments (i.e., location)
# returns location of .git repo
__gitdir ()
{
  # Note: this function is duplicated in git-completion.bash
  # When updating it, make sure you update the other one to match.
  if [ -z "${1-}" ]; then
    if [ -n "${__git_dir-}" ]; then
      echo "$__git_dir"
    elif [ -n "${GIT_DIR-}" ]; then
      test -d "${GIT_DIR-}" || return 1
      echo "$GIT_DIR"
    elif [ -d .git ]; then
      echo .git
    else
      git rev-parse --git-dir 2>/dev/null
    fi
  elif [ -d "$1/.git" ]; then
    echo "$1/.git"
  else
    echo "$1"
  fi
}

# stores the divergence from upstream in $p
# used by GIT_PS1_SHOWUPSTREAM
__git_ps1_show_upstream ()
{
  # Find how many commits we are ahead/behind our upstream
  # ""      : no upstream
  # "0 {N}" : ahead of upstream
  # "{N} 0" : behind upstream
  # "0 0"   : equal to upstream
  local counts="$(git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)"
  local ahead_count=""
  local behind_count=""

  [[ "$counts" =~ (^[0-9]+) ]] && behind_count="${BASH_REMATCH[1]}"
  [[ "$counts" =~ ([0-9]+$) ]] && ahead_count="${BASH_REMATCH[1]}"

  # build the result
  p=""
  if [[ $behind_count == "" ]] && [[ $ahead_count == "" ]]; then
    p+="" # no upstream
  elif [[ $behind_count == "0" ]] && [[ $ahead_count == "0" ]]; then
    p+="=" # equal to upstream
  else
    [[ $behind_count != "0" ]] && p+="<" # behind upstream
    [[ $ahead_count  != "0" ]] && p+=">" # ahead upstream
    # diverged if both behind and ahead
  fi
}


# stores the state of the working directory in $s
# used by GIT_PS1_SHOWSTASHSTATE
__git_ps1_show_stashstate ()
{
  git rev-parse --verify refs/stash >/dev/null 2>&1 && s="^"
}


# stores the state of the working directory in $w
# used by GIT_PS1_SHOWDIRTYSTATE
__git_ps1_show_dirtystate ()
{
  # clean, by default
  w=""
  if git rev-parse --quiet --verify HEAD >/dev/null; then
    # added files
    git diff-index --cached --quiet HEAD -- || w="+"
  else
    # initial commit (no HEAD)
    w="#"
  fi

  local dirty=""
  # changed files
  git diff --no-ext-diff --quiet --exit-code || dirty="*"
  # untracked files
  if [ -n "$(git ls-files --others --exclude-standard)" ]; then
    dirty="*"
  fi

  w+="$dirty"
}


# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
# when called from PS1 using command substitution
# in this mode it prints text to add to bash PS1 prompt (includes branch name)
__git_ps1 ()
{
  case "$#" in
    1)  printf_format="${1}" #:-$printf_format}"
    ;;
    *)  return
    ;;
  esac

  local detached=no
  local g="$(__gitdir)"

  if [ -n "$g" ]; then
    local r=""
    local b=""
    local p=""
    local s=""
    local w=""
    if [ -f "$g/rebase-merge/interactive" ]; then
      r="|REBASE-i"
      b="$(cat "$g/rebase-merge/head-name")"
    elif [ -d "$g/rebase-merge" ]; then
      r="|REBASE-m"
      b="$(cat "$g/rebase-merge/head-name")"
    else
      if [ -d "$g/rebase-apply" ]; then
        if [ -f "$g/rebase-apply/rebasing" ]; then
          r="|REBASE"
        elif [ -f "$g/rebase-apply/applying" ]; then
          r="|AM"
        else
          r="|AM/REBASE"
        fi
      elif [ -f "$g/MERGE_HEAD" ]; then
        r="|MERGING"
      elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
        r="|CHERRY-PICKING"
      elif [ -f "$g/BISECT_LOG" ]; then
        r="|BISECTING"
      fi

      b="$(git symbolic-ref HEAD 2>/dev/null)" || {
        detached=yes
        b="$(
        case "${GIT_PS1_DESCRIBE_STYLE-}" in
        (contains)
          git describe --contains HEAD ;;
        (branch)
          git describe --contains --all HEAD ;;
        (describe)
          git describe HEAD ;;
        (* | default)
          git describe --tags --exact-match HEAD ;;
        esac 2>/dev/null)" ||

        b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
        b="unknown"
        b="($b)"
      }
    fi

    if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
      if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
        c="BARE:"
      else
        b="GIT_DIR!"
      fi
    elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
      if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
        __git_ps1_show_dirtystate # store dirtystate in $w
      fi
      if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
        __git_ps1_show_stashstate # store stashstate in $s
      fi
      if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
        __git_ps1_show_upstream # store upstream divergence in $p
      fi
    fi

    # print out the branch name, the upstream divergence, and the dirty state
    printf -- "$printf_format" "$c${b##refs/heads/}$r" "$s" "$p" "$w"
  fi
}
