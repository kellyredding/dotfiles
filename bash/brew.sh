# Ensure brew is always in PATH early - use dynamic discovery
if command -v brew &> /dev/null; then
  BREW_PREFIX="$(brew --prefix)"
  export PATH="${BREW_PREFIX}/bin:$PATH"

  # Set up git pager with diff-highlight dynamically
  DIFF_HIGHLIGHT="${BREW_PREFIX}/share/git-core/contrib/diff-highlight/diff-highlight"
  if [[ -f "${DIFF_HIGHLIGHT}" ]]; then
    git config --global core.pager "${DIFF_HIGHLIGHT} | less -R"
  fi

  # Then source bash-completion
  # brew install bash-completion@2
  if [[ -r "${BREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${BREW_PREFIX}/etc/profile.d/bash_completion.sh"
  fi
fi
