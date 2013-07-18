__gem_completion() {
  local cmd=${COMP_WORDS[0]}
  local subcmd=${COMP_WORDS[1]}
  local cur=${COMP_WORDS[COMP_CWORD]}

  local cmds="help install list open"
  local gems=`ruby -rubygems -e 'puts Dir["{#{Gem::Specification.dirs.join(",")}}/*.gemspec"].collect {|s| File.basename(s).gsub(/\.gemspec$/, "")}'`

  case "$subcmd" in
    help)
      choices="$cmds"
      ;;
    install)
      choices="$gems"
      ;;
    list)
      choices="$gems"
      ;;
    open)
      choices="$gems"
      ;;
    *)
      choices="$cmds"
      ;;
  esac

  COMPREPLY=($(compgen -W "$choices" -- $cur))
  return 0
}

complete -o default -F __gem_completion gem
