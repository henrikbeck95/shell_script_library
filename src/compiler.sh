#!/usr/bin/env sh

##############################
#Declaring variables
##############################

AUX1=$1

EDITOR="vim"

#Use path /run/host/ #For Flatpak applications
PATH_SCRIPT="$(dirname "$(readlink -f "$0")")"

LINK_GITHUB="https://github.com/henrikbeck95/shell_script_library.git"
PATH_REPOSITORY_CLONE="/tmp/shell_script_library"
PATH_FILE_LIBRARY_COMPILING="/tmp/shell-script-library"
#PATH_FILE_LIBRARY_COMPILED="/usr/local/bin/shell-script-library"
PATH_FILE_LIBRARY_COMPILED="$HOME/.local/bin/shell-script-library"
PATH_FILE_LIBRARY_GENERATED="$PATH_SCRIPT/shell-script-library"
PATH_FILE_MODULES_COMPILING="$PATH_REPOSITORY_CLONE/src/modules"

SOFTWARE_NAME="Shell Script Library"

MESSAGE_HELP="
\t\t\t\t\t\t\t${SOFTWARE_NAME}
\t\t\t\t\t\t\t--------------------
[Credits]
Author: Henrik Beck
E-mail: henrikbeck95@gmail.com
License: GPL3
Version: v1.0.2

[Description]
This is a dedicated compiler tool for ${SOFTWARE_NAME} project which can be used as a default installer.
It merges all the source code modules into one single file. It is able to install/uninstall this file and clean up the unused files.

[Parameters]
-h\t--help\t-?\t\t\tDisplay this message help
-e\t--edit\t\t\t\tEdit this script file
-d\t--download\t\t\tDownload the ${SOFTWARE_NAME} modules by cloning the repository to /tmp/ directory
-cls\t--clear-local\t\t\tClear all the source modules from ${SOFTWARE_NAME}.
-cl\t--compile-local\t\t\tCompile the ${SOFTWARE_NAME} modules from local machine while developing this tool
-cr\t--compile-repository\t\tCompile the ${SOFTWARE_NAME} modules from cloned repository from /tmp/ directory
-r\t--remove\t\t\tRemove the ${SOFTWARE_NAME} modules files by removing the cloned repository from /tmp/ directory
-crun\t--compile-local-run\t\t\tCompile the ${SOFTWARE_NAME} modules, copy it into ${PATH_FILE_LIBRARY_COMPILED} path and import it.
-i\t--install\t\t\tInstall the ${SOFTWARE_NAME} by moving the compiled file to /usr/local/bin/ directory
-u\t--uninstall\t\t\tUninstall the ${SOFTWARE_NAME} by removing the file from /usr/local/bin/ directory
"

MESSAGE_ERROR="Invalid option for $0!\n$MESSAGE_HELP"

##############################
#Functions - tools
##############################

#@annotation_must_be_deprecated "In favor of merger.sh file"
util_check_if_file_exists() {
    local VALUE_PATH_FILE="$1"

    if [[ -f $VALUE_PATH_FILE ]]; then
        echo "true"
    else
        echo "false"
    fi
}

#@annotation_must_be_deprecated "In favor of merger.sh file"
util_check_if_folder_exists() {
    local VALUE_PATH_FOLDER="$1"

    if [[ -d "$VALUE_PATH_FOLDER" ]]; then
        echo "true"
    else
        echo "false"
    fi
}

##############################
#Functions - normal
##############################

#@annotation_must_be_deprecated "In favor of merger.sh file" "This function is not going to be migrated"
shell_script_library_modules_remove_files_used_for_compilation() {
    rm -fr "$PATH_REPOSITORY_CLONE"
}

#@annotation_must_be_deprecated "In favor of merger.sh file"
shell_script_library_modules_uninstall() {
    rm -f "$PATH_FILE_LIBRARY_COMPILED"
}

#@annotation_must_be_tested "This function is going to be migrate to merger.sh file soon"
shell_script_library_modules_clear_from_local() {
    local PATH_SCRIPT

    PATH_SCRIPT="$(dirname "$(readlink -f "$0")")"
    local PATH_FILE_MODULES_COMPILING="$PATH_SCRIPT/modules"
    local PATH_FILE_LIBRARY_COMPILING="$PATH_SCRIPT/shell-script-library"
    local FILENAME_AUX

    #filename=$(basename -- "$fullfile")
    #extension="${filename##*.}"
    #filename="${filename%.*}"

    for i in "$PATH_FILE_MODULES_COMPILING"/*sh; do
        #Get filename without full path
        FILENAME_AUX="${i##*/}"

        #Check if file name does not start with _ character
        if [[ ! "$FILENAME_AUX" =~ ^_ ]]; then
            echo "Clearing the $i file content..."
            #echo $i # >> $PATH_FILE_LIBRARY_COMPILING
            cat /dev/null >"$i"
        fi
    done
}

