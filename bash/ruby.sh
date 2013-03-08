# version manager: https://github.com/redding/rb#install

if command -v rb &>/dev/null; then
  eval "$(rb init --auto)"
fi

# rb status prompt stuff

if [ -f ~/.bash/scripts/rb-prompt-kellyredding.sh ]; then
  . ~/.bash/scripts/rb-prompt-kellyredding.sh
fi

# gem completion

if [ -f ~/.bash/scripts/gem-completion.rb ]; then
  complete -C ~/.bash/scripts/gem-completion.rb -o default gem
fi
