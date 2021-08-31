fzf_key_bindings

bind \cj up-or-search
bind \ck down-or-search

##### ABBREVIATIONS #####
abbr --add p python3

abbr --add ea envchain aws
abbr --add en envchain nexus

abbr --add y yadm
abbr --add yp yadm push
abbr --add ys yadm status
abbr --add yc yadm commit -m \"Update config\"

abbr --add l exa -l
abbr --add ll exa -la
abbr --add v nvim
abbr --add vim nvim

# Git
abbr --add g git
abbr --add gl git log --all --decorate --oneline --graph
abbr --add gc git commit -m
abbr --add gs git status
abbr --add gco git checkout
abbr --add ga git add -p
abbr --add gamend git commit --amend --reuse-message=HEAD
abbr --add gb git branch
abbr --add gcl git clone
abbr --add grhh git reset --hard HEAD
abbr --add gp git push
abbr --add gst git status

# Docker
abbr --add d docker
abbr --add di docker images
abbr --add dps docker ps

# Maven
abbr --add mci envchain nexus mvn clean install
abbr --add mcid envchain nexus mvn clean install -DskipTests
abbr --add mtree envchain nexus mvn dependency:tree

# Java
abbr --add jls /usr/libexec/java_home -V
abbr --add jh echo $JAVA_HOME

# IntelliJ
abbr --add ij envchain nexus,aws idea

# Terraform
abbr --add tf envchain aws terraform

# AWS
abbr --add aws envchain aws aws

# Tmux
abbr --add tl tmux list-sessions
abbr --add ta tmux attach-session -t
abbr --add tk tmux kill-session -t

abbr --add fv nvim ~/.config/fish/config.fish
abbr --add fs source ~/.config/fish/config.fish
abbr --add av nvim ~/.config/alacritty/alacritty.yml
abbr --add sv nvim ~/.config/sway/config

# Path
contains ~/.cargo/bin $fish_user_paths; or set -Ua fish_user_paths ~/.cargo/bin

##### FUNCTIONS ####
function jset
    set -Ux JAVA_HOME (/usr/libexec/java_home -v $argv[1])
end

function co
    set repo (git remote show origin | rg github.com | head -n 1 | cut -d':' -f3 | cut -d'.' -f1)
    open "https://app.circleci.com/pipelines/github/$repo"
end

function ho
    set repo (git remote show origin | rg github.com | head -n 1 | cut -d':' -f3 | cut -d'.' -f1)
    open "https://github.com/$repo"
end

function pi
    pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
end

function yi
    yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S
end

function gcm
    git checkout main || git checkout master
end

##### THIRD PARTY UTILITIES ####
[ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

set fish_function_path $fish_function_path ~/repo/plugin-foreign-env/functions
fenv source ~/.bashrc
