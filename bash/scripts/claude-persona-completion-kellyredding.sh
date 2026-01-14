#!/bin/bash

# Bash completion script for claude-persona
# https://github.com/kellyredding/claude-persona

_claude_persona_completion() {
    local cur prev words cword

    # Manual initialization (compatible without bash-completion package)
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    words=("${COMP_WORDS[@]}")
    cword=$COMP_CWORD

    local commands="list generate show rename remove mcp help version"
    local mcp_commands="available list import import-all show remove"
    local global_opts="--vibe --dangerously-skip-permissions --dry-run --resume --help --version -r -h -v"

    # Get persona names dynamically
    _claude_persona_personas() {
        claude-persona list 2>/dev/null | grep -E '^  [a-zA-Z0-9_-]+$' | sed 's/^  //'
    }

    # Get imported MCP config names dynamically
    _claude_persona_mcps() {
        claude-persona mcp list 2>/dev/null | grep -E '^  [a-zA-Z0-9_-]+ \(' | sed 's/^  //' | cut -d' ' -f1
    }

    # Get available MCP names to import dynamically
    _claude_persona_mcps_available() {
        claude-persona mcp available 2>/dev/null | grep -E '^  [a-zA-Z0-9_-]+ \(' | sed 's/^  //' | cut -d' ' -f1
    }

    case "${cword}" in
        1)
            if [[ "${cur}" == -* ]]; then
                COMPREPLY=($(compgen -W "${global_opts}" -- "${cur}"))
            else
                local personas=$(_claude_persona_personas)
                COMPREPLY=($(compgen -W "${commands} ${personas}" -- "${cur}"))
            fi
            ;;
        2)
            case "${prev}" in
                show|remove)
                    local personas=$(_claude_persona_personas)
                    COMPREPLY=($(compgen -W "${personas}" -- "${cur}"))
                    ;;
                rename)
                    local personas=$(_claude_persona_personas)
                    COMPREPLY=($(compgen -W "${personas}" -- "${cur}"))
                    ;;
                mcp)
                    COMPREPLY=($(compgen -W "${mcp_commands}" -- "${cur}"))
                    ;;
                --resume|-r)
                    COMPREPLY=()
                    ;;
                list|generate|help|version)
                    if [[ "${cur}" == -* ]]; then
                        COMPREPLY=($(compgen -W "${global_opts}" -- "${cur}"))
                    fi
                    ;;
                *)
                    if [[ "${cur}" == -* ]]; then
                        COMPREPLY=($(compgen -W "${global_opts}" -- "${cur}"))
                    fi
                    ;;
            esac
            ;;
        3)
            local cmd="${words[1]}"
            local subcmd="${words[2]}"

            case "${cmd}" in
                mcp)
                    case "${subcmd}" in
                        show|remove)
                            local mcps=$(_claude_persona_mcps)
                            COMPREPLY=($(compgen -W "${mcps}" -- "${cur}"))
                            ;;
                        import)
                            local mcps=$(_claude_persona_mcps_available)
                            COMPREPLY=($(compgen -W "${mcps}" -- "${cur}"))
                            ;;
                        *)
                            if [[ "${cur}" == -* ]]; then
                                COMPREPLY=($(compgen -W "${global_opts}" -- "${cur}"))
                            fi
                            ;;
                    esac
                    ;;
                rename)
                    COMPREPLY=()
                    ;;
                *)
                    if [[ "${cur}" == -* ]]; then
                        COMPREPLY=($(compgen -W "${global_opts}" -- "${cur}"))
                    fi
                    ;;
            esac
            ;;
        *)
            if [[ "${cur}" == -* ]]; then
                COMPREPLY=($(compgen -W "${global_opts}" -- "${cur}"))
            fi
            ;;
    esac

    return 0
}

# Register the completion function
complete -o default -F _claude_persona_completion claude-persona

# Register the completion function for my aliases
complete -o default -F _claude_persona_completion persona
complete -o default -F _claude_persona_completion vibe
