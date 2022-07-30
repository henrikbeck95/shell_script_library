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
    #for i in {1..10}; do printf '\r'; done
    for i in {1..10}; do printf '\033[1A\033[K'; done

    display_message_value_status_success_complex "Shell Script Library is installed successfully! Like a said, no need to worry about it!"
fi

##############################
#Developing the script itself
##############################

#system_pkg_any_software_install_platform_ytfzf && . "$HOME/.bashrc"

display_message_value_text_block_complex '
#############################
#Credits
#############################
Author: Henrik Beck
E-mail: henrikbeck95@gmail.com
License: BSD 3-Clause License
#############################

Dedicatory: Made with <3 to my friend Gustavo Scarpim. É nóix Queiroz!

Usage example (try to copy and paste them)

youtube_audio_download "Guitar Hero III"
youtube_audio_play "Guitar Hero III"
youtube_video_download "Guitar Hero III"
youtube_video_play "Guitar Hero III"

- In case of problems, try reloading the shell environmets by closing the temrinal emulator window or typing:
    \t> $ source "$HOME/.bashrc"
    \t> $ source "$HOME/.bashrc"
'