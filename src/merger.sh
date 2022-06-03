#!/usr/bin/env bash

##############################
#Declaring variables
##############################

EDITOR="vim"

#Use path /run/host/ #For Flatpak applications
PATH_SCRIPT="$(dirname "$(readlink -f "$0")")"
PATH_LIBRARY_MODULES_FILES_COMPILING="$PATH_SCRIPT/modules"
PATH_LIBRARY_MODULES_FILES_RESULT_ORIGINAL="$PATH_SCRIPT/shell-script-library"
PATH_LIBRARY_MODULES_FILES_RESULT_TESTER="$PATH_SCRIPT/shell-script-library-tester"
PATH_LIBRARY_RESULT_FILE_INSTALLATION=""

case "$UID" in
0) PATH_LIBRARY_RESULT_FILE_INSTALLATION="/usr/local/bin/shell-script-library" ;;
*) PATH_LIBRARY_RESULT_FILE_INSTALLATION="$HOME/.local/bin/shell-script-library" ;;
esac

SOFTWARE_NAME="Shell Script Library Merger"
SOFTWARE_VERSION="0.0.1"

MESSAGE_HELP="
\t\t\t\t\t\t\t${SOFTWARE_NAME}
\t\t\t\t\t\t\t---------------------------
[Credits]
Author: Henrik Beck
E-mail: henrikbeck95@gmail.com
License: GPL3
Version: ${SOFTWARE_VERSION}

[Description]
This is a dedicated compiler tool for ${SOFTWARE_NAME} project which can be used as a default installer.
It merges all the source code modules into one single file. It is able to install/uninstall this file and clean up the unused files.

[Parameters]
-h\t\t--help\t-?\t\tDisplay this message help
-e\t\t--edit\t\t\tEdit this script file with ${EDITOR} software.
-c-library\t--clear-library\t\tClear all the library modules files content from ${PATH_LIBRARY_MODULES_FILES_COMPILING}/.
-c-tester\t--clear-tester\t\tClear all the tester modules files content from ${PATH_LIBRARY_MODULES_FILES_COMPILING}/.
-i\t\t--install\t\tInstall the ${SOFTWARE_NAME} by moving the compiled file to ${PATH_LIBRARY_RESULT_FILE_INSTALLATION}.
-m-library\t--merge-library\t\tCompile all the library modules files content into ${PATH_LIBRARY_MODULES_FILES_RESULT_ORIGINAL}.
-m-library\t--merge-library\t\tCompile all the tester modules files content into ${PATH_LIBRARY_MODULES_FILES_RESULT_TESTER}.
-r-library\t--run-library\t\tRun/import ${PATH_LIBRARY_MODULES_FILES_RESULT_ORIGINAL} file.
-r-tester\t--run-tester\t\tRun ${PATH_LIBRARY_MODULES_FILES_RESULT_TESTER} file.
-u\t\t--uninstall\t\tUninstall the ${SOFTWARE_NAME} by removing the compiled file from ${PATH_LIBRARY_RESULT_FILE_INSTALLATION}.
-v\t\t--version\t\tDisplay ${SOFTWARE_NAME} version
"

##############################
#Functions - tools
##############################

utils_check_if_file_exists() {
    local VALUE_PATH_FILE="$1"

    if [[ -f $VALUE_PATH_FILE ]]; then
        echo "true"
    else
        echo "false"
    fi
}

utils_check_if_folder_exists() {
    local VALUE_PATH_FOLDER="$1"

    if [[ -d "$VALUE_PATH_FOLDER" ]]; then
        echo "true"
    else
        echo "false"
    fi
}

utils_clear_file() {
    local PATH_FILE="$1"

    echo -e "Clearing terminal history"

    case $(utils_check_if_file_exists "$PATH_FILE") in
    "false")
        echo -e "File $PATH_FILE does not exists"
        ;;
    "true")
        cat /dev/null >"$PATH_FILE"
        ;;
    esac
}

##############################
#Functions - normal
##############################

shell_script_library_modules_action_clear_original() {
    local FILENAME_WITH_FULL_PATH="$1"
    local FILENAME_WITHOUT_FULL_PATH="${FILENAME_WITH_FULL_PATH##*/}"

    #Check if file name does not start with _ character
    if [[ ! "$FILENAME_WITHOUT_FULL_PATH" =~ ^_ ]]; then
        echo "Clearing the $FILENAME_WITH_FULL_PATH module file content..."
        utils_clear_file "$FILENAME_WITH_FULL_PATH"
    fi
}

