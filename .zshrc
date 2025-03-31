# vim:fileencoding=utf-8:foldmethod=marker
export PATH=$PATH:/home/yuna/.local/bin

# {{{ Oh My Zsh Configuration

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

# Plugins to load.
plugins=(git colorize zsh-completions zsh-history-substring-search zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# }}}

# {{{ Basic Environment Setup

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# }}}

# {{{ Oh My Zsh Customization

# Set list of themes to pick from when loading at random
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled
zstyle ':omz:update' mode auto
# zstyle ':omz:update' mode reminder

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# }}}

# {{{ External Tools & Plugins

# Oh My Posh
# export PATH=/opt/homebrew/bin:$PATH
#eval "$(oh-my-posh init zsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/catppuccin_mocha.omp.json)"

eval "$(oh-my-posh init zsh --config /home/yuna/.config/omp/tiwahu.json)"

# eval "$(oh-my-posh init zsh --config /Users/yunii/.config/omp/themes/cattpuccin_latte.json)"
#export POSH_THEME="https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/bubblesextra.omp.json"

# eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/half-life.omp.json')"

# Starship
# eval "$(starship init zsh)"

# Autocomplete
#source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Autosuggestions
#source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax Highlighting
#source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Cargo Environment
#. "$HOME/.cargo/env"

# Zoxide
eval "$(zoxide init zsh)"

# }}}

# {{{ Custom PATH & Aliases-

# Custom PATH
# export PATH=/Users/yunii/.local/bin:$PATH

# Aliases
alias lsl="eza --icons=always -lah --group-directories-first"
alias ls="eza --icons=always --group-directories-first"
alias cd="z"
alias cpc="xclip -sel c < "

#alias yt2info="python3 /Users/yunii/Projects/youtube-summarizer/main.py"

#alias ::="ltools"

alias tt="kitten @set-tab-title"
alias tc="kitten @set-tab-color"

# }}}
alias escreen="xrandr --output HDMI-1 --auto --above eDP-1"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

