## $PATH related things
export NPM_TOKEN="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"
export NVM_DIR="$HOME/.nvm"
export PATH="$HOME/homebrew/sbin:$HOME/homebrew/bin:$PATH"
export PATH="$HOME/Library/Haskell/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/Users/edstell/homebrew/opt/go@1.8/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export NVM_DIR="$HOME/.nvm"                                                                                                                         master
    [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
export PATH="$HOME/.tmuxifier/bin:$PATH"

# Use homebrew python instead of system python
if [ -d "/Users/edstell/homebrew/opt/python/libexec/bin" ]; then
    export PATH="/Users/edstell/homebrew/opt/python/libexec/bin:$PATH"
fi

export PATH="/Users/edstell/homebrew/opt/python@2/libexec/bin:$PATH"

export HOMEBREW_CASK_OPTS="--appdir=~/Applications"


## ZSH customisation

# Display which git branch you're in
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
PROMPT=\$vcs_info_msg_0_'%# '
zstyle ':vcs_info:git:*' formats '%b'

# Prompt settings
# %. displays the trailing component of the current working dir
# %% displays a percentage sign
PROMPT='%. %% '

# Enable zsh vim mode
set -o vi

# Arrow-key autocomplete selection
zstyle ':completion:*' menu select


## Aliases

# Add ls options. all, long, human-readable, slashes after directories
alias ll='ls -hlGFA'

# Git aliases:
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gpl="git pull"
alias gp="git push"
alias gpf="git push -f"
alias gpu="git push -u origin HEAD"
alias gb="git branch"
alias gbd="git branch -d"
alias gbD="git branch -D"
alias gco="git checkout"
alias gcb="git checkout -b"

# remap vim to nvim
alias vim="/opt/homebrew/bin/nvim"

# shortcut to change to wearedev
alias dev="cd /Users/edstell/src/github.com/avianlabs/backend/platform"
alias wad="cd /Users/edstell/src/github.com/avianlabs/backend/platform"

# flip tilde keys over
alias tilde="hidutil property --set '{\"UserKeyMapping\":[{\"HIDKeyboardModifierMappingSrc\":0x700000064,\"HIDKeyboardModifierMappingDst\":0x700000035},{\"HIDKeyboardModifierMappingSrc\":0x700000035,\"HIDKeyboardModifierMappingDst\":0x700000064}]}'"
alias itilde="hidutil property --set '{\"UserKeyMapping\":[{\"HIDKeyboardModifierMappingSrc\":0x700000035,\"HIDKeyboardModifierMappingDst\":0x700000035},{\"HIDKeyboardModifierMappingSrc\":0x700000064,\"HIDKeyboardModifierMappingDst\":0x700000064}]}'"

##############################################################################
# History Configuration
##############################################################################
# Increase the size of the history file
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# Append to the history file, rather than overwriting it
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Make sure zsh writes to the history immediately (not only when the shell exits)
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_VERIFY
setopt HIST_SAVE_NO_DUPS
setopt EXTENDED_HISTORY

# Other useful history options
setopt HIST_REDUCE_BLANKS  # Remove blank lines from history
setopt HIST_BEEP  # Beep when attempting to access non-existent history entries

## Tool customisation

# Make nvim the default editor, if it exists
if command -v nvim &>/dev/null
then
	export EDITOR="nvim"
else
	export EDITOR="vim"
fi

# Enable git completion (maybe this enables autocompletion generally?)
autoload -Uz compinit && compinit

# Coloured ls output
export CLICOLOR=1

# Set up FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(tmuxifier init -)"

## Helper functions

# Git Ignore Generator
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# Serve go documentation
function gwd () {
    echo "Listening on localhost:5001"
    godoc -http :5001 &
    open 'http://localhost:5001'
    echo "Kill server with:"
    echo "kill" $!
}

## Laptop-specific setup
[ -f $HOME/.config/zsh/personal.sh ] && source $HOME/.config/zsh/personal.sh

uid () {
	uuidgen | tr -d ‘\n’ | pbcopy
	echo “Copied to clipboard”
}

source $HOME/src/github.com/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(cli completion zsh)
source <(fzf --zsh)