shell_script_library_modules_action_clear_tester() {
    local FILENAME_WITH_FULL_PATH="$1"
    local FILENAME_WITHOUT_FULL_PATH="${FILENAME_WITH_FULL_PATH##*/}"

    #Check if file name starts with _ character
    if [[ "$FILENAME_WITHOUT_FULL_PATH" =~ ^_ ]]; then
        echo "Clearing the $FILENAME_WITH_FULL_PATH module file content..."
        utils_clear_file "$FILENAME_WITH_FULL_PATH"
    fi
}

shell_script_library_modules_action_compile_original() {
    local FILENAME_WITH_FULL_PATH="$1"
    local FILENAME_WITHOUT_FULL_PATH="${FILENAME_WITH_FULL_PATH##*/}"

    #Check if file name does not start with _ character
    if [[ ! "$FILENAME_WITHOUT_FULL_PATH" =~ ^_ ]]; then
        #echo "Compiling the $FILENAME_WITH_FULL_PATH module file content into $PATH_LIBRARY_MODULES_FILES_RESULT_ORIGINAL..."
        echo -e "\n" >>"$PATH_LIBRARY_MODULES_FILES_RESULT_ORIGINAL"
        cat "$FILENAME_WITH_FULL_PATH" >>"$PATH_LIBRARY_MODULES_FILES_RESULT_ORIGINAL"
    fi
}

shell_script_library_modules_action_compile_tester() {
    local FILENAME_WITH_FULL_PATH="$1"
    local FILENAME_WITHOUT_FULL_PATH="${FILENAME_WITH_FULL_PATH##*/}"

    #Check if file name starts with _ character
    if [[ "$FILENAME_WITHOUT_FULL_PATH" =~ ^_ ]]; then
        #echo "Compiling the $FILENAME_WITH_FULL_PATH module file content into $PATH_LIBRARY_MODULES_FILES_RESULT_TESTER..."
        echo -e "\n" >>"$PATH_LIBRARY_MODULES_FILES_RESULT_TESTER"
        cat "$FILENAME_WITH_FULL_PATH" >>"$PATH_LIBRARY_MODULES_FILES_RESULT_TESTER"
    fi
}

shell_script_library_run_original() {
    case $(utils_check_if_file_exists "$PATH_LIBRARY_MODULES_FILES_RESULT_ORIGINAL") in
    "false") echo "Error! $PATH_LIBRARY_MODULES_FILES_RESULT_ORIGINAL file does not exists" ;;
    "true")
        chmod +x "$PATH_LIBRARY_MODULES_FILES_RESULT_ORIGINAL"
        "$PATH_LIBRARY_MODULES_FILES_RESULT_ORIGINAL"
        ;;
    esac
}

shell_script_library_run_tester() {
    case $(utils_check_if_file_exists "$PATH_LIBRARY_MODULES_FILES_RESULT_TESTER") in
    "false") echo "Error! $PATH_LIBRARY_MODULES_FILES_RESULT_TESTER file does not exists" ;;
    "true")
        chmod +x "$PATH_LIBRARY_MODULES_FILES_RESULT_TESTER"
        "$PATH_LIBRARY_MODULES_FILES_RESULT_TESTER"
        ;;
    esac
}

##############################
#Functions - calling
##############################

shell_script_library_install() {
    case $(utils_check_if_file_exists "$PATH_LIBRARY_MODULES_FILES_RESULT_ORIGINAL") in
    "false") : ;;
    "true") echo -e "Reinstalling the ${SOFTWARE_NAME}!" && shell_script_library_uninstall ;;
    esac

    cp "$PATH_LIBRARY_MODULES_FILES_RESULT_ORIGINAL" "$PATH_LIBRARY_RESULT_FILE_INSTALLATION" && echo -e "${SOFTWARE_NAME} installation process has been completed!" || echo -e "${SOFTWARE_NAME}installation process has been failed!"
}

