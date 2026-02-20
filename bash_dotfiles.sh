# home bin paths
if [ -d "$HOME/.bin" ]; then
  export PATH="$HOME/.bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# mise shims (for tools like crystal)
if [ -d "$HOME/.local/share/mise/shims" ]; then
  export PATH="$HOME/.local/share/mise/shims:$PATH"
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

# Brew stuff
if [ -f ~/.bash/brew.sh ]; then
  . ~/.bash/brew.sh
fi

# Git stuff
# - command auto complete
# - ps1 helpers
if [ -f ~/.bash/git.sh ]; then
  . ~/.bash/git.sh
fi

# Backlog stuff
# - command auto complete
if [ -f ~/.bash/backlog.sh ]; then
  . ~/.bash/backlog.sh
fi

# Claude Persona stuff
# - command auto complete
if [ -f ~/.bash/claude-persona.sh ]; then
  . ~/.bash/claude-persona.sh
fi

# Galaxy stuff
# - command auto complete
if [ -f ~/.bash/galaxy.sh ]; then
  . ~/.bash/galaxy.sh
fi

# Ruby stuff
# - rb init
# - gem completion
if [ -f ~/.bash/ruby.sh ]; then
  . ~/.bash/ruby.sh
fi

# Yarn stuff
# - command auto complete
if [ -f ~/.bash/yarn.sh ]; then
  . ~/.bash/yarn.sh
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
