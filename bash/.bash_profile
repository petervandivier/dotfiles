# https://superuser.com/q/478926/457020
source ~/.bashrc

# https://natelandau.com/my-mac-osx-bash_profile/
#PS1="\n[\D{%m%d %T%z} \w]$ "
export PGDATA=/usr/local/var/postgres
export GREP_OPTIONS='--color=always' 
export GOPATH=~/dev/go/
export PATH=$PATH:/Users/pvandivier/dev/go/bin/
export BASH_SILENCE_DEPRECATION_WARNING=1
# https://stackoverflow.com/a/32417011/4709762
export FIGNORE="$FIGNORE:DS_Store"
# https://topanswers.xyz/nix?q=1425#a1676
export HISTTIMEFORMAT='%FT%T%z '

# remove to restore LibreSSL 2.8.3 @ /usr/bin/openssl
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/Users/pvandivier/.chefdk/gem/ruby/2.6.0/bin:$PATH"
# For compilers to find openssl@1.1 you may need to set:
#   export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
#   export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
# For pkg-config to find openssl@1.1 you may need to set:
#   export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

# https://stackoverflow.com/questions/36356778/how-to-let-pyenv-to-find-installed-python-versions
# https://github.com/pyenv/pyenv/issues/622
# eval "$(pyenv init -)"

yk_rm_ssh() {
    if [ "$( ssh-add -l | grep /usr/local/lib/opensc-pkcs11.so)" != "" ]; then
        ssh-add -e /usr/local/lib/opensc-pkcs11.so
    fi
}

# https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html#:~:text=dotglob
alias ll='ls -halp'
alias pg_start='pg_ctl start'
alias pg_stop='pg_ctl stop'
alias gsl='git log --pretty=oneline --abbrev-commit'
alias kd='kitchen destroy'
alias kc='kitchen converge'
alias kl='kitchen login'
alias kli='kitchen list'
alias please='sudo'
alias jfdi='sudo $(fc -ln -1)'
# tab-complete "y+k+r+<tab>" rather than "y+k+<shift>+<dash>+k+<tab>"
# still going to define the function with underscores in the name though 
#   because i like it better that way
alias ykrmssh=yk_rm_ssh
alias yrm='ykrmssh'
alias ykaddssh='ykrmssh; ssh-add -s /usr/local/lib/opensc-pkcs11.so'
alias yas='ykaddssh'
alias cx='chmod +x '
# Danger SHell
# https://stackoverflow.com/a/3664010/4709762
alias dsh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no '
alias dcp='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no '
alias grph='git rev-parse --short HEAD'
alias grphl='git rev-parse HEAD'
alias gpsuo='git push --set-upstream origin'
# https://topanswers.xyz/nix?q=888#a1059
# https://topanswers.xyz/nix?q=915#a1078
jq_leaf_paths='paths(.==null or scalars) | map(if type == "number" then "[\(tostring)]" elif test("[^a-zA-Z0-9_]") then ".\"\(.)\"" else "."+. end) | join("")'
alias jqlp="jq '$jq_leaf_paths'"
# one-pass but quote-formatting is wrong
# jq -S | jq 'paths(.==null or scalars) as $path | getpath($path) as $v | $path | map(if type == "number" then "[\(tostring)]" else "."+. end) | join("") | .+"="+($v|tostring)'
# raw path-as-array + node-value
# jq -S | jq -c 'paths(.==null or scalars) as $path | getpath($path) as $v | $path | .+[$v]'
alias clip='pbcopy'
alias psc='pwsh -NoLogo'

alias chrome="open -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
# https://gist.github.com/hernamesbarbara/1937937

# Readline, the line editing library that bash uses, does not know
# that the terminal escape sequences do not take up space on the
# screen. The redisplay code assumes, unless told otherwise, that
# each character in the prompt is a `printable' character that
# takes up one character position on the screen. 

# You can use the bash prompt expansion facility (see the PROMPTING
# section in the manual page) to tell readline that sequences of
# characters in the prompt strings take up no screen space. 

# Use the \[ escape to begin a sequence of non-printing characters,
# and the \] escape to signal the end of such a sequence.
# Define some colors first:
RED='\[\e[1;31m\]'
BOLDYELLOW='\[\e[1;33m\]'
GREEN='\[\e[0;32m\]'
BLUE='\[\e[1;34m\]'
DARKBROWN='\[\e[1;33m\]'
DARKGRAY='\[\e[1;30m\]'
LIGHTGRAY='\[\e[1;30m\]'
LIGHTGREEN='\[\e[1;32m\]'
LIGHTBLUE="\[\033[1;36m\]"
PURPLE='\[\e[1;35m\]' 
NC='\[\e[0m\]' # No Color

#function parse_git_dirty {
#  git diff --quiet HEAD &>/dev/null
#  [[ $? == 1 ]] && echo "⚡"
#}

#function parse_git_branch {
#  local branch=$(__git_ps1 "%s")
#  [[ $branch ]] && echo "[$branch$(parse_git_dirty)]"
#}

PS1="${LIGHTBLUE}\\D{%Y-%m-%d %T%z} ${BLUE}\u${NC}@${GREEN}\h${NC}:${BOLDYELLOW}\\W ${PURPLE}\$(parse_git_branch)\n${LIGHTGREEN}$ ${NC}"

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export parse_git_branch

# Safe rm procedure
safe_rm()
{
    # Cycle through each argument for deletion
    for file in $*; do
        if [ -e $file ]; then

            # Target exists and can be moved to Trash safely
            if [ ! -e ~/.Trash/$file ]; then
                mv $file ~/.Trash

            # Target exists and conflicts with target in Trash
            elif [ -e ~/.Trash/$file ]; then

                # Increment target name until 
                # there is no longer a conflict
                i=1
                while [ -e ~/.Trash/$file.$i ];
                do
                    i=$(($i + 1))
                done

                # Move to the Trash with non-conflicting name
                mv $file ~/.Trash/$file.$i
            fi

        # Target doesn't exist, return error
        else
            echo "rm: $file: No such file or directory";
        fi
    done
}

function github() {
  #call from a local repo to open the repository on github in browser
  giturl=$(git config --get remote.origin.url)
  if [ "$giturl" == "" ]
    then
     echo "Not a git repository or no remote.origin.url set"
     exit 1;
  fi
  giturl=${giturl/git\@github\.com\:/https://github.com/}
  giturl=${giturl/\.git//}
  echo $giturl
  open $giturl
}

#bash git completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
