#############################
#Display dialog
#############################

display_dialog_ask_press_a_key() {
    local DISPLAY_TEXT="Press any key to continue..."

    display_message_value_text_default_simple "\n${COLOR_TEXT_REVERSE}${COLOR_TEXT_BOLD_AND_ITALIC}${DISPLAY_TEXT}${COLOR_TEXT_END}"
    read -rn1
}

#@annotation_must_be_tested
#@annotation_must_be_fixed
#It is working but not attributing the result to a variable when encapsuled
display_dialog_ask_question_menu() {
    local MENU_OPTION

    display_message_value_status_warning_complex "Select a correspondent number of the description. Type '0' to exit!"

    select MENU_OPTION; do # in "$@" is the default
        if [ "$REPLY" -eq "0" ]; then
            display_message_value_text_default_simple "Exiting..."
            break
        elif [ 1 -le "$REPLY" ] && [ "$REPLY" -le $(($#)) ]; then
            case $(display_dialog_ask_question_yes_or_no "You have selected '$MENU_OPTION' which is option '$REPLY'. Are you sure?") in
            "false")
                :
                break
                ;;
            "true")
                display_message_value_text_default_simple "$MENU_OPTION"
                break
                ;;
            esac
        else
            display_message_value_status_error_simple "Incorrect Input. Please select a number between 1 and $#"
        fi
    done
}

display_dialog_ask_question_number() {
    local VALUE_MESSAGE_QUESTION_HEADER="$1"
    local VALUE_MESSAGE_QUESTION_ANSWER

    while true; do
        read -rp "$VALUE_MESSAGE_QUESTION_HEADER [Type a number value] " VALUE_MESSAGE_QUESTION_ANSWER

        case $(utils_check_if_variable_is_number "$VALUE_MESSAGE_QUESTION_ANSWER") in
        "false")
            display_message_value_status_error_simple "Incorrect Input. Please answer a number value."
            #break
            ;;
        "true")
            display_message_value_text_default_simple "$VALUE_MESSAGE_QUESTION_ANSWER"
            break
            ;;
        esac
    done
}

#@annotation_must_be_tested
display_dialog_ask_question_text() {
    local VALUE_MESSAGE_QUESTION_HEADER="$1"
    local VALUE_MESSAGE_QUESTION_ANSWER

    while true; do
        read -rp "$VALUE_MESSAGE_QUESTION_HEADER [Type a text value] " VALUE_MESSAGE_QUESTION_ANSWER

        case $(utils_check_if_variable_is_null "$VALUE_MESSAGE_QUESTION_ANSWER") in
        "false")
            display_message_value_text_default_simple "$VALUE_MESSAGE_QUESTION_ANSWER"
            break
            ;;
        "true")
            display_message_value_status_error_simple "Incorrect Input. Please answer the question."
            #break
            ;;
        esac
    done
}

display_dialog_ask_question_yes_or_no() {
    local VALUE_MESSAGE_QUESTION_HEADER="$1"
    local VALUE_MESSAGE_QUESTION_ANSWER

    while true; do
        read -rp "$VALUE_MESSAGE_QUESTION_HEADER [Y/n] " VALUE_MESSAGE_QUESTION_ANSWER

        case $VALUE_MESSAGE_QUESTION_ANSWER in
        [Yy]*)
            display_message_value_text_default_simple "true"
            break
            ;;
        [Nn]*)
            display_message_value_text_default_simple "false"
            break
            ;;
        *) display_message_value_status_error_simple "Incorrect Input. Please answer Y for yes or N for no." ;;
        esac
    done
}
