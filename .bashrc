# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

#tells bash to append to ~/.bash_history any commands in the current terminal that aren't already in there.
#http://briancarper.net/blog/248/
#http://linuxcommando.blogspot.ie/2007/11/keeping-command-history-across-multiple.html
export PROMPT_COMMAND="history -a"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi

# Add colors for color prompt with git status/branch (From Dave)
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
DARKGREEN="\[\033[0;32m\]"
LIGHTGREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
WHITE="\[\033[00m\]"

if [ "$color_prompt" = yes ]; then
    PS1="$LIGHTGREEN\u@\h$WHITE:$BLUE\w$DARKGREEN\$(__git_ps1)$WHITE \$ "
else
    PS1='\u@\h:\w\$ '
fi

#For time you could add \@ to PS1
PS1="(\$(date +%H:%M:%S)) $PS1"

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# See http://askubuntu.com/questions/132977/how-to-get-global-application-menu-for-gvim 
# second solution http://askubuntu.com/a/132581
alias gvim="UBUNTU_MENUPROXY=0 gvim"

function svnlog() { 
	svn log "$*" | perl -pe 's/\n/ /g => s/^-.*/\n/g';
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#Install apache maven
export M2_HOME=/usr/local/apache-maven/apache-maven-3.0.4
export M2=$M2_HOME/bin
export PATH=$M2:$PATH

#Install the 32bit of java in order to compile java programs
#export JAVA_HOME=/opt/jdk-6u31-linux-i586/jdk1.6.0_31
export JAVA_HOME=/opt/jdk1.7.0_75
export PATH=$JAVA_HOME/bin:$PATH

#Install Coverity Scan Self-build, see https://scan.coverity.com/download
export COVERITY_SCAN=/opt/cov-analysis-linux64-6.6.1
export PATH=$COVERITY_SCAN/bin:$PATH

#Nvidia cuda
export PATH=/usr/local/cuda-5.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-5.0/lib:/usr/local/cuda-5.0/lib64:$LD_LIBRARY_PATH

#Add git-repo bin directory
export PATH=~/repo-bin:$PATH

# Add /usr/local/lib for directfb libraries
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

#Create a log for the sessions
# Record terminal sessions.
if [ "x$SESSION_RECORD" = "x" ]; then
timestamp=`date -u +%Y%m%d-%H%M%S`
output=/home/stavros/.session_logs/session.$timestamp.${HOSTNAME:-$(hostname)}.$USER.$$
SESSION_RECORD=started
export SESSION_RECORD
script -f -q $output
exit
fi

alias comlog="script -f -c \"picocom -b 115200 /dev/ttyUSB0\" ~/comlogs/\`date '+%y%m%d_%H:%M:%S'\`.log"

# Overide the default test harness parameters for irisplayer nosetests
export IRIS_TEST_SETTINGS=~/.iristest.json

#Update the .Xauthority file
#HOST=$(hostname)
#DEFAULTHOST=`cat /etc/hostname`
#AUTHTYPE="MIT-MAGIC-COOKIE-1"
#DEFAULTCOOKIE=`xauth list | grep $DEFAULTHOST | cut -d " " -f 5`
#xauth add "$HOST/unix$DISPLAY" $AUTHTYPE $DEFAULTCOOKIE
xhost local:root

#It cannot be stressed enough how important it is to use strong user passwords and passphrase for your keys. 
#Brute force attack works because you use dictionary based passwords. You can force users to avoid passwords 
#against a dictionary attack and use john the ripper tool to find out existing weak passwords. Here is a 
#sample random password generator (put in your ~/.bashrc).
#http://www.cyberciti.biz/tips/linux-unix-bsd-openssh-server-best-practices.html
function genpasswd() {
	local l=$1
       	[ "$l" == "" ] && l=20
      	tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

# Based on this http://stackoverflow.com/questions/13596531/how-to-search-for-non-ascii-characters-with-bash-tools
# Added the file and line
function nonascii() {
	LANG=C grep -Hn --color=always '[^ -~]\+';
}

# From https://github.com/alonho/nosecomplete/blob/master/README.md
# copied from newer versions of bash
__ltrim_colon_completions() {
    # If word-to-complete contains a colon,
    # and bash-version < 4,
    # or bash-version >= 4 and COMP_WORDBREAKS contains a colon
    if [[
        "$1" == *:* && (
            ${BASH_VERSINFO[0]} -lt 4 ||
            (${BASH_VERSINFO[0]} -ge 4 && "$COMP_WORDBREAKS" == *:*)
        )
    ]]; then
        # Remove colon-word prefix from COMPREPLY items
        local colon_word=${1%${1##*:}}
        local i=${#COMPREPLY[*]}
        while [ $((--i)) -ge 0 ]; do
            COMPREPLY[$i]=${COMPREPLY[$i]#"$colon_word"}
        done
    fi
} # __ltrim_colon_completions()

_nosetests()
{
    cur=${COMP_WORDS[COMP_CWORD]}
    if [[
            ${BASH_VERSINFO[0]} -lt 4 ||
            (${BASH_VERSINFO[0]} -ge 4 && "$COMP_WORDBREAKS" == *:*)
    ]]; then
        local i=$COMP_CWORD
        while [ $i -ge 0 ]; do
            [ "${COMP_WORDS[$((i--))]}" == ":" ] && break
        done
        if [ $i -gt 0 ]; then
            cur=$(printf "%s" ${COMP_WORDS[@]:$i})
        fi
    fi
    COMPREPLY=(`nosecomplete ${cur} 2>/dev/null`)
    __ltrim_colon_completions "$cur"
}
complete -o nospace -F _nosetests nosetests

