alias c='clear'
alias x='exit'
alias e.='nautilus .'
alias dev='cd ~/Documents/Projects'
alias la='ls -A'
alias ll='ls -a -l'
alias ..='cd .. && ls'
alias sizes='df -h'
alias gl='git log --oneline --all --graph --decorate  $*'
alias server='npm run server'
alias build='npm run build'
alias production='npm run production'

function up { cd '..'; ls;}
function cdl { cd $1; ls;}
function g { git $@;}
function gacp { git add '*'; git commit -m "$@"; git push;}
function ws { http-server -p "$@";}
