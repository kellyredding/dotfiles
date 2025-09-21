#!/usr/bin/env bash
# Yarn package.json scripts completion
#
# Assumptions / dependencies:
#   - Bash >= 4 (tested with Bash 5.2 on macOS)
#       macOS ships with Bash 3.x by default. To install a modern Bash via Homebrew:
#
#         brew install bash
#
#       Then add it to the list of allowed shells (safer method):
#
#         echo /usr/local/bin/bash | sudo tee -a /etc/shells
#
#       Finally, set it as your default login shell:
#
#         chsh -s /usr/local/bin/bash
#
#   - bash-completion@2 (provides helpers like _get_comp_words_by_ref and __ltrim_colon_completions)
#       Install via Homebrew:
#
#         brew install bash-completion@2
#
#       Then source it in your ~/.bash_profile or ~/.bashrc:
#
#         if [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]]; then
#           source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
#         fi
#
# Notes:
#   - This script only completes Yarn scripts found in the nearest package.json
#     (walking up parent directories if necessary).
#   - Handles colons in script names correctly.
#   - Avoids trailing slashes and extra spaces after completion.

_yarn_completion() {
  local cur pkgfile dir scripts_raw wordlist

  # Use bash-completion helpers if available
  if declare -F _get_comp_words_by_ref >/dev/null 2>&1; then
    _get_comp_words_by_ref -n : cur || cur="${COMP_WORDS[COMP_CWORD]}"
  else
    cur="${COMP_WORDS[COMP_CWORD]}"
  fi

  # Find nearest package.json
  dir="$(pwd)"
  pkgfile=""
  while [[ -n "$dir" && "$dir" != "/" ]]; do
    if [[ -f "$dir/package.json" ]]; then
      pkgfile="$dir/package.json"
      break
    fi
    dir="$(dirname "$dir")"
  done

  if [[ -n "$pkgfile" ]]; then
    if command -v jq >/dev/null 2>&1; then
      scripts_raw=$(jq -r '.scripts // {} | keys[]' "$pkgfile" 2>/dev/null)
    else
      scripts_raw=$(grep -o -E '"[^"]+":' "$pkgfile" | sed 's/^"\(.*\)":$/\1/' | uniq)
    fi

    wordlist="$(printf '%s\n' "$scripts_raw" | tr '\n' ' ')"
    COMPREPLY=( $(compgen -W "$wordlist" -- "$cur") )

    # Trim any colon prefix if helpers are available
    if declare -F __ltrim_colon_completions >/dev/null 2>&1; then
      __ltrim_colon_completions "$cur"
    fi
  else
    COMPREPLY=()
  fi

  # Prevent Bash from inserting a space after completion
  compopt -o nospace 2>/dev/null
}

# Register completion
complete -o nospace -F _yarn_completion yarn
