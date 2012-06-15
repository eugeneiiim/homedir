# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="robbyrussell"

alias gca='bash -c git commit --amend -C HEAD'

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/Users/emarinelli/hadoop/hadoop-0.18.0/bin:/opt/local/bin:/usr/local/smlnj-110.68/bin:/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin:/Developer/usr/llvm-gcc-4.2/bin:/Applications/Twelf/bin:/Users/emarinelli/android/tools:/Applications/sshfs/bin:/Users/emarinelli/bin:/Applications/MATLAB_R2008a/bin/matlab:/Users/emarinel/android/platforms/android-1.1/tools:/Users/emarinel/Programming/depot_tools:/Applications/JFig3-Launcher.app/Contents/Resources:/Users/emarinelli/jruby-1.3.1/bin:/opt/subversion/bin:/Users/emarinelli/android/tools:/Users/emarinelli/android/platform-tools:/Users/emarinelli/.gem/ruby/1.8/bin:/Library/PostgreSQL/9.0/bin:/Users/emarinelli/scala-2.8.1.final/bin

# Don't need to type cd.
setopt AUTO_CD

#setopt RM_STAR_WAIT

setopt NO_SHARE_HISTORY

# Alt-u goes up a directory
bindkey -s '\eu' '^Ucd ..; ls^M'

export TERM=rxvt

# Alt-s inserts sudo
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

if [[ -r ~/.zsh_bash_common ]]; then
    source ~/.zsh_bash_common
fi

cd ~/treat
