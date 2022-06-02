# Setup for normal users

This tutorial is dedicated for anyone who just want to install the **Shell Script Library** manually.

## Installing

1. Download release latest version
    > $ `curl -fsSL github.com/henrikbeck95/shell_script_library/releases/latest/download/shell-script-library -O`

1. Move the **Shell Script Library** where your path environment can be loaded properly.
    - Moving the **Shell Script Library** into your system path
        > $ `mv ./shell-script-library /usr/local/bin/shell-script-library`

    - Moving the **Shell Script Library** into your local path
        > $ `mv ./shell-script-library $HOME/.local/bin/shell-script-library`

1. Give the executable permission
    > $ `chmod +x /usr/local/bin/shell-script-library`

## Usage

- Running **Shell Script Library** functionalities on terminal
    1. Import the Shell Script Library
        > $ `source /usr/local/bin/shell-script-library`

    1. Run a single command. For example:
        > $ `math_pi`

    - Output
        > 3.14159265358979323846

- Check this out for running **Shell Script Library** directly from your [shell environment](./setup_enviroment.md)

## Uninstalling

- Removing the **Shell Script Library** from your system path
    > $ `rm /usr/local/bin/shell-script-library`
    
- Removing the **Shell Script Library** from your local path
    > $ `rm $HOME/.local/bin/shell-script-library`