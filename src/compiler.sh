#!/usr/bin/env sh

##############################
#Declaring variables
##############################

AUX1=$1

EDITOR="vim"

SOFTWARE_NAME="Shell Script Library"

LINK_GITHUB="https://github.com/henrikbeck95/shell_script_library.git"
PATH_REPOSITORY_CLONE="/tmp/shell_script_library"

PATH_FILE_LIBRARY_COMPILING="/tmp/shell-script-library.sh"
PATH_FILE_LIBRARY_COMPILED="/usr/local/bin/shell-script-library"
PATH_FILE_MODULES_COMPILING="$PATH_REPOSITORY_CLONE/src/modules"

#PATH_SCRIPT="$(dirname "$(readlink -f "$0")")"
#PATH_SCRIPT=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
#PATH_SCRIPT="${PATH_SCRIPT}/modules"
#PATH_SCRIPT_MODULES="${PATH_SCRIPT}/modules"

MESSAGE_HELP="
\t\t\t\t\t\t\t${SOFTWARE_NAME}
\t\t\t\t\t\t\t--------------------
[Credits]
Author: Henrik Beck
E-mail: henrikbeck95@gmail.com
License: GPL3
Version: v1.0.1

[Description]
This is a dedicated compiler tool for ${SOFTWARE_NAME} project which can be used as a default installer.
It merges all the source code modules into one single file. It is able to install/uninstall this file and clean up the unused files.

[Parameters]
-h\t--help\t-?\t\t\tDisplay this message help
-e\t--edit\t\t\t\tEdit this script file
-d\t--download\t\t\tDownload the ${SOFTWARE_NAME} modules by cloning the repository to /tmp/ directory
-cl\t--compile-local\t\t\tCompile the ${SOFTWARE_NAME} modules from local machine while developing this tool
-cr\t--compile-repository\t\tCompile the ${SOFTWARE_NAME} modules from cloned repository from /tmp/ directory
-r\t--remove\t\t\tRemove the ${SOFTWARE_NAME} modules files by removing the cloned repository from /tmp/ directory
-i\t--install\t\t\tInstall the ${SOFTWARE_NAME} by moving the compiled file to /usr/local/bin/ directory
-u\t--uninstall\t\t\tUninstall the ${SOFTWARE_NAME} by removing the file from /usr/local/bin/ directory
"

MESSAGE_ERROR="Invalid option for $0!\n$MESSAGE_HELP"

##############################
#Functions - tools
##############################

util_check_if_file_exists(){
    local VALUE_PATH_FILE="$1"

    if [[ -f $VALUE_PATH_FILE ]]; then
        echo "true"
    else
        echo "false"
    fi
}

util_check_if_folder_exists(){
    local VALUE_PATH_FOLDER="$1"

    if [[ -d $VALUE_PATH_FOLDER ]]; then
        echo "true"
    else
        echo "false"
    fi
}

##############################
#Functions - normal
##############################

shell_script_library_modules_remove_files_used_for_compilation(){
    rm -fr $PATH_REPOSITORY_CLONE
}

shell_script_library_modules_uninstall(){
    rm -f $PATH_FILE_LIBRARY_COMPILED
}

shell_script_library_modules_compile_from_local(){
    local PATH_SCRIPT="$(dirname "$(readlink -f "$0")")"
    
    local PATH_FILE_MODULES_COMPILING="$PATH_SCRIPT/modules"
    local PATH_FILE_LIBRARY_COMPILING="$PATH_SCRIPT/shell-script-library.sh"
    
    #Clean the file
    cat /dev/null > $PATH_FILE_LIBRARY_COMPILING
    
    #Compile all modules files into one single
    cat $PATH_FILE_MODULES_COMPILING/header.txt > $PATH_FILE_LIBRARY_COMPILING

    for i in $PATH_FILE_MODULES_COMPILING/*sh; do
        echo -e "\n" >> $PATH_FILE_LIBRARY_COMPILING
        cat $i >> $PATH_FILE_LIBRARY_COMPILING
    done
}

#MUST BE TESTED
shell_script_library_modules_compile_from_repository(){
    #Clean the file
    cat /dev/null > $PATH_FILE_LIBRARY_COMPILING

    #Compile all modules files into one single
#    cat $PATH_FILE_MODULES_COMPILING/header.txt > $PATH_FILE_LIBRARY_COMPILING

#    for i in $PATH_FILE_MODULES_COMPILING/*sh; do
#        #echo "$i"
#        echo -e "\n"
#        #echo -e "\n\n"
#        cat $i >> $PATH_FILE_LIBRARY_COMPILING
#    done
}

shell_script_library_modules_download(){
    case $(util_check_if_folder_exists) in
        "false") : ;;
        "true") shell_script_library_modules_remove_files_used_for_compilation ;;
    esac
    
    git clone $LINK_GITHUB $PATH_REPOSITORY_CLONE
}

shell_script_library_modules_install(){
    case $(util_check_if_file_exists) in
        "false") : ;;
        "true") shell_script_library_modules_uninstall ;;
    esac

    mv $PATH_FILE_LIBRARY_COMPILING $PATH_FILE_LIBRARY_COMPILED
}

##############################
#Calling the functions
##############################

clear

case $AUX1 in
    "" | "-h" | "--help" | "-?") echo -e "$MESSAGE_HELP" ;;
    "-e" | "--edit") $EDITOR $0 ;;
    "-d" | "--download") shell_script_library_modules_download ;;
    "-cl" | "--compile-local") shell_script_library_modules_compile_from_local ;;
    "-cr" | "--compile-repository") shell_script_library_modules_compile_from_repository ;;
    "-i" | "--install") shell_script_library_modules_install ;;
    "-r" | "--remove") shell_script_library_modules_remove_files_used_for_compilation ;;
    "-u" | "--uninstall") shell_script_library_modules_uninstall ;;
    *) echo -e "$MESSAGE_ERROR" ;;
esac