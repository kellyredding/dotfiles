#!/bin/bash

# Bash completion script for backlog CLI
# https://github.com/MrLesk/Backlog.md/

_backlog_completion() {
    local cur prev words cword

    # Manual initialization (compatible without bash-completion package)
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    words=("${COMP_WORDS[@]}")
    cword=$COMP_CWORD

    # Main commands
    local main_commands="init task tasks draft board doc decision agents config cleanup browser help"

    # Global flags
    local global_flags="-v --version -h --help"

    # Subcommands for each main command
    local task_commands="create list edit view archive demote"
    local draft_commands="create archive promote view"
    local board_commands="view export"
    local doc_commands="create list view help"
    local decision_commands="create help"
    local config_commands="get set list help"

    # Flags for main commands
    local init_flags="-h --help"
    local task_flags="--plain -h --help"
    local draft_flags="--plain -h --help"
    local board_flags="-l --layout --vertical -h --help"
    local doc_flags="-h --help"
    local decision_flags="-h --help"
    local agents_flags="--update-instructions -h --help"
    local config_flags="-h --help"
    local cleanup_flags="-h --help"
    local browser_flags="-p --port --no-open -h --help"

    # Flags for task subcommands
    local task_create_flags="-d --description --desc -a --assignee -s --status -l --labels --priority --ac --acceptance-criteria --plan --notes --draft -p --parent --depends-on --dep -h --help"
    local task_list_flags="-s --status -a --assignee -p --parent --plain -h --help"
    local task_edit_flags="-t --title -d --description --desc -a --assignee -s --status -l --label --priority --add-label --remove-label --ac --acceptance-criteria --plan --notes --depends-on --dep -h --help"
    local task_view_flags="--plain -h --help"
    local task_archive_flags="-h --help"
    local task_demote_flags="-h --help"

    # Flags for draft subcommands
    local draft_create_flags="-d --description --desc -a --assignee -s --status -l --labels -h --help"
    local draft_archive_flags="-h --help"
    local draft_promote_flags="-h --help"
    local draft_view_flags="--plain -h --help"

    # Flags for board subcommands
    local board_view_flags="-l --layout --vertical -h --help"
    local board_export_flags="-o --output -h --help"

    # Flags for doc subcommands
    local doc_create_flags="-p --path -t --type -h --help"
    local doc_list_flags="--plain -h --help"
    local doc_view_flags="-h --help"

    # Flags for decision subcommands
    local decision_create_flags="-s --status -h --help"

    # Flags for config subcommands
    local config_get_flags="-h --help"
    local config_set_flags="-h --help"
    local config_list_flags="-h --help"

    # Priority values
    local priority_values="high medium low"

    # Layout values
    local layout_values="horizontal vertical"

    # Get the position of the main command
    local main_cmd=""
    local main_cmd_pos=1

    # Find the main command
    for ((i=1; i<cword; i++)); do
        case "${words[i]}" in
            init|task|tasks|draft|board|doc|decision|agents|config|browser|help)
                main_cmd="${words[i]}"
                main_cmd_pos=$i
                break
                ;;
        esac
    done

    # If no main command found, complete main commands and global flags
    if [[ -z "$main_cmd" ]]; then
        if [[ "$cur" == -* ]]; then
            COMPREPLY=($(compgen -W "$global_flags" -- "$cur"))
        else
            COMPREPLY=($(compgen -W "$main_commands" -- "$cur"))
        fi
        return 0
    fi

    # Handle completion based on main command
    case "$main_cmd" in
        init)
            if [[ "$cur" == -* ]]; then
                COMPREPLY=($(compgen -W "$init_flags" -- "$cur"))
            fi
            ;;

        task|tasks)
            # Check if we're completing a subcommand
            local subcmd=""
            local subcmd_pos=$((main_cmd_pos + 1))

            if [[ $subcmd_pos -lt $cword ]]; then
                case "${words[subcmd_pos]}" in
                    create|list|edit|view|archive|demote)
                        subcmd="${words[subcmd_pos]}"
                        ;;
                esac
            fi

            if [[ -z "$subcmd" ]]; then
                # Complete subcommands or task flags
                if [[ "$cur" == -* ]]; then
                    COMPREPLY=($(compgen -W "$task_flags" -- "$cur"))
                else
                    COMPREPLY=($(compgen -W "$task_commands" -- "$cur"))
                fi
            else
                # Complete flags for specific subcommand
                case "$subcmd" in
                    create)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$task_create_flags" -- "$cur"))
                        elif [[ "$prev" == "--priority" ]]; then
                            COMPREPLY=($(compgen -W "$priority_values" -- "$cur"))
                        fi
                        ;;
                    list)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$task_list_flags" -- "$cur"))
                        fi
                        ;;
                    edit)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$task_edit_flags" -- "$cur"))
                        elif [[ "$prev" == "--priority" ]]; then
                            COMPREPLY=($(compgen -W "$priority_values" -- "$cur"))
                        fi
                        ;;
                    view)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$task_view_flags" -- "$cur"))
                        fi
                        ;;
                    archive)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$task_archive_flags" -- "$cur"))
                        fi
                        ;;
                    demote)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$task_demote_flags" -- "$cur"))
                        fi
                        ;;
                esac
            fi
            ;;

        draft)
            # Check if we're completing a subcommand
            local subcmd=""
            local subcmd_pos=$((main_cmd_pos + 1))

            if [[ $subcmd_pos -lt $cword ]]; then
                case "${words[subcmd_pos]}" in
                    create|archive|promote|view)
                        subcmd="${words[subcmd_pos]}"
                        ;;
                esac
            fi

            if [[ -z "$subcmd" ]]; then
                # Complete subcommands or draft flags
                if [[ "$cur" == -* ]]; then
                    COMPREPLY=($(compgen -W "$draft_flags" -- "$cur"))
                else
                    COMPREPLY=($(compgen -W "$draft_commands" -- "$cur"))
                fi
            else
                # Complete flags for specific subcommand
                case "$subcmd" in
                    create)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$draft_create_flags" -- "$cur"))
                        fi
                        ;;
                    archive)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$draft_archive_flags" -- "$cur"))
                        fi
                        ;;
                    promote)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$draft_promote_flags" -- "$cur"))
                        fi
                        ;;
                    view)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$draft_view_flags" -- "$cur"))
                        fi
                        ;;
                esac
            fi
            ;;

        board)
            # Check if we're completing a subcommand
            local subcmd=""
            local subcmd_pos=$((main_cmd_pos + 1))

            if [[ $subcmd_pos -lt $cword ]]; then
                case "${words[subcmd_pos]}" in
                    view|export)
                        subcmd="${words[subcmd_pos]}"
                        ;;
                esac
            fi

            if [[ -z "$subcmd" ]]; then
                # Complete subcommands or board flags
                if [[ "$cur" == -* ]]; then
                    COMPREPLY=($(compgen -W "$board_flags" -- "$cur"))
                else
                    COMPREPLY=($(compgen -W "$board_commands" -- "$cur"))
                fi
            else
                # Complete flags for specific subcommand
                case "$subcmd" in
                    view)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$board_view_flags" -- "$cur"))
                        elif [[ "$prev" == "--layout" || "$prev" == "-l" ]]; then
                            COMPREPLY=($(compgen -W "$layout_values" -- "$cur"))
                        fi
                        ;;
                    export)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$board_export_flags" -- "$cur"))
                        else
                            # Complete filenames for export
                            COMPREPLY=($(compgen -f -- "$cur"))
                        fi
                        ;;
                esac
            fi
            ;;

        doc)
            # Check if we're completing a subcommand
            local subcmd=""
            local subcmd_pos=$((main_cmd_pos + 1))

            if [[ $subcmd_pos -lt $cword ]]; then
                case "${words[subcmd_pos]}" in
                    create|list|view|help)
                        subcmd="${words[subcmd_pos]}"
                        ;;
                esac
            fi

            if [[ -z "$subcmd" ]]; then
                # Complete subcommands or doc flags
                if [[ "$cur" == -* ]]; then
                    COMPREPLY=($(compgen -W "$doc_flags" -- "$cur"))
                else
                    COMPREPLY=($(compgen -W "$doc_commands" -- "$cur"))
                fi
            else
                # Complete flags for specific subcommand
                case "$subcmd" in
                    create)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$doc_create_flags" -- "$cur"))
                        elif [[ "$prev" == "--path" || "$prev" == "-p" ]]; then
                            COMPREPLY=($(compgen -f -- "$cur"))
                        fi
                        ;;
                    list)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$doc_list_flags" -- "$cur"))
                        fi
                        ;;
                    view)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$doc_view_flags" -- "$cur"))
                        fi
                        ;;
                esac
            fi
            ;;

        decision)
            # Check if we're completing a subcommand
            local subcmd=""
            local subcmd_pos=$((main_cmd_pos + 1))

            if [[ $subcmd_pos -lt $cword ]]; then
                case "${words[subcmd_pos]}" in
                    create|help)
                        subcmd="${words[subcmd_pos]}"
                        ;;
                esac
            fi

            if [[ -z "$subcmd" ]]; then
                # Complete subcommands or decision flags
                if [[ "$cur" == -* ]]; then
                    COMPREPLY=($(compgen -W "$decision_flags" -- "$cur"))
                else
                    COMPREPLY=($(compgen -W "$decision_commands" -- "$cur"))
                fi
            else
                # Complete flags for specific subcommand
                case "$subcmd" in
                    create)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$decision_create_flags" -- "$cur"))
                        fi
                        ;;
                esac
            fi
            ;;

        agents)
            if [[ "$cur" == -* ]]; then
                COMPREPLY=($(compgen -W "$agents_flags" -- "$cur"))
            fi
            ;;

        config)
            # Check if we're completing a subcommand
            local subcmd=""
            local subcmd_pos=$((main_cmd_pos + 1))

            if [[ $subcmd_pos -lt $cword ]]; then
                case "${words[subcmd_pos]}" in
                    get|set|list|help)
                        subcmd="${words[subcmd_pos]}"
                        ;;
                esac
            fi

            if [[ -z "$subcmd" ]]; then
                # Complete subcommands or config flags
                if [[ "$cur" == -* ]]; then
                    COMPREPLY=($(compgen -W "$config_flags" -- "$cur"))
                else
                    COMPREPLY=($(compgen -W "$config_commands" -- "$cur"))
                fi
            else
                # Complete flags for specific subcommand
                case "$subcmd" in
                    get)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$config_get_flags" -- "$cur"))
                        fi
                        ;;
                    set)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$config_set_flags" -- "$cur"))
                        fi
                        ;;
                    list)
                        if [[ "$cur" == -* ]]; then
                            COMPREPLY=($(compgen -W "$config_list_flags" -- "$cur"))
                        fi
                        ;;
                esac
            fi
                        ;;

        cleanup)
            if [[ "$cur" == -* ]]; then
                COMPREPLY=($(compgen -W "$cleanup_flags" -- "$cur"))
            fi
            ;;

        browser)
            if [[ "$cur" == -* ]]; then
                COMPREPLY=($(compgen -W "$browser_flags" -- "$cur"))
            fi
            ;;


        help)
            # Complete with all main commands for help
            COMPREPLY=($(compgen -W "$main_commands" -- "$cur"))
            ;;
    esac

    return 0
}

# Register the completion function
complete -o default -F _backlog_completion backlog

# Register the completion function for my alias
complete -o default -F _backlog_completion blog
