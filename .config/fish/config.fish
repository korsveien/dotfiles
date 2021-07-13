set -x XDG_CONFIG_HOME ~/.config

##### ABBREVIATIONS #####
abbr --add y yadm
abbr --add j autojump

abbr --add l exa -l
abbr --add ll exa -la
abbr --add v nvim
abbr --add vim nvim

abbr --add iws iwctl station wlan0 scan
abbr --add iwg iwctl station wlan0 get-networks
abbr --add iwi iwctl station wlan0 connect \"Peder sin iPhone\"

# Git
abbr --add g git
abbr --add gc git commit -m
abbr --add gs git status
abbr --add gco git checkout
abbr --add ga git add -p
abbr --add gamend git commit --amend --reuse-message=HEAD
abbr --add gb git branch
abbr --add gl git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
abbr --add gcl git clone
abbr --add grhh git reset --hard HEAD
abbr --add gp git push

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
function pi
    pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
end

function fs
    source "$XDG_CONFIG_HOME/fish/config.fish"
end

function fv
    nvim  "$XDG_CONFIG_HOME/fish/config.fish"
end

function av
    nvim "$XDG_CONFIG_HOME/alacritty/alacritty.yml"
end

##### THIRD PARTY UTILITIES ####
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

