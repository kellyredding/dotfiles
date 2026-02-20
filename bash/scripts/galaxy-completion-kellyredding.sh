#!/bin/bash

# Bash completion script for galaxy CLI
# https://github.com/kellyredding/galaxy

_galaxy_completion() {
    local cur prev words cword

    # Manual initialization (compatible without bash-completion package)
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    words=("${COMP_WORDS[@]}")
    cword=$COMP_CWORD

    # Galaxy's own commands (always available)
    local galaxy_commands="update help version"

    # Commands delegated to claude-persona
    local persona_commands="generate list show rename remove mcp"

    local mcp_commands="available list import import-all show remove"
    local update_commands="preview force help"

    # Galaxy flags (subset of claude-persona flags that Galaxy parses)
    local global_opts="--vibe --dry-run --print --resume --help --version -p -r -h -v"

    # Persona-specific flags (after a persona name)
    local persona_opts="--vibe --dry-run --resume --print -p -r"

    # Check if claude-persona is installed
    local has_cp=false
    command -v claude-persona &>/dev/null && has_cp=true

    # Get persona names dynamically (delegates to claude-persona)
    _galaxy_personas() {
        $has_cp || return
        claude-persona list 2>/dev/null | grep -E '^  [a-zA-Z0-9_-]+ \(' | sed 's/^  //' | cut -d' ' -f1
    }

    # Get imported MCP config names dynamically
    _galaxy_mcps() {
        $has_cp || return
        claude-persona mcp list 2>/dev/null | grep -E '^  [a-zA-Z0-9_-]+ \(' | sed 's/^  //' | cut -d' ' -f1
    }

    # Get available MCP names to import dynamically
    _galaxy_mcps_available() {
        $has_cp || return
        claude-persona mcp available 2>/dev/null | grep -E '^  [a-zA-Z0-9_-]+ \(' | sed 's/^  //' | cut -d' ' -f1
    }

    # Check if a word is a known command (Galaxy or delegated)
    _galaxy_is_command() {
        local word="$1"
        local all_commands="${galaxy_commands} ${persona_commands}"
        [[ " ${all_commands} " == *" ${word} "* ]]
    }

    case "${cword}" in
        1)
            if [[ "${cur}" == -* ]]; then
                COMPREPLY=($(compgen -W "${global_opts}" -- "${cur}"))
            else
                if $has_cp; then
                    local personas=$(_galaxy_personas)
                    COMPREPLY=($(compgen -W "${galaxy_commands} ${persona_commands} ${personas}" -- "${cur}"))
                else
                    COMPREPLY=($(compgen -W "${galaxy_commands}" -- "${cur}"))
                fi
            fi
            ;;
        2)
            case "${prev}" in
                show|remove)
                    local personas=$(_galaxy_personas)
                    COMPREPLY=($(compgen -W "${personas}" -- "${cur}"))
                    ;;
                rename)
                    local personas=$(_galaxy_personas)
                    COMPREPLY=($(compgen -W "${personas}" -- "${cur}"))
                    ;;
                mcp)
                    COMPREPLY=($(compgen -W "${mcp_commands}" -- "${cur}"))
                    ;;
                update)
                    COMPREPLY=($(compgen -W "${update_commands}" -- "${cur}"))
                    ;;
                generate)
                    if [[ "${cur}" == -* ]]; then
                        COMPREPLY=($(compgen -W "--dry-run" -- "${cur}"))
                    fi
                    ;;
                --resume|-r)
                    # User types UUID — no completion
                    COMPREPLY=()
                    ;;
                --print|-p)
                    # User types prompt — no completion
                    COMPREPLY=()
                    ;;
                list|help|version)
                    if [[ "${cur}" == -* ]]; then
                        COMPREPLY=($(compgen -W "${global_opts}" -- "${cur}"))
                    fi
                    ;;
                *)
                    # After a persona name — offer persona-specific flags
                    if [[ "${cur}" == -* ]]; then
                        COMPREPLY=($(compgen -W "${persona_opts}" -- "${cur}"))
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
                            local mcps=$(_galaxy_mcps)
                            COMPREPLY=($(compgen -W "${mcps}" -- "${cur}"))
                            ;;
                        import)
                            local mcps=$(_galaxy_mcps_available)
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
                    # Second arg to rename is the new name — no completion
                    COMPREPLY=()
                    ;;
                *)
                    # After persona + flag (e.g., galaxy dev --resume <uuid>)
                    if [[ "${prev}" == "--resume" || "${prev}" == "-r" ]]; then
                        COMPREPLY=()
                    elif [[ "${prev}" == "--print" || "${prev}" == "-p" ]]; then
                        COMPREPLY=()
                    elif [[ "${cur}" == -* ]]; then
                        COMPREPLY=($(compgen -W "${persona_opts}" -- "${cur}"))
                    fi
                    ;;
            esac
            ;;
        *)
            if [[ "${prev}" == "--resume" || "${prev}" == "-r" ]]; then
                COMPREPLY=()
            elif [[ "${prev}" == "--print" || "${prev}" == "-p" ]]; then
                COMPREPLY=()
            elif [[ "${cur}" == -* ]]; then
                COMPREPLY=($(compgen -W "${persona_opts}" -- "${cur}"))
            fi
            ;;
    esac

    return 0
}

# Register the completion function
complete -o default -F _galaxy_completion galaxy

# Register the completion function for aliases
complete -o default -F _galaxy_completion vibe
