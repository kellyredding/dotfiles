# Ensure brew is always in PATH early
export PATH="/opt/homebrew/bin:$PATH"

# Then source bash-completion
# brew install bash-completion@2
if [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]]; then
  source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi
