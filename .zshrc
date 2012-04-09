# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="robbyrussell"

export GIT_EDITOR=emacs


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
alias gsh2='git show "HEAD^"'
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

alias srp='g stash && grom && gsp'



# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/Users/emarinelli/hadoop/hadoop-0.18.0/bin:/opt/local/bin:/usr/local/smlnj-110.68/bin:/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin:/Developer/usr/llvm-gcc-4.2/bin:/Applications/Twelf/bin:/Users/emarinelli/android/tools:/Applications/sshfs/bin:/Users/emarinelli/bin:/Applications/MATLAB_R2008a/bin/matlab:/Users/emarinel/android/platforms/android-1.1/tools:/Users/emarinel/Programming/depot_tools:/Applications/JFig3-Launcher.app/Contents/Resources:/Users/emarinelli/jruby-1.3.1/bin:/opt/subversion/bin:/Users/emarinelli/android/tools:/Users/emarinelli/android/platform-tools:/Users/emarinelli/.gem/ruby/1.8/bin:/Library/PostgreSQL/9.0/bin:/Users/emarinelli/scala-2.8.1.final/bin

alias gl='git log'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

if [[ -f "$HOME/.amazon_keys" ]]; then
    source "$HOME/.amazon_keys";
fi

export PATH=$PATH:~/play-2.0

alias qsnode='ssh 50.116.0.118'
