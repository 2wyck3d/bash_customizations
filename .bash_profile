# get git branch
parse_git_branch() {
#  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    GIT_STATUS=$(git status 2> /dev/null | head -n 1)

    SEARCH_STRING="On branch "

    GIT_BRANCH=${GIT_STATUS#*$SEARCH_STRING}

    if [[ ! -z "$GIT_BRANCH" ]]; then
        echo " ($GIT_BRANCH)"
    fi
}

# get git status
get_git_status() {
    GIT_STATUS=$(git status 2> /dev/null)

    if [[ $GIT_STATUS =~ "nothing to commit" ]]; then
        # set to green
        echo 32
    else
        # set to red
        echo 31
    fi

    unset GIT_STATUS
}

# set the prompt style
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;$(get_git_status)m\]$(parse_git_branch)\[\033[00m\]\$'

# define aliases
# OS specific aliases since linux options are not the same as macOS options
if [[ $(uname -s) == Darwin ]]; then
    alias ls='ls -lhG'
    alias la='ls -alhG'
else
    alias ls='ls -lh --color'
    alias la='ls -alh --color'
fi
