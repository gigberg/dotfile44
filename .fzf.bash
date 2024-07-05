# Setup fzf
# ---------
if [[ ! "$PATH" == */home/zhoujiaming/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/zhoujiaming/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/zhoujiaming/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/zhoujiaming/.fzf/shell/key-bindings.bash"

