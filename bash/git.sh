# git completion

if [ -f ~/.bash/scripts/git-completion.sh ]; then
  . ~/.bash/scripts/git-completion.sh
fi

# git prompt stuff

if [ -f ~/.bash/scripts/git-prompt-kellyredding.sh ]; then
  . ~/.bash/scripts/git-prompt-kellyredding.sh
fi

# backlog completion: https://github.com/MrLesk/Backlog.md/

if [ -f ~/.bash/scripts/backlog-completion-kellyredding.sh ]; then
  . ~/.bash/scripts/backlog-completion-kellyredding.sh
fi

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUPSTREAM=true
