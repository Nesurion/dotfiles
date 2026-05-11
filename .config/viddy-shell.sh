#!/bin/zsh
source ~/.zshaliases
# viddy calls: shell -c "command", so skip the -c and eval the rest
[[ "$1" == "-c" ]] && shift
eval "$@"
