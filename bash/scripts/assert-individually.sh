__assert_individually() {
  local i=0 total=$(assert -l $@ | wc -l | xargs)
  for file in $(assert -l $@); do
    ((i++))
    local cmd="bundle exec assert $file"
    echo "[$i/$total] $cmd"
    $cmd
    echo "==========="
    echo
  done
}
