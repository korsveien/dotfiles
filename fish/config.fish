# Only load in interactive shells (prevents slowness in nvim-tree)
if not status is-interactive
    return
end

bind -M insert \cj up-or-search
bind -M insert \ck down-or-search
bind -M insert \cf forward-char
bind -M insert \ca beginning-of-line
bind -M insert \ce end-of-line
bind \cj up-or-search
bind \ck down-or-search

bind \cx edit_command_buffer

####### Variables #####

##https://specifications.freedesktop.org/basedir-spec/latest/ar01s03.html
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state
set -x XDG_CACHE_HOME $HOME/.cache

set -x EDITOR nvim

## Terraform cache

####### ABBREVIATIONS #####
abbr --add t terraform

abbr --add i idea
abbr --add p python3
abbr --add l ls -la
abbr --add puip wget -O - -q icanhazip.com

## kubectl etc.
abbr --add kk kubectl
abbr --add k k9s
abbr --add ks kubens
abbr --add kx kubectx
abbr --add kw watch -n 2 kubectl get pods
abbr --add kz kustomize

## npm
abbr --add nrb npm run build

## vim
abbr --add v nvim
abbr --add vim nvim

## yadm
abbr --add y yadm
abbr --add yp yadm push
abbr --add ys yadm status
abbr --add ya yadm add -p
abbr --add yc yadm commit -m \"Update config\"

## git
abbr --add g git
abbr --add gpf git push -f
abbr --add gl git log --all --decorate --graph
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
abbr --add gb git branch --all
abbr --add gpr "git remote prune origin && git branch -vv | grep ': gone]' | awk '{print \$1}' | xargs -r git branch -D"

## docker
abbr --add d docker
abbr --add di docker images
abbr --add dps docker ps
abbr --add dcu docker-compose up
abbr --add dcd docker-compose down

## maven
abbr --add mid mvn install -DskipTests
abbr --add mci mvn clean install
abbr --add mcid mvn clean install -DskipTests
abbr --add mtree mvn dependency:tree

## configs
abbr --add fv nvim ~/.config/fish/config.fish
abbr --add fs source ~/.config/fish/config.fish

## path
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/go/bin

####### FUNCTIONS ####
function ho
    set repo (git remote show origin | rg github.com | head -n 1 | cut -d':' -f3 | cut -d'.' -f1)
    open "https://github.com/$repo"
end

function gcm
    git checkout main || git checkout master
end

function gco
    git branch --all | fzf | cut -d/ -f3 | xargs git checkout
end

##### THIRD PARTY UTILITIES ####
[ -e /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

function fish_right_prompt -d "Write out the right prompt"
    set -l exit_code $status

    # Print exit code for failed commands.
    if test $exit_code -ne 0
        set_color red
        echo -n $exit_code
        set_color normal
    end

end

# Remove mode prompt
function fish_mode_prompt
end

starship init fish | source
