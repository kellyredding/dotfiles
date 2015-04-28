# Set up a fancy pants prompt with colored pwd, ruby, and git info

# be sure to define the colors
if [ -f ~/.bash/colors.sh ]; then
    . ~/.bash/colors.sh

    PS1=""

    if [ -f ~/.bashrc ]; then                 # => if not on my development machine
      PS1=$PS1"\[$bldgrn\]\u@\h\[$txtrst\]:"  #    user@host: in green, bold
    fi

    PS1=$PS1"\[$bldylw\]\w\[$txtrst\]"        # => pwd (yellow, bold)

    PS1=$PS1'$(__git_ps1 "[\[$txtgrn\]%s\[$txtred\]%s\[$txtcyn\]%s\[$txtylw\]%s\[$txtrst\]]")'
                                              # => [in brackets]      (default color)...
                                              # => git branch name    (green)
                                              # => then stashstate    (red)
                                              # => then upstreamstate (cyan)
                                              # => then dirtystate    (yellow)

    PS1=$PS1'$(__rb_ps1  " \[$txtcyn\]%s\[$txtrst\]")'
                                              # => space, active ruby version (cyan)

    PS1=$PS1" \[$bldred\]\@\[$txtrst\]"       # => space, current time (bold red)

    PS1=$PS1"\[$txtrst\]\n\$ "                # => newline, dollar sign, space (default color)

    export PS1
fi
