# Disable greeting
set -g fish_greeting ""

# Environment Variables
set -gx EDITOR nvim
set -gx PATH $HOME/.local/bin $PATH

# Exports
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export GROFF_NO_SGR=1

# Aliases
alias ll="ls -lAh --color"


## Functions

# Functions needed for !!
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end


bind ! __history_previous_command


# Theme settings

fish_config theme choose catppuccin-macchiato


if status is-interactive
# Commands to run in interactive sessions can go here
starship init fish | source
end
