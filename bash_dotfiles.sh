# home bin path
if [ -d "$HOME/.bin" ]; then
  export PATH="$HOME/.bin:$PATH"
fi

# /opt/kellyredding bin path
if [ -d "/opt/kellyredding/bin" ]; then
  export PATH="/opt/kellyredding/bin:$PATH"
fi

# Mise Node LTS bin path
if [ -d "$HOME/.local/share/mise/installs/node/lts/bin" ]; then
  export PATH="$HOME/.local/share/mise/installs/node/lts/bin:$PATH"
fi

# start new shells in last used dir
# export PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"

# disable Homebrew auto updates
export HOMEBREW_NO_AUTO_UPDATE=1

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

# Postgres.app stuff
# - chpg init
if [ -f ~/.bash/postgres-app.sh ]; then
  . ~/.bash/postgres-app.sh
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