shell_script_library_modules_action_clear_main() {
    local MODULE_ACTION_PLACE="$1"
    local FILENAME_WITH_FULL_PATH

    case "$MODULE_ACTION_PLACE" in
    "library")
        {
            for i in "$PATH_LIBRARY_MODULES_FILES_COMPILING"/*.sh; do
                FILENAME_WITH_FULL_PATH="${i}"
                shell_script_library_modules_action_clear_original "$FILENAME_WITH_FULL_PATH"
            done
        } && echo -e "Clearing library modules files process has been completed!" || echo -e "Clearing library modules files process has been failed!"
        ;;
    "tester")
        {
            for i in "$PATH_LIBRARY_MODULES_FILES_COMPILING"/*.sh; do
                FILENAME_WITH_FULL_PATH="${i}"
                shell_script_library_modules_action_clear_tester "$FILENAME_WITH_FULL_PATH"
            done
        } && echo -e "Clearing tester modules files process has been completed!" || echo -e "Clearing tester modules files process has been failed!"
        ;;
    esac
}

shell_script_library_modules_action_merge_main() {
    local MODULE_ACTION_PLACE="$1"
    local FILENAME_WITH_FULL_PATH

    case "$MODULE_ACTION_PLACE" in
    "library")
        {
            #Clean up the older file version
            utils_clear_file >"$PATH_LIBRARY_MODULES_FILES_RESULT_ORIGINAL"

            #Compile all modules into one single file
            cat "$PATH_LIBRARY_MODULES_FILES_COMPILING"/header.txt >"$PATH_LIBRARY_MODULES_FILES_RESULT_ORIGINAL"

            for i in "$PATH_LIBRARY_MODULES_FILES_COMPILING"/*.sh; do
                FILENAME_WITH_FULL_PATH="${i}"
                shell_script_library_modules_action_compile_original "$FILENAME_WITH_FULL_PATH"
            done
        } && echo -e "Merging library modules files process has been completed!" || echo -e "Merging library modules files process has been failed!"
        ;;
    "tester")
        {
            #Clean up the older file version
            utils_clear_file >"$PATH_LIBRARY_MODULES_FILES_RESULT_TESTER"

            #Compile all modules into one single file
            cat "$PATH_LIBRARY_MODULES_FILES_COMPILING"/header.txt >"$PATH_LIBRARY_MODULES_FILES_RESULT_TESTER"

            for i in "$PATH_LIBRARY_MODULES_FILES_COMPILING"/*.sh; do
                FILENAME_WITH_FULL_PATH="${i}"
                shell_script_library_modules_action_compile_tester "$FILENAME_WITH_FULL_PATH"
            done
        } && echo -e "Merging tester modules files process has been completed!" || echo -e "Merging tester modules files process has been failed!"
        ;;
    esac
}

shell_script_library_run_main() {
    local MODULE_ACTION_PLACE="$1"

    case "$MODULE_ACTION_PLACE" in
    "library") shell_script_library_run_original ;;
    "tester") shell_script_library_run_tester ;;
    esac
}

shell_script_library_uninstall() {
    case $(utils_check_if_file_exists "$PATH_LIBRARY_RESULT_FILE_INSTALLATION") in
    "false") : && echo -e "${SOFTWARE_NAME} uninstalling process has been not necessary. File not found!" ;;
    "true") rm "$PATH_LIBRARY_RESULT_FILE_INSTALLATION" && echo -e "${SOFTWARE_NAME} uninstalling process has been completed!" || echo -e "${SOFTWARE_NAME} uninstalling process has been failed!" ;;
    esac
}

shell_script_library_version() {
    echo -e "${SOFTWARE_NAME} version ${SOFTWARE_VERSION}"
}

##############################
#Calling the functions
##############################

clear

declare -i AUX=0

while [ -n "$1" ]; do
    #echo -e "The parameter[$AUX] has '$1' value"

    #Check the set parameters
    case $1 in
    "-h" | "--help" | "-?")
        echo -e "$MESSAGE_HELP"
        break
        ;;
    "-e" | "--edit")
        "$EDITOR" "$0"
        break
        ;;
        #"-c-library" | "--clear-library") shell_script_library_modules_action_clear_main "library" ;;
        #"-c-tester" | "--clear-tester") shell_script_library_modules_action_clear_main "tester" ;;
    "-i" | "--install") shell_script_library_install ;;
    "-m-library" | "--merge-library") shell_script_library_modules_action_merge_main "library" ;;
    "-m-tester" | "--merge-tester") shell_script_library_modules_action_merge_main "tester" ;;
    "-r-library" | "--run-library") shell_script_library_run_main "library" ;;
    "-r-tester" | "--run-tester") shell_script_library_run_main "tester" ;;
    "-u" | "--uninstall") shell_script_library_uninstall ;;
    #"-v" | "--version") shell_script_library_version ; break ;;
    "-v" | "--version") shell_script_library_version ;;
    *)
        if [[ $AUX -eq 0 ]]; then
            echo -e "Invalid option for $0!\n$MESSAGE_HELP"
        else
            echo -e "Invalid option for '$1' parameter."
        fi

        break
        ;;
    esac

    #Increment $i value to go to the next available parameter value
    AUX=$((AUX + 1))
    shift
done
