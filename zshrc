# -*- mode: sh -*-
if [ -d "/Ix/k" ] ; then
    IX_K="/Ix/k"
fi

if [ -d "${IX_K}/Database" ] ; then
    K_DATA="${IX_K}/Database"
elif [ -d "${XDG_DATA_HOME}"] ; then
    K_DATA="${XDG_DATA_HOME}"
else
    K_DATA="$HOME"
fi

if [ ! -d "${K_DATA}/zsh" ] ; then
    mkdir ${K_DATA}/zsh
fi

HISTFILE=${K_DATA}/zsh/zsh_history
HISTSIZE=21600
SAVEHIST=43200
HIST_IGNORE_ALL_DUPS="true" # When a command is entered, delete all previous instances of the command.
HIST_REDUCE_BLANKS="true" # Clean up non-syntax whitespace in history.

# CASE_SENSITIVE="true"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
CORRECT="true" # Autocorrect commands.
AUTO_MENU="true" # Cycle through completions.

# Use vim key bindings
bindkey -v
# Set word boundaries to include '/'.
WORDCHARS='*?.[]~=&;!#$%^(){}<>'

# Backspace deletes a whole word.
bindkey '^?' backward-delete-word

# allow comments at command line
setopt interactivecomments


autoload -U colors
colors

# Aliases:
# look () {
#     if [[ -d $1 ]]
#     then
#         ls -L -X --color=auto --group-directories-first $1
#     else
#         less $1
#     fi
# }
# l () {
#     if [[ $# == 0 ]]
#     then
#         look .
#     else
#         for i; do look $i; done
#     fi
# }
look () {
    if [[ (($# == 1 && -f $1 ))]]
    then; less $1
    else; ls -L -v --color=auto --group-directories-first $*
    fi
}
alias l='look'
alias ls='ls --color=auto -X -v'
alias em='emacs -nw'
alias sm='(emacs > /dev/null 2>&1 &)'
alias pm='(palemoon > /dev/null 2>&1 &)'
alias ff='(firefox > /dev/null 2>&1 &)'
alias fb2k='(playonlinux --run foobar2000 > /dev/null 2>&1 &)'
alias rmempty='find -empty -type d -delete'
alias lock='dm-tool lock'

# Setup pure
setopt prompt_subst
# PURE_GIT_PULL=0
# autoload -U promptinit && promptinit
# prompt pure

# Initialize fasd
# eval "$(fasd --init auto)"
if [ -d "${IX_K}/Managers/git/fasd" ] ; then
    PATH="${PATH}:${IX_K}/Managers/git/fasd"
    fasd_cache="${K_DATA}/zsh/fasd_cache"
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ] ; then
        fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
    fi
    . "$fasd_cache"
    unset fasd_cache
fi

# Initialize antigen-hs
K_SETTINGS=${IX_K}/Settings
export ANTIGEN_HS_OUT=${K_SETTINGS}/zsh/antigen-hs-out
export ANTIGEN_HS_MY=${K_SETTINGS}/zsh/MyAntigen.hs
source ${K_SETTINGS}/zsh/antigen-hs/init.zsh

