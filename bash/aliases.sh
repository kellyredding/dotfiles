alias ls='ls -F'
alias la='ls -A'
alias ll='ls -lahF'
alias ..='cd ..'

alias cat="bat"

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
alias dk="bx dk"
alias cap="bx cap"
alias rake="bx rake"
alias jekyll="bx jekyll"
alias foreman="bx foreman"
alias assert="bx assert"
alias iassert="time __assert_individually"
alias urlc="urlcheck < ~/.urlcheck_urls"
alias sanford="bx sanford"
alias ardb="bx ardb"
alias dassets="bx dassets"

alias cop="__cop"
alias copf="__copf"
alias copp="__copp"
alias copac="__copac"

alias ghost="sudo ghost"
alias ghost-ssh="ghost-ssh"

alias tlog='mkdir -p log; touch log/development.log; tail -f log/development.log'
alias rst='touch tmp/restart.txt'

alias st='subl .'

alias readme='test -x `which redcarpet` && test -f ./README.md && redcarpet README.md > ~/.Trash/readme.html && open ~/.Trash/readme.html'

alias til='grep -d recurse -h `date "+%m/%d"` /usr/share/calendar/'

# legacy REE for El Capitan gem compilation
alias reebundle="CFLAGS=\"-O2 -fno-tree-dce -fno-optimize-sibling-calls\" bundle"
alias reegem="CFLAGS=\"-O2 -fno-tree-dce -fno-optimize-sibling-calls\" gem"
