# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Add go bin to path
PATH="$HOME/go/bin:$PATH"

# Homebrew
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi


########## ZINIT CONFIG ##########

# Set directory for stoting zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit if not exists
if [ ! -d $ZINIT_HOME ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

########## ZINIT PLUGINS ##########
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

########## ZINIT SNIPPETS ##########
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Prompt
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

alias vim=nvim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Initialize and preserve search text
zle_history_search_init() {
  SEARCH_TEXT=$LBUFFER
}

history-beginning-search-up() {
  if [[ -z "$SEARCH_TEXT" ]]; then
    zle_history_search_init
  fi
  BUFFER=$SEARCH_TEXT
  zle history-beginning-search-backward
  if [[ $BUFFER == $SEARCH_TEXT ]]; then
    # If no match is found, set to the end of the line
    zle end-of-line
  fi
}
zle -N history-beginning-search-up

history-beginning-search-down() {
  if [[ -z "$SEARCH_TEXT" ]]; then
    zle_history_search_init
  fi
  BUFFER=$SEARCH_TEXT
  zle history-beginning-search-forward
  if [[ $BUFFER == $SEARCH_TEXT ]]; then
    # If no match is found, set to the end of the line
    zle end-of-line
  fi
}
zle -N history-beginning-search-down

# Reset the search text when accepting a line
zle-line-init() {
  SEARCH_TEXT=""
}
zle -N zle-line-init


zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
# bindkey '^[[A' history-beginning-search-backward-end
# bindkey '^[[B' history-beginning-search-forward-end

# bindkey '^[[A' history-beginning-search-up
# bindkey '^[[B' history-beginning-search-down



# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pj/.config/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/pj/.config/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/pj/.config/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/pj/.config/google-cloud-sdk/completion.zsh.inc'; fi
