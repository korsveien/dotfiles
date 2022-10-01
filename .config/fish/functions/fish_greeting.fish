function fish_greeting
    set daily_file ~/obsidian/daily/(date +"%Y-%m-%d").md
    if test -e $daily_file
        bat -p --color never $daily_file
    end
end
