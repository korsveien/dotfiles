fzf_key_bindings

bind \cj up-or-search
bind \ck down-or-search

##### ABBREVIATIONS #####
abbr --add ea envchain aws

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

# Path
contains ~/.cargo/bin $fish_user_paths; or set -Ua fish_user_paths ~/.cargo/bin

##### FUNCTIONS ####
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

function fs
    source ~/.config/fish/config.fish
end

function fv
    nvim  ~/.config/fish/config.fish
end

function av
    nvim ~/.config/alacritty/alacritty.yml
end

##### THIRD PARTY UTILITIES ####
if test -f /usr/share/autojump/autojump.fish
    source /usr/share/autojump/autojump.fish
end

set fish_function_path $fish_function_path ~/repo/plugin-foreign-env/functions
fenv source ~/.nix-profile/etc/profile.d/nix.sh
fenv source ~/.bashrc
