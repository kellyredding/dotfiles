__grb_completion() {
  local cmd=${COMP_WORDS[0]}
  local subcmd=${COMP_WORDS[1]}
  local cur=${COMP_WORDS[COMP_CWORD]}

  local cmds="help new pull push rm track"
  local branches=`ruby -e "puts %w{$(__git_refs)}.map{|w| w.sub(/^origin\//, '')}.uniq.sort"`

  case "$subcmd" in
    help)
      choices="$cmds"
      ;;
    new)
      choices="$branches"
      ;;
    pull)
      choices="$branches"
      ;;
    push)
      choices="$branches"
      ;;
    rm)
      choices="$branches"
      ;;
    track)
      choices="$branches"
      ;;
    *)
      choices="$cmds"
      ;;
  esac

  COMPREPLY=($(compgen -W "$choices" -- $cur))
  return 0
}

complete -o default -F __grb_completion grb
