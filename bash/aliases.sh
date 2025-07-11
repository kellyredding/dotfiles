alias ls='ls -F'
alias la='ls -A'
alias ll='ls -lahF'
alias ..='cd ..'

alias plz='sudo $(history -p \!\!)'
alias path='echo -e ${PATH//:/\\\n}'
alias targz='tar xzvf'
alias reload='source ~/.bash_profile'
alias pwdc='pwd | pbcopy'
alias shrugc='echo "¯\_(ツ)_/¯" | pbcopy'
alias shrugcc='echo "¯\\\\\_(ツ)_/¯" | pbcopy'

alias irb="pry"
alias pry="pry --simple-prompt"
alias bx="bundle exec"
alias fs="foreman start --procfile Procfile.local"
alias dk="bx dk"
alias cap="bx cap"
alias rake="bx rake"
alias jekyll="bx jekyll"
alias assert="bx assert"
alias rspec="bx rspec"
alias rubocop="bx rubocop"
alias iassert="time __assert_individually"
alias urlc="urlcheck < ~/.urlcheck_urls"
alias sanford="bx sanford"
alias ardb="bx ardb"
alias dassets="bx dassets"

alias ghost="sudo ghost"
alias ghost-ssh="ghost-ssh"

alias tlog='mkdir -p log; touch log/development.log; tail -f log/development.log'
alias rst='touch tmp/restart.txt'

alias blog="backlog"
alias st='subl -n .'

alias readme='test -x `which redcarpet` && test -f ./README.md && redcarpet README.md > ~/.Trash/readme.html && open ~/.Trash/readme.html'

alias til='grep -d recurse -h `date "+%m/%d"` /usr/share/calendar/'
