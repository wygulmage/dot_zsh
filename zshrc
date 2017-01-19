HISTFILE=~/Tmp/zsh_history
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
alias rmempty='find -empty -type d -delete'
alias lock 'dm-tool lock'

# Setup pure
setopt prompt_subst
# PURE_GIT_PULL=0
# autoload -U promptinit && promptinit
# prompt pure

# Initialize fasd
# eval "$(fasd --init auto)"

# Initialize antigen-hs
ANTIGEN_HS_OUt="/Index/keith/Settings/zsh/antigen-hs"
ANTIGEN_HS_MY="/Index/keith/Settings/zsh/MyAntigen.hs"
source /Index/keith/Settings/zsh/antigen-hs/init.zsh
