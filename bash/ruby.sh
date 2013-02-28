# version manager: https://github.com/redding/rb#install
if command -v rb &>/dev/null; then
  eval "$(rb init --auto)"
fi

# gem completion
if [ -f ~/.bash/scripts/gem-completion.rb ]; then
  complete -C ~/.bash/scripts/gem-completion.rb -o default gem
fi
