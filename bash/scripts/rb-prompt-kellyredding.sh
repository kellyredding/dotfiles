# bash/zsh git prompt support
#
# Copyright (C) 2013 Kelly Redding <kelly@kellyredding.com>
# Distributed under the MIT LICENSE.
#
# This script allows you to see the active ruby version in your prompt.
# This assumes you use `rb`: https://github.com/redding/rb
#

__rb_ps1 ()
{
  local printf_format="${1}"
  local curr_version=$(rb status | tr "-" " " | tr " " "\n" | head -1)
  printf -- "$printf_format" "$curr_version"
}
