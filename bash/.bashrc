# https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html

export HISTSIZE=100000
# https://stackoverflow.com/a/19454838/4709762
export HISTFILESIZE=100000
# https://askubuntu.com/a/15929/945760
export HISTCONTROL=ignoredups:erasedups

# https://opensource.com/article/19/5/python-3-default-mac
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
