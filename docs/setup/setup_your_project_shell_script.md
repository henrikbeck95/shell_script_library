# Setup for projects

This tutorial is dedicated for shell script developers whose wants to use the benefits from **Shell Script Library** and guarantee that this library is going to be installed anywhere your script runs.

## Using it inside a shell script

- By using this method the **Shell Script Library** auto installation path is going to be:
    1. If the user executes the script with root privileges 
        > /usr/local/bin/shell-script-library

    1. If the user executes the script without root privileges 
        > $HOME/.local/bin/shell-script-library

- Implementation procedure
    1. Copy and paste code block bellow. Then start developing your script file.
    > This procedure auto installs the Shell Script Library when the user runs it is not already installed.

```bash
#!/usr/bin/env bash

##############################
#Load Shell Script Library
##############################
#
#The Shell Script Library on the following path:
#By running this shell script file with root privileges:
#/usr/local/bin/shell-script-library
#
#By running this shell script file without root privileges:
#$HOME/.local/bin/shell-script-library
#
##############################

SHELL_SCRIPT_LIBRARY_GLOBAL="/usr/local/bin/shell-script-library"
SHELL_SCRIPT_LIBRARY_LOCAL="$HOME/.local/bin/shell-script-library"

#Check if Shell Script library is installed to import it
if [ -f $SHELL_SCRIPT_LIBRARY_GLOBAL ] || [ -f $SHELL_SCRIPT_LIBRARY_LOCAL ]; then
    #shellcheck source=/dev/null
    . "$SHELL_SCRIPT_LIBRARY_GLOBAL" 2>/dev/null ||
        . "$SHELL_SCRIPT_LIBRARY_LOCAL" 2>/dev/null
else
    printf "Installing Shell Script Library for you..."

    #Downloading Shell Script Library
    curl -fsSL github.com/henrikbeck95/shell_script_library/releases/latest/download/shell-script-library -O ||
        wget github.com/henrikbeck95/shell_script_library/releases/latest/download/shell-script-library

    #Installing Shell Script Library
    mv ./shell-script-library "$SHELL_SCRIPT_LIBRARY_GLOBAL" 2>/dev/null ||
        mv ./shell-script-library "$SHELL_SCRIPT_LIBRARY_LOCAL" 2>/dev/null

    #Giving executable permission to Shell Script Library
    chmod +x "$SHELL_SCRIPT_LIBRARY_GLOBAL" 2>/dev/null ||
        chmod +x "$SHELL_SCRIPT_LIBRARY_LOCAL" 2>/dev/null

    . "$SHELL_SCRIPT_LIBRARY_GLOBAL" 2>/dev/null ||
        . "$SHELL_SCRIPT_LIBRARY_LOCAL" 2>/dev/null

    #Clear last 10 displayed output messages
    for i in {1..10}; do printf '\033[1A\033[K'; done

    display_message_value_status_success_complex "Shell Script Library is installed successfully! Like a said, no need to worry about it!"
fi

##############################
#Developing the script itself
##############################

#Your source code starts here...
```