# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="../../emarinelli"

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
export PATH=/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/opt/local/bin

# Don't need to type cd.
setopt AUTO_CD

#setopt RM_STAR_WAIT

setopt NO_SHARE_HISTORY

unsetopt correct_all

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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="/opt/homebrew/opt/gradle@7/bin:$PATH"

alias gam="/Users/eugenemarinelli/bin/gam7/gam"

# Autocomplete yarn scripts from package.json
_yarn_scripts() {
  local -a scripts
  if [[ -f package.json ]]; then
    scripts=($(node -e "Object.keys(require('./package.json').scripts||{}).forEach(s=>console.log(s))"))
  fi
  _describe 'scripts' scripts
}
compdef _yarn_scripts yarn

export EMACS_DAEMON_NAME=main
export EMACS_DAEMON_LABEL=com.eugenemarinelli.emacs-daemon

_start_emacs_daemon() {
  command emacsclient -s "$EMACS_DAEMON_NAME" -e '(daemonp)' >/dev/null 2>&1 && return 0

  launchctl kickstart -k "gui/$(id -u)/$EMACS_DAEMON_LABEL" >/dev/null 2>&1 ||
    command /opt/homebrew/bin/emacs --daemon="$EMACS_DAEMON_NAME" >/dev/null 2>&1

  local i
  for i in {1..50}; do
    command emacsclient -s "$EMACS_DAEMON_NAME" -e '(daemonp)' >/dev/null 2>&1 && return 0
    sleep 0.1
  done

  return 1
}

emacs() {
  for arg in "$@"; do
    case "$arg" in
      --daemon*|--fg-daemon*|--version|--help|-Q|--quick|--batch|--script)
        command /opt/homebrew/bin/emacs "$@"
        return
        ;;
    esac
  done

  _start_emacs_daemon || return 1

  command emacsclient -s "$EMACS_DAEMON_NAME" -nw "$@" ||
    command /opt/homebrew/bin/emacs "$@"
}
# Interactive git staging with fzf (overrides oh-my-zsh ga='git add')
unalias ga 2>/dev/null
ga() {
  local files candidates
  candidates=$(git ls-files -mo --exclude-standard)
  if [[ -n "$1" ]]; then
    files=$(echo "$candidates" | grep -i "$1")
  else
    files=$(echo "$candidates" | fzf -m --height=40% --bind 'space:toggle+down' --preview "git diff --color {} 2>/dev/null || cat {}")
  fi
  [[ -n "$files" ]] && echo "$files" | xargs git add && git status
}
