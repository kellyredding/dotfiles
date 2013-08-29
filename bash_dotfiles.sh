# home bin path
if [ -d "$HOME/.bin" ]; then
  export PATH="$HOME/.bin:$PATH"
fi

export PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"

# Color definitions
if [ -f ~/.bash/colors.sh ]; then
  . ~/.bash/colors.sh
fi

# Git stuff
# - command auto complete
# - ps1 helpers
if [ -f ~/.bash/git.sh ]; then
  . ~/.bash/git.sh
fi

# Ruby stuff
# - rb init
# - gem completion
if [ -f ~/.bash/ruby.sh ]; then
  . ~/.bash/ruby.sh
fi

# Python stuff
# - pythonrc
if [ -f ~/.bash/python.sh ]; then
  . ~/.bash/python.sh
fi

# Aliases
if [ -f ~/.bash/aliases.sh ]; then
  . ~/.bash/aliases.sh
fi

# Custom PS1
if [ -f ~/.bash/ps1.sh ]; then
  . ~/.bash/ps1.sh
fi

# Sublime Text 2 editor
#if [ -f "/usr/local/bin/subl" ]; then
#  export EDITOR="/usr/local/bin/subl"
#fi

