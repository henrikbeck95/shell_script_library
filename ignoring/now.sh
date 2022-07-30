#!/usr/bin/env sh

#shellcheck source=/dev/null
#. "/usr/local/bin/shell-script-library" || exit
#. "$HOME/.local/bin/shell-script-library" || exit
. "$HOME/Desktop/tcc/shell_script_library/src/shell-script-library" || exit

#Search a method to download files in addition to pages text
#curl https://github.com/henrikbeck95/shell_script_library/ > /tmp/lalala.sh

##############################
#Implement sub functions for checking the status
#return 0 in case of success
#return 1 in case of troubleshoot
##############################

function_name_main_example_01() {
    function_name_sub() {
        local VARIABLE_01
        local VARIABLE_02

        #Doing an example about one thing you can try
        case $(system_pkg_check_package_manager) in
        "apt") system_pkg_default_software_install_single "true" "tesseract" ;;
        "pacman") system_pkg_default_software_install_single "true" "tesseract" ;;
        *) return 1 ;; #"The package manager could not be detected" ;;
        esac
    }

    #Analysing the subfunction status code
    local FUNCTION_STATUS_CODE
    FUNCTION_STATUS_CODE=$(function_name_sub)

    case "$FUNCTION_STATUS_CODE" in
    0) echo "Great! The software was installed successfully." ;;
    1) echo "Error! The software could not be installed." ;;
    esac
}

function_name_main_example_02() {
    function_name_sub() {
        #local VARIABLE_01
        #local VARIABLE_02

        #Doing an example about one thing you can try
        #cd /tmp/ || exit
        #utils_download_file "https://github.com/gokcehan/lf/releases/download/r26/lf-linux-amd64.tar.gz" "/tmp/"
        #utils_extract_file_tar "/tmp/lf-linux-amd64.tar.gz"

        echo "hi"
        #echo "oi" || : && echo "lalala"
        echo "hi again"

        #echo "STATUS: $?"
        #cd - || exit

        return 2

        #utils_move_file "/tmp/lf" "/usr/local/bin/lf"
        #utils_remove_file "/tmp/lf-linux-amd64.tar.gz"
    }

    #Analysing the subfunction status code
    local FUNCTION_STATUS_CODE
    #FUNCTION_STATUS_CODE=$(function_name_sub)
    
    function_name_sub
    FUNCTION_STATUS_CODE=$?

    echo "$FUNCTION_STATUS_CODE"

    case "$FUNCTION_STATUS_CODE" in
    0) echo "Great! The software was installed successfully." ;;
    1) echo "Error! The software could not be installed." ;;
    esac
}

#rm /tmp/lf-linux-amd64.tar.gz

#function_name_main_example_01
function_name_main_example_02