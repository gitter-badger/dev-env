source ~/.config/fish/nvm-wrapper/nvm.fish

eval (docker-machine env default)

#
# Applications
#
alias d="docker"
alias dk="docker kill"
alias dr="docker rm"
alias dri="docker rmi"
alias dp="docker ps"
alias dpa="docker ps -a"
alias dl="docker logs"
alias dc="docker-compose"
alias dm="docker-machine"
alias dms="docker-machine ssh"
alias g="git"
alias s="subl"
alias a="atom"
alias w="wstorm"

alias v="ssh nick@192.168.1.154"
alias vu="~/repo/Voron/scp_teamcity.sh"

alias fe="subl ~/.config/fish/config.fish"

#
# File system aliases
#
alias ..="cd .."
alias ...="cd ../.."
alias -="cd -"

alias la="ls -Gla"
alias lsd='ls -l | grep "^d"'
alias ll='ls -ahlF'
alias l='ls -CF'
alias redmon='docker run -it --rm redis sh -c "exec redis-cli -h 192.168.1.117"'

#
# Git aliases
#
alias gp="git pull"
alias go="git checkout"
alias gh="git push"
alias gc="git commit -m"
alias gaa="git add ."
alias gs="git status"

function make_completion --argument alias command
    complete -c $alias -a "(
        set -l cmd (commandline -op);
        set -e cmd[1];
        complete -C\"$command \$cmd\";
    )"
end

function __find_sc_repo
  find ~/Repo -type d -maxdepth 1 -name 'synccloud*' | cut -d- -f2
end

function __find_repo
  find ~/Repo -type d -maxdepth 1 | xargs basename
end

function rs
  cd ~/repo/synccloud-$argv
end
complete --no-files -c rs -a "(__find_sc_repo)"

function r
  cd ~/repo/$argv
end
complete --no-files -c r -a "(__find_repo)"

function fish_prompt --description 'Write out the prompt'
    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __git_cb
    set __git_cb ":"(set_color brown)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)""
    end

    switch $USER

    case root

    if not set -q __fish_prompt_cwd
        if set -q fish_color_cwd_root
            set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
        else
            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end
    end

    printf '%s@%s:%s%s%s%s# ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

    case '*'

    if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    printf '%s@%s:%s%s%s%s$ ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

    end
end