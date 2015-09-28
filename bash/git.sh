# git completion

if [ -f ~/.bash/scripts/git-completion.sh ]; then
  . ~/.bash/scripts/git-completion.sh
fi

# git prompt stuff

if [ -f ~/.bash/scripts/git-prompt-kellyredding.sh ]; then
  . ~/.bash/scripts/git-prompt-kellyredding.sh
fi
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUPSTREAM=true

# git diff utils

function git_strip_diff_leading_symbols() {
  color_code_regex="(\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K])"

  # simplify the unified patch diff header
  gsed -r "s/^($color_code_regex)diff --git .*$//g" | \
    gsed -r "s/^($color_code_regex)index .*$/\n\1$(git_horz_rule)/g" | \
    gsed -r "s/^($color_code_regex)\+\+\+(.*)$/\1+++\5\n\1$(git_horz_rule)\x1B\[m/g" | \

  # actually strips the leading symbols
    gsed -r "s/^($color_code_regex)[\+\-]/\1 /g"
}

function git_horz_rule() {
  printf "%$(tput cols)s\n"|tr " " "─"
}
