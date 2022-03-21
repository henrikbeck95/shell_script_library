#############################
#Dysplay dialog
#############################

check_if_variable_is_null(){
    local VALUE_VARIABLE=$1

    if [[ "$VALUE_VARIABLE" == "" ]]; then
            echo "true"
        else
            echo "false"
    fi
}

check_if_variable_is_number(){
    local VALUE_VARIABLE=$1

    if [[ "$VALUE_VARIABLE" =~ ^[0-9]+$ ]]; then
            echo "true"
        else
            echo "false"
    fi
}

display_dialog_ask_question_yes_or_no(){
    local VALUE_MESSAGE_QUESTION_HEADER=$1
    local VALUE_MESSAGE_QUESTION_ANSWER

    while true; do
        read -p "$VALUE_MESSAGE_QUESTION_HEADER [Y/n] " VALUE_MESSAGE_QUESTION_ANSWER

        case $VALUE_MESSAGE_QUESTION_ANSWER in
            [Yy]*)
                echo "true"
                break
                ;;
            [Nn]*)
                echo "false"
                break
                ;;
            *) echo "Incorrect Input. Please answer Y for yes or N for no."
        esac
    done
}

display_dialog_ask_question_number(){
    local VALUE_MESSAGE_QUESTION_HEADER=$1
    local VALUE_MESSAGE_QUESTION_ANSWER

    while true; do
        read -p "$VALUE_MESSAGE_QUESTION_HEADER [Type a number value] " VALUE_MESSAGE_QUESTION_ANSWER

        case $(check_if_variable_is_number "$VALUE_MESSAGE_QUESTION_ANSWER") in
            "false") 
                echo "Incorrect Input. Please answer a number value."
                ;;
            "true")
                echo "$VALUE_MESSAGE_QUESTION_ANSWER"
                break
                ;;
        esac
    done
}

display_dialog_ask_question_text(){
    local VALUE_MESSAGE_QUESTION_HEADER=$1
    local VALUE_MESSAGE_QUESTION_ANSWER

    while true; do
        read -p "$VALUE_MESSAGE_QUESTION_HEADER [Y/n] " VALUE_MESSAGE_QUESTION_ANSWER

        case $(check_if_variable_is_null "$VALUE_MESSAGE_QUESTION_ANSWER") in
            "false") 
                echo "$VALUE_MESSAGE_QUESTION_ANSWER"
                break
                ;;
            "true")
                echo "Incorrect Input. Please answer the question."
                ;;
        esac
    done
}

#It is working but not attributing the result to a variable when encapsuled
display_dialog_ask_question_menu(){
    echo -e "\nSelect a correspondent number of the description. Type '0' to exit!\n"

    select option; do # in "$@" is the default
        if [ "$REPLY" -eq "0" ]; then
            echo "Exiting..."
            break;
        elif [ 1 -le "$REPLY" ] && [ "$REPLY" -le $(($#)) ]; then
            case $(display_dialog_ask_question_yes_or_no "You have selected '$option' which is option '$REPLY'. Are you sure?") in
                "false") : ;;
                "true")
                    echo "$option"
                    break
                    ;;
            esac
        else
            echo "Incorrect Input. Please select a number between 1 and $#"
        fi
    done
}