# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty)) /"
}
export PS1='\u@\h \[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(parse_git_branch)\$ '
    ;;
*)
    PS1='\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
#if [ "$TERM" != "dumb" ]; then
#    eval "`dircolors -b`"
#alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
#fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export EDITOR=emacs

export RUBYLIB=$RUBYLIB:/home/emarinel/hg/controller/lib:/var/lib/gems/1.8/gems/log4r-1.0.5/src:/var/lib/gems/1.8/gems/amazon-ec2-0.3.1/lib:/Library/Ruby/Gems/1.8/gems/twitter4r-0.3.0:/Library/Ruby/Gems/1.8/gems/schleyfox-peach-0.3/:/opt/local/lib/ruby/gems/1.8/gems/mongo_mapper-0.9.1/lib

export GROOVY_HOME=/usr/share/groovy

export PATH=$PATH:~/hadoop/hadoop-0.18.0/bin:/opt/local/bin:/usr/local/smlnj-110.68/bin:/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin:/Developer/usr/llvm-gcc-4.2/bin:/Applications/Twelf/bin:~/android/tools

export PATH=$PATH:/Applications/sshfs/bin
export PATH=$PATH:~/bin
export PATH=$PATH:/Applications/MATLAB_R2008a/bin/matlab
export PATH=$PATH:/Users/emarinel/android/platforms/android-1.1/tools
export PATH=$PATH:/Users/emarinel/Programming/depot_tools
export PATH=$PATH:/Applications/JFig3-Launcher.app/Contents/Resources
export PATH=$PATH:~/jruby-1.3.1/bin

#export JAVA_HOME=/Library/Java/Home
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home

export CVSROOT=cvs.pdl.cmu.edu:/cvs
export CVS_RSH=ssh

function fp() { ssh -t fix.ece.cmu.edu "ssh fp$@.pdl.cmu.local" ; }
#function fp() { ssh -t onionpowder.ece.cmu.edu "ssh fp$@.pdl.cmu.local" ; }

function ss() { ssh -t fix.ece.cmu.edu "ssh ss$@.pdl.cmu.local" ; }
#function ss() { ssh -t onionpowder.ece.cmu.edu "ssh ss$@.pdl.cmu.local" ; }

export SCALA_HOME=/opt/local/share/scala

alias oldbox='ssh emarinelli@emarinelli-t54x64'
alias emlinux='ssh emarinelli@emarinelli-linux'

export PATH=$PATH:/opt/subversion/bin

alias supple='ssh eugeneiiim@ssh.supplelabs.com'
alias supple_website='ssh supplelabs_supplelabs@ssh.phx.nearlyfreespeech.net'
export AKKA_HOME=/Users/emarinel/Programming/akka

export PATH=$PATH:/Users/emarinelli/android/tools:/Users/emarinelli/android/platform-tools:~/.gem/ruby/1.8/bin:/Library/PostgreSQL/9.0/bin:~/scala-2.9.1.final/bin:/Users/emarinelli/Downloads/gwt-2.3.0

export PATH=$PATH:~/mongo/bin
export PATH=$PATH:~/QtSDK/Desktop/Qt/4.8.0/gcc/bin

export ANDROID_SDK_ROOT=/Users/emarinel2/android

alias gs='git status'

#alias gl='git log | grep --color=never -Ev "Tested-by|git-svn-id|Change-Id|Reviewed-on|pg-ci-gerrit" | less'
alias gl='git log'

alias ga='git add -A'
alias gam='git ls-files --modified | grep -v config | grep -v dispatch.* | grep -v launch | xargs git add'
alias gau='git ls-files --other --exclude-standard | xargs git add'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias gdc='git diff --cached'
alias grmd='git ls-files --deleted | xargs git rm'
alias glf='git ls-files'
alias glfd='git ls-files --deleted'
alias pull='git pull --rebase origin master'
alias push='git push origin master'
alias pom='git push origin HEAD:master'
alias p311='git push origin HEAD:3.11.1'
alias gfo='git fetch origin'
alias gsh='git show HEAD'
alias gsh2='git show HEAD^'
alias g='git'
alias brc='emacs ~/.bashrc'
alias cbrc='cat ~/.bashrc'
alias gsp='git stash pop'
alias grom='git rebase origin/master'
alias gr311='git rebase origin/3.11.1'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gca='git commit --amend -C HEAD'
alias e='emacs'
alias amend='git commit --amend'
alias dbrc='. ~/.bashrc'
alias gerrit='git push origin HEAD:refs/for/master'

alias gfi='git fetch hhdev'
alias eclipse37='~/Downloads/eclipse_3.7/eclipse/eclipse'

alias srp='g stash && grom && gsp'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

alias gbr='for k in `git branch|perl -pe s/^..//`;do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k|head -n 1`\\t$k;done|sort -r'

alias gast='git add hedgehog/core/*/src hedgehog/core/*/test'

# export HADOOP_HOME=~/hadoop-0.20.205.0

alias f2='ssh frontier-02'
alias f3='ssh frontier-03'
alias f4='ssh frontier-04'

alias qsnode='ssh 50.116.0.118'

#shopt -s histappend
#export PROMPT_COMMAND="history -n; history -a"

alias linode='ssh emarinelli@50.116.3.137'
