alias ls='ls -F'
alias la='ls -A'
alias l='ls -lhF'
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
alias cap="bx cap"
alias rake="bx rake"
alias jekyll="bx jekyll"
alias vagrant="bx vagrant"
alias guard="bx guard -i"
alias foreman="bx foreman"
alias assert="RUBY_GC_MALLOC_LIMIT=90000000 RUBY_FREE_MIN=200000 bx assert"
alias iassert="time __assert_individually"
alias sanford="bx sanford"
alias ardb="bx ardb"
alias dassets="bx dassets"

alias ghost="sudo ghost"
alias ghost-ssh="ghost-ssh"

alias tlog='mkdir -p log; touch log/development.log; tail -f log/development.log'
alias rst='touch tmp/restart.txt'

alias st='subl .'

alias readme='test -x `which redcarpet` && test -f ./README.md && redcarpet README.md > ~/.Trash/readme.html && open ~/.Trash/readme.html'

alias til='grep -d recurse -h `date "+%m/%d"` /usr/share/calendar/'
