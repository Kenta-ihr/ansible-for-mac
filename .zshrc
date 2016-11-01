# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
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

# Enable to use both of phpenv and rbenv
export PHPENV_ROOT=$HOME/.phpenv
export PATH="$PATH:$PHPENV_ROOT/bin"
eval "$(rbenv init -)"
eval "$(phpenv init -)"

# End of lines
