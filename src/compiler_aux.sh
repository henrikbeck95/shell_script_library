#!/usr/bin/env sh

##############################
#Declaring variables
##############################

if [[ -f /usr/local/bin/shell-script-library ]]; then #For host applications
    PATH_SHELL_SCRIPT_LIBRARY_COMPILER="/home/henrikbeck95/eclipse-workspace/shell_script_library/src/compiler.sh"
    PATH_SHELL_SCRIPT_LIBRARY_DESTINY="/usr/local/bin/shell-script-library"
    PATH_SHELL_SCRIPT_LIBRARY_ORIGIN="/home/henrikbeck95/eclipse-workspace/shell_script_library/src/shell-script-library"
    PATH_SHELL_SCRIPT_LIBRARY_URL=""
elif [[ -f /run/host/usr/local/bin/shell-script-library ]]; then #For Flatpak applications
    PATH_SHELL_SCRIPT_LIBRARY_COMPILER="/run/host/home/henrikbeck95/eclipse-workspace/shell_script_library/src/compiler.sh"
    PATH_SHELL_SCRIPT_LIBRARY_DESTINY="/run/host/usr/local/bin/shell-script-library"
    PATH_SHELL_SCRIPT_LIBRARY_ORIGIN="/run/host/home/henrikbeck95/eclipse-workspace/shell_script_library/src/shell-script-library"
    PATH_SHELL_SCRIPT_LIBRARY_URL=""
fi

##############################
#Functions
##############################

shell_script_library_compilation(){
    if [[ -f /usr/local/bin/shell-script-library ]]; then #For host applications
        $PATH_SHELL_SCRIPT_LIBRARY_COMPILER -cl
        chmod +x $PATH_SHELL_SCRIPT_LIBRARY_ORIGIN
        sudo cp -f $PATH_SHELL_SCRIPT_LIBRARY_ORIGIN $PATH_SHELL_SCRIPT_LIBRARY_DESTINY
        #sudo mv $$PATH_SHELL_SCRIPT_LIBRARY_ORIGIN $PATH_SHELL_SCRIPT_LIBRARY_DESTINY
    elif [[ -f /run/host/usr/local/bin/shell-script-library ]]; then #For Flatpak applications
        echo "This script is running inside a Flatpak application. So, this is not the appropriated place to compile something"
    fi
}

##############################
#Calling the functions
##############################

shell_script_library_compilation

if [[ -f $PATH_SHELL_SCRIPT_LIBRARY_DESTINY ]]; then
    #Import Shell Script Library
    source $PATH_SHELL_SCRIPT_LIBRARY_DESTINY

    display_message_success_complex "Shell Script Library has been compiled, installed and loaded."
else
    echo -e "Shell Script Library has not been found."
fi