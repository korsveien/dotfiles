fzf_key_bindings
fish_default_key_bindings

###### Variables #####
set -x _JAVA_AWT_WM_NONREPARENTING 1
set -x NVM_DIR $HOME/.nvm

#https://specifications.freedesktop.org/basedir-spec/latest/ar01s03.html
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state
set -x XDG_CACHE_HOME $HOME/.cache

# Disable automatic homebrew update
set -x HOMEBREW_NO_AUTO_UPDATE 1

bind \cj up-or-search
bind \ck down-or-search

###### ABBREVIATIONS #####
abbr --add p python3
abbr --add l exa -la
abbr --add puip wget -O - -q icanhazip.com

# npm
abbr --add nrb npm run build

# envchain
abbr --add ea envchain aws
abbr --add en envchain nexus
abbr --add eh envchain github

# vim
abbr --add v nvim
abbr --add vim nvim

# yadm
abbr --add y yadm
abbr --add yp yadm push
abbr --add ys yadm status
abbr --add yc yadm commit -m \"Update config\"

# git
abbr --add g git
abbr --add gpf git push -f
abbr --add gpu git push --set-upstream-to origin (git rev-parse --abbrev-ref HEAD)
abbr --add gl git log --all --decorate --oneline --graph
abbr --add gc git commit -m
abbr --add gs git status
abbr --add ga git add -p
abbr --add gamend git commit --amend --reuse-message=HEAD
abbr --add gcl git clone
abbr --add grhh git reset --hard HEAD
abbr --add gp git push
abbr --add gst git status
abbr --add gd git diff --staged
abbr --add gbn git checkout -b
abbr --add gco git checkout
abbr --add gb git branch


# docker
abbr --add d docker
abbr --add di docker images
abbr --add dps docker ps

# maven
abbr --add mid envchain nexus mvn install -DskipTests
abbr --add mci envchain nexus mvn clean install
abbr --add mcid envchain nexus mvn clean install -DskipTests
abbr --add mtree envchain nexus mvn dependency:tree

# java
abbr --add jls /usr/libexec/java_home -V
abbr --add jh echo $JAVA_HOME

# intellij
abbr --add ij envchain nexus,aws idea

# terraform
abbr --add tf envchain aws terraform
abbr --add t terraform

# tmux
abbr --add tl tmux list-sessions
abbr --add ta tmux attach-session -t
abbr --add tk tmux kill-session -t

# configs
abbr --add fv nvim ~/.config/fish/config.fish
abbr --add fs source ~/.config/fish/config.fish
abbr --add av nvim ~/.config/alacritty/alacritty.yml
abbr --add sv nvim ~/.config/sway/config

# path
contains ~/.cargo/bin $fish_user_paths; or set -Ua fish_user_paths ~/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path /usr/local/sbin
fish_add_path $HOME/go/bin

###### FUNCTIONS ####
function fish_greeeting
    echo The time is (set_color yellow; date +%T; set_color normal) and this machine is called $hostname
end

function jset
    set -Ux JAVA_HOME (/usr/libexec/java_home -v $argv[1])
    source ~/.config/fish/config.fish
end

function co
    set repo (git remote show origin | rg github.com | head -n 1 | cut -d':' -f3 | cut -d'.' -f1)
    open "https://app.circleci.com/pipelines/github/$repo"
end

function ho
    set repo (git remote show origin | rg github.com | head -n 1 | cut -d':' -f3 | cut -d'.' -f1)
    open "https://github.com/$repo"
end

function bi
    brew search | fzf --multi --preview 'brew search {1}' | xargs -ro brew install
end

function pi
    pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
end

function pr
    pacman -Qq | fzf --multi --preview 'sudo pacman -Rns {}' | xargs -ro sudo pacman -Rns
end

function yi
    yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S
end

function yr
    yay -Qq | fzf --multi --preview 'sudo yay -Rns {}' | xargs -ro sudo yay -Rns
end

function gcm
    git checkout main || git checkout master
end

function rente_studie
    curl -s 'https://www.lanekassen.no/api/episerver/v2.0/content/7344' | jq .flytendeRente.value
end


#### THIRD PARTY UTILITIES ####
[ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
[ -f ~/.local/share/autojump/autojump.fish ]; and source ~/.local/share/autojump/autojump.fish

set fish_function_path $fish_function_path ~/repo/plugin-foreign-env/functions
fenv source ~/.bashrc

starship init fish | source
