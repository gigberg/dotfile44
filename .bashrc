# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/zhoujiaming/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/zhoujiaming/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/zhoujiaming/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/zhoujiaming/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#history related
export HISTTIMEFORMAT='%F %T ' #让历史命令记录操作时间
export HISTSIZE=10000000 #设置保存多少条历史命令到历史文件中条数
export HISTFILESIZE=10000000 #设置保存历史文件大小
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r" #实时记录历史命令，防止丢失

#automaticly start torch190 conder env
#conda activate torch190
#conda activate citod
#conda activate cdconv
cd ~/kyoto

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
fd() {
  local dir
  dir=$(find ${1:-~/} -print 2> /dev/null | fzf) &&
  if [[ -d $dir ]]; then
      cd "$dir"
  elif [[ -f $dir ]]; then
      cd `dirname $dir`
  fi
}

# export CUDA_HOME=/home/zhoujiaming/usrbin/cuda${CUDA_HOME:+:${CUDA_HOME}} #  This part uses parameter expansion in shell scripting, if CUDA_HOME is already set, it appends the new path with a : separator
export CUDA_HOME=
# export PATH=/home/zhoujiaming/usrbin/cuda/bin${PATH:+:${PATH}}
[ -z "$(echo $PATH | grep -o '/home/zhoujiaming/usrbin/cuda/bin')" ] && export PATH=/home/zhoujiaming/usrbin/cuda/bin${PATH:+:${PATH}}
export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/usr/local/cuda-11.1/bin' | tr '\n' ':' | sed 's/:$//') # overlay /etc/profile $PATH
export LD_LIBRARY_PATH=
# export LD_LIBRARY_PATH=/home/zhoujiaming/usrbin/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
# export LD_LIBRARY_PATH=/home/zhoujiaming/usrbin/nccl_2.8.4-1+cuda11.2_x86_64/include:/home/zhoujiaming/usrbin/nccl_2.8.4-1+cuda11.2_x86_64/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# 服务器别名
alias lab1='ssh zjm@172.28.6.41'
alias lab2='ssh zjm@172.28.6.42'
alias lab3='ssh zjm@172.28.6.43'
alias lab5='ssh zjm@172.28.6.45'
alias lab6='ssh zjm@172.28.6.46'
alias lab7='ssh zjm@172.28.6.47'
alias lab8='ssh zjm@172.28.6.48'
alias lab9='ssh zjm@172.28.6.49'
alias lab10='ssh zhoujiaming@172.28.6.44'
alias lab11='ssh zjm@172.28.6.89'
alias lab12='ssh zjm@172.28.6.90'
alias lab13='ssh zjm@172.28.6.91'

# tmux命令简化
# alias tmuxa='tmux attach || tmux new'
alias tmuxa='tmux attach -t tmuxa || tmux new -s tmuxa'
alias tmuxb='tmux attach -t tmuxb || tmux new -s tmuxb'

# 启用 Go Modules 功能
export GO111MODULE=on
# 配置 GOPROXY 环境变量
export GOPROXY=https://goproxy.cn,direct

alias pipx='conda run -n base pipx'
# Created by `pipx` on 2024-03-06 08:34:23
export PATH="$PATH:/home/zhoujiaming/.local/bin"
# export PATH="$PATH:/home/zhoujiaming/usrbin"

#. ~/packages/z.sh
eval "$(~/usrbin/lua54 ~/usrbin/z.lua --init bash enhanced once)"
alias zb='z -b'

# vscode terminal tmux run 'code filename'
socket=$(ls -1t /run/user/$UID/vscode-ipc-*.sock 2> /dev/null | head -1)
export VSCODE_IPC_HOOK_CLI=${socket}

alias aria='conda run -n torch190 --no-capture-output aria2c -x 5 --check-certificate=false'
alias neofetch='conda run -n base neofetch'

alias rm='trash-put'

# conda activate hitrans
cd ~/kyoto/nlpcode/SemTransModel/SemTM

# overlay /etc/profile display=:2.0 setting
if [ -n "${SSH_CLIENT}" ] ; then
 export DISPLAY='localhost:10.0'
fi
