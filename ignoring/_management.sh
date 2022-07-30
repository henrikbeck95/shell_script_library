#############################
#Shell Script Library management
#############################

#@annotation_must_be_created
#display_library_version(){}
#@annotation_must_be_create
#display_info_library_version(){}
#@annotation_must_be_created
#update_current_library_version(){}

top_level_parent_pid1() {
    #Check if stdout is terminal or returning to a variable
    if [[ -t 1 ]]; then
        #echo "Terminal"
        echo "stdout"
    else
        #echo "Not-a-terminal"
        echo "return"
    fi
}

top_level_parent_pid() {
    echo "$-"
    case $- in
    *i*) echo "this shell is interactive" ;;
    *) echo "this shell is not interactive" ;;
    esac
}

utils_check_if_output_is_return() {
    case $(top_level_parent_pid) in
    "return") echo "true" ;;
    "stdout") echo "false" ;;
    *) echo "unknown" ;;
    esac
}

utils_check_if_output_is_stdout() {
    case $(top_level_parent_pid) in
    "return") echo "false" ;;
    "stdout") echo "true" ;;
    *) echo "unknown" ;;
    esac
}
