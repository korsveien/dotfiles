set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/Applications/IntelliJ\ IDEA.app/Contents/MacOS

fish_vi_key_bindings

set -gx XDG_CONFIG_HOME ~/.config
set -gx EDITOR nvim

bind -M insert \cj up-or-search
bind -M insert \ck down-or-search
bind -M insert \cf forward-char
bind -M insert \ca beginning-of-line
bind -M insert \ce end-of-line
bind \cj up-or-search
bind \ck down-or-search

abbr --add l ls -la

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
abbr --add gpr "git remote prune origin && itongit branch -vv | grep ': gone]' | awk '{print \$1}' | xargs -r git branch -D"

## vim
abbr --add v nvim
abbr --add vim nvim

## tmux
abbr --add ta tmux attach

## opencode
abbr --add oc opencode

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

function gwn
    if test (count $argv) -ne 1
        echo "usage: gwn <branch>"
        return 1
    end
    set branch $argv[1]
    set repo (basename (git rev-parse --path-format=absolute --git-common-dir | string replace -r '/\.git$' ''))
    or return 1
    set dir ~/git/wt/$repo/(string replace -a / - $branch)/$repo

    git fetch origin main
    or return 1
    if test (git branch --show-current) = main
        git merge --ff-only origin/main
    else
        git fetch origin main:main
    end

    git worktree add --no-track -b $branch $dir origin/main
    and cd $dir
end

function gwd
    argparse a/all f/force -- $argv
    or return 1
    set main_repo (string replace -r '/\.git$' '' (git rev-parse --path-format=absolute --git-common-dir))
    or return 1
    set worktrees (git -C $main_repo worktree list --porcelain | awk '
        /^worktree /{i++; wt[i]=substr($0,10); b[i]="(detached)"}
        /^branch /{b[i]=substr($0,19)}
        END{for(j=2;j<=i;j++) print b[j] "\t" wt[j]}')
    set wt_branches (string split -f 1 \t $worktrees)
    set entries $worktrees
    for b in (git -C $main_repo for-each-ref --format='%(refname:short)' refs/heads)
        if test $b != main; and not contains -- $b $wt_branches
            set -a entries "$b"\t
        end
    end

    if test (count $argv) -gt 0
        set choices
        for b in $argv
            set match (printf '%s\n' $entries | awk -F '\t' -v b=$b '$1==b')
            if test -z "$match"
                echo "no worktree or branch named $b"
                return 1
            end
            set -a choices $match
        end
    else
        set listed $worktrees
        set -q _flag_all; and set listed $entries
        set choices (printf '%s\n' $listed | fzf --multi --bind 'space:toggle+down' --delimiter '\t' --prompt 'delete worktree (space to mark)> ')
        or return 1
    end

    for choice in $choices
        if test (string split -f 1 \t $choice) = main
            echo "refusing to delete main"
            return 1
        end
    end

    set remove_flags
    set -q _flag_force; and set remove_flags --force --force

    for choice in $choices
        set dir (string split -f 2 \t $choice)
        printf '  %-40s %s\n' (string split -f 1 \t $choice) (test -n "$dir"; and echo $dir; or echo "(no worktree)")
    end
    set -q _flag_force; and echo "--force: uncommitted changes in these worktrees will be lost"
    read -P "Delete "(count $choices)" worktree(s)/branch(es)? [y/N] " answer
    if not string match -qi y -- $answer
        echo aborted
        return 1
    end

    set failed 0
    for choice in $choices
        set branch (string split -f 1 \t $choice)
        set dir (string split -f 2 \t $choice)
        if test -n "$dir"
            if string match -q -- "$dir*" (pwd)
                cd $main_repo
            end
            if not git -C $main_repo worktree remove $remove_flags $dir
                read -P "Force delete $branch and lose its uncommitted changes? [y/N] " force_answer
                if not string match -qi y -- $force_answer; or not git -C $main_repo worktree remove --force --force $dir
                    set failed (math $failed + 1)
                    continue
                end
            end
            rmdir (dirname $dir) 2>/dev/null
        end
        if test $branch != "(detached)"
            git -C $main_repo branch -D $branch
            or set failed (math $failed + 1)
        end
    end
    if test $failed -gt 0
        echo "$failed failed"
        return 1
    end
end

function fish_prompt
    string join '' -- (set_color green) (prompt_pwd) (set_color blue) (fish_git_prompt) (set_color normal) \n '$ '
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

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	command rm -f -- "$tmp"
end

[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish


# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/peder/.lmstudio/bin
# End of LM Studio CLI section

