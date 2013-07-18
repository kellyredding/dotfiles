# version manager: https://github.com/redding/rb#install

if command -v rb &>/dev/null; then
  eval "$(rb init --auto)"
fi

# rb status prompt stuff

if [ -f ~/.bash/scripts/rb-prompt-kellyredding.sh ]; then
  . ~/.bash/scripts/rb-prompt-kellyredding.sh
fi

# gem completion

if [ -f ~/.bash/scripts/gem-completion.sh ]; then
  . ~/.bash/scripts/gem-completion.sh
fi

# grb completion

if [ -f ~/.bash/scripts/grb-completion-kellyredding.sh ]; then
  . ~/.bash/scripts/grb-completion-kellyredding.sh
fi

export GEM_EDITOR="subl"
