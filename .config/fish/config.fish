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
set -x _JAVA_AWT_WM_NONREPARENTING 1
set -x NVM_DIR $HOME/.nvm

##https://specifications.freedesktop.org/basedir-spec/latest/ar01s03.html
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state
set -x XDG_CACHE_HOME $HOME/.cache

set -gx KUBECONFIG $HOME/.kube/config

set -x EDITOR nvim

## Terraform cache
set -x TF_PLUGIN_CACHE_DIR ~/.terraform.d/plugin-cache

## Disable automatic homebrew update
set -x HOMEBREW_NO_AUTO_UPDATE 1

####### ABBREVIATIONS #####
abbr --add i idea
abbr --add p python3
abbr --add l ls -la
abbr --add puip wget -O - -q icanhazip.com

## kubectl etc.
abbr --add k kubectl
abbr --add kns kubens
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

## java
abbr --add jls /usr/libexec/java_home -V
abbr --add jh echo $JAVA_HOME

## configs
abbr --add fv nvim ~/.config/fish/config.fish
abbr --add fs source ~/.config/fish/config.fish
abbr --add sv nvim ~/.config/starship.toml

abbr --add b brew
abbr --add h helm

alias python python3

## path
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path /usr/local/sbin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.krew/bin
fish_add_path $HOME/dotfiles/scripts
fish_add_path /usr/local/opt/ccache/libexec


####### FUNCTIONS ####
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
    brew search --eval-all --desc "" | fzf --multi --preview 'brew info {1}' | xargs -ro brew install
end

function br
    brew leaves | fzf --multi --preview 'brew info {1}' | xargs -ro brew remove
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

function gpu
    git push --set-upstream-to origin (git rev-parse --abbrev-ref HEAD)
end

function gco
    git branch --all | fzf | cut -d'/' -f3| xargs git checkout
end

function get_pod_name
    kubectl get pods -o name | cut -d'/' -f2 | fzf
end

function get_deployment_name
    kubectl get deployments -o name | cut -d'/' -f2 | fzf
end

function get_netpol_name
    kubectl get netpol -o name | cut -d'/' -f2 | fzf
end

function kg
    set podname (get_pod_name)
    kubectl get pod $podname -o yaml | nvim +'set filetype=yaml' -
end

function kgd
    set deployment_name (get_deployment_name)
    kubectl get deployment $deployment_name -o yaml | nvim +'set filetype=yaml' -
end

function kgn
    set netpolname (get_netpol_name)
    kubectl describe netpol $netpolname | nvim +'set filetype=yaml'
end

function kx
    set podname (get_pod_name)
    kubectl exec -it $podname -- sh
end

function kd
    set podname (get_pod_name)
    kubectl debug $podname -it --image=nicolaka/netshoot
end

function kl
    set podname (get_pod_name)
    kubectl logs $podname
end

function klo
    set podname (get_pod_name)
    kubectl logs -c otc-container $podname | nvim -
end

##### THIRD PARTY UTILITIES ####
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
[ -f ~/.digipost.fish ]; and source ~/.digipost.fish

set -x GPG_TTY (tty)

helm completion fish | source

function fish_prompt -d "Write out the prompt"
    if test $hostname != 'bekk-mac-2459'
        set_color yellow
        echo -n "$USER@$hostname "
        set color normal
    end
    set_color grey
    printf "%s ~> " (date +"%H:%M:%S")
    set_color normal
end

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

#### iTerm 2 integration
test -n "$TERM_PROGRAM"
and test $TERM_PROGRAM = iTerm.app
and test -e {$HOME}/.iterm2_shell_integration.fish
and source {$HOME}/.iterm2_shell_integration.fish

function iterm2_print_user_vars
  iterm2_set_user_var kubecontext (kubectl config current-context):(kubectl config view --minify --output 'jsonpath={..namespace}')
  #iterm2_set_user_var azurecontext (az account show | jq '.name')
end

starship init fish | source

