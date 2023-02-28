
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s /Users/emarinelli/.nvm/nvm.sh ]] && . /Users/emarinelli/.nvm/nvm.sh # This loads NVM

export PATH="$HOME/.cargo/bin:$PATH"

source /Users/eugenemarinelli/.docker/init-bash.sh || true # Added by Docker Desktop