#@annotation_must_be_deprecated "In favor of merger.sh file"
shell_script_library_modules_compile_from_local() {
    local PATH_SCRIPT

    #PATH_SCRIPT=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    PATH_SCRIPT="$(dirname "$(readlink -f "$0")")"
    local PATH_FILE_MODULES_COMPILING="$PATH_SCRIPT/modules"
    local PATH_FILE_LIBRARY_COMPILING="$PATH_SCRIPT/shell-script-library"
    local FILENAME_AUX

    #Clean up the file
    cat /dev/null >"$PATH_FILE_LIBRARY_COMPILING"

    #Compile all modules into one single file
    cat "$PATH_FILE_MODULES_COMPILING"/header.txt >"$PATH_FILE_LIBRARY_COMPILING"

    #filename=$(basename -- "$fullfile")
    #extension="${filename##*.}"
    #filename="${filename%.*}"

    for i in "$PATH_FILE_MODULES_COMPILING"/*sh; do
        # i="${i%.*}"
        # i="${i##*.}"

        #Get filename without full path
        FILENAME_AUX="${i##*/}"

        #Check if file name does not start with _ character
        if [[ ! "$FILENAME_AUX" =~ ^_ ]]; then
            echo -e "\n" >>"$PATH_FILE_LIBRARY_COMPILING"
            cat "$i" >>"$PATH_FILE_LIBRARY_COMPILING"
        fi
    done
}

#@annotation_must_be_deprecated "In favor of merger.sh file"
shell_script_library_modules_compile_from_repository() {
    #Clean up the file
    cat /dev/null >"$PATH_FILE_LIBRARY_COMPILING"

    #Compile all modules into one single file
    cat "$PATH_FILE_MODULES_COMPILING"/header.txt >"$PATH_FILE_LIBRARY_COMPILING"

    for i in "$PATH_FILE_MODULES_COMPILING"/*sh; do
        echo -e "\n" >>"$PATH_FILE_LIBRARY_COMPILING"
        cat "$i" >>"$PATH_FILE_LIBRARY_COMPILING"
    done
}

#@annotation_must_be_deprecated "In favor of merger.sh file"
shell_script_library_compilation_and_running() {
    shell_script_library_modules_compile_from_local
    chmod +x "$PATH_FILE_LIBRARY_GENERATED"
    cp -f "$PATH_FILE_LIBRARY_GENERATED" "$PATH_FILE_LIBRARY_COMPILED"
    #sudo cp -f "$PATH_FILE_LIBRARY_GENERATED" "$PATH_FILE_LIBRARY_COMPILED"
    #sudo mv $"$PATH_FILE_LIBRARY_GENERATED" "$PATH_FILE_LIBRARY_COMPILED"

    #Importing Shell Script Library
    if [[ -f "$PATH_FILE_LIBRARY_COMPILED" ]]; then
        source "$PATH_FILE_LIBRARY_COMPILED"

        display_message_value_status_success_complex "Shell Script Library has been compiled, installed and loaded."
    else
        echo -e "Shell Script Library has not been found."
    fi
}

#@annotation_must_be_deprecated "In favor of merger.sh file" "This function is not going to be migrated"
shell_script_library_modules_download() {
    case $(util_check_if_folder_exists "$1") in
    "false") : ;;
    "true") shell_script_library_modules_remove_files_used_for_compilation ;;
    esac

    git clone $LINK_GITHUB $PATH_REPOSITORY_CLONE
}

#@annotation_must_be_deprecated "In favor of merger.sh file"
shell_script_library_modules_install() {
    case $(util_check_if_file_exists "$1") in
    "false") : ;;
    "true") shell_script_library_modules_uninstall ;;
    esac

    mv "$PATH_FILE_LIBRARY_COMPILING" "$PATH_FILE_LIBRARY_COMPILED"
}

##############################
#Calling the functions
##############################

#clear

case $AUX1 in
"" | "-h" | "--help" | "-?") echo -e "$MESSAGE_HELP" ;;
"-e" | "--edit") $EDITOR "$0" ;;
"-d" | "--download") shell_script_library_modules_download "$PATH_FILE_LIBRARY_COMPILED" ;;
"-cls" | "--clear-local") shell_script_library_modules_clear_from_local ;;
"-cl" | "--compile-local") shell_script_library_modules_compile_from_local ;;
"-cr" | "--compile-repository") shell_script_library_modules_compile_from_repository ;;
"-crun" | "--compile-local-run") shell_script_library_compilation_and_running ;;
"-i" | "--install") shell_script_library_modules_install "$PATH_FILE_LIBRARY_COMPILING" ;;
"-r" | "--remove") shell_script_library_modules_remove_files_used_for_compilation ;;
"-u" | "--uninstall") shell_script_library_modules_uninstall ;;
*) echo -e "$MESSAGE_ERROR" ;;
esac
