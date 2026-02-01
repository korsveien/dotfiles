set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path $HOME/.local/bin

fish_vi_key_bindings

bind -M insert \cj up-or-search
bind -M insert \ck down-or-search
bind -M insert \cf forward-char
bind -M insert \ca beginning-of-line
bind -M insert \ce end-of-line
bind \cj up-or-search
bind \ck down-or-search

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

## vim
abbr --add v nvim
abbr --add vim nvim

## configs
abbr --add fv nvim ~/.config/fish/config.fish
abbr --add fs source ~/.config/fish/config.fish

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

function fish_prompt
    string join '' -- (set_color green) (prompt_pwd) (set_color normal) \n $fish_git_prompt '$ '
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

source /usr/share/autojump/autojump.fish
