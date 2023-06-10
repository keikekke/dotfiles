# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

bindkey -v # set vi mode for zsh
export EDITOR=vim

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes

if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ];
then # WSL2-specific procedure
    alias xc='/mnt/c/Users/ryok0/.dotnet/tools/utf8clip.exe'
    alias xcc='/mnt/c/Users/ryok0/.dotnet/tools/utf8clip.exe'
else
    alias xc='xclip'
    alias xcc='xclip -selection c'
fi

alias ocaml='rlwrap ocaml'

function ac() {
    command g++ -Wall -std=c++17 -I ~/git/ac-library/ $1 && ./a.out
}

alias pw='cat ~/.pw|xc'

export PATH=$PATH:$HOME/.local/bin

export PROMPT='%(!.%{%F{yellow}%}.)$USER@%{$fg[white]%}%M %{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

bindkey '^R' history-incremental-pattern-search-backward

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:$HOME/.local/riscv/bin
export PATH=$PATH:$HOME/.local/go/bin:$HOME/.cargo/bin

if command -v go &> /dev/null; then
    export PATH="$PATH:$(go env GOPATH)/bin"
fi

if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ];
then # WSL2-specific procedure
  # stop cursor blinking on windows terminal
  echo -en "\e[2 q"

  # initialize ~/.Xauthority
  rm ~/.Xauthority
  touch ~/.Xauthority
  xauth add :0 MIT-MAGIC-COOKIE-1 "$(openssl rand -hex 16)"
  \cp ~/.Xauthority ~/win/Xauthority # temporarily disable alias for 'cp -i'

  # set up display
  xauth add `awk '/nameserver/ {print $2}' /etc/resolv.conf`:0 `xauth list | cut -d' ' -f2-`
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
fi

if command -v gh &> /dev/null; then
    # set up GitHub CLI auto-completion
    eval "$(gh completion -s zsh)"
fi

# convert PDF to PNG using pdftoppm (in poppler-utils package in Ubuntu)
function pdf2png() {
    pdftoppm -r 300 -singlefile -png $1 "${1%.*}"
}

# Okteto Cloud Kube Config
#export KUBECONFIG=$HOME/okteto-kube.config:${KUBECONFIG:-$HOME/.kube/config}
