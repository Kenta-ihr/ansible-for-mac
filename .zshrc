PROMPT='%m %~ $ '
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/ihara-kenta/.zshrc'

# Enable colors
autoload -Uz colors
colors
# Enable complete cmd
autoload -Uz compinit
compinit
# Matching lowercase against uppercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# Share histories with other shells
setopt share_history
# Point out typo
setopt correct
# Enable displaying with colors  
export LSCOLORS=cxfxcxdxbxegedabagacad
alias ls='ls -GF'
alias ll='ls -la'
alias less='less -N'
alias -g L='| less'


#Git alias
alias gs='git status'
alias gl='git log'
alias gb='git branch'

######################
# show current branch
#
# @see
# http://stackoverflow.com/questions/1128496/to-get-a-prompt-which-indicates-git-branch-in-zsh

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
RPROMPT=$'$(vcs_info_wrapper)'

## cocot wrapper
_ssh_list(){
  OLDIFS=$IFS
  IFS=$'\n'
  OUT=""
  for ITEM in `grep "Host " ~/.ssh/config | sed -e "s/ \+/ /g" |cut -f2 -d" "`
  do
    OUT="${ITEM} ${OUT}"
  done
  IFS=$OLDIFS
  echo ${OUT}
}

_ssh_comp() {
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  if (( $COMP_CWORD <= 1 )); then
    COMPREPLY=($( compgen -W "`_ssh_list`" -- $cur ))
  else
    COMPREPLY=()
  fi
}

alias cssh="cocot -t UTF-8 -p EUC-JP ssh"
compdef _ssh_comp cssh
## cocot wrapper

export PATH="/usr/local/sbin:$PATH"

# peco history
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# peco tree
function peco-tree-vim(){
  local SELECTED_FILE=$(tree -L 2 --charset=o -f | peco | tr -d '\||`|-' | xargs echo)
  BUFFER="cd $SELECTED_FILE"
  zle accept-line
}
zle -N peco-tree-vim
bindkey "^t" peco-tree-vim
