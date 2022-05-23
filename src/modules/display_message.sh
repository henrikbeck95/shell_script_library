#############################
#Display message
#############################

#Rename functions to the following style
#display_message_status_success_complex
#display_message_position_align_center
#display_message_separator_complex
#display_message_value_number_complex
#display_message_value_text_complex

#display_message_table_text_complex
#display_message_table_text_number

#display_message_table_number_complex
#display_message_table_number_number

display_message_content_clear(){
	#echo -n "\r"
    printf "\r"
}

display_message_number_complex(){
	local DISPLAY_TEXT="$1"

	printf "%s\n" "$DISPLAY_TEXT"
	#printf '%.2f\n' "$DISPLAY_TEXT"
}

display_message_number_simple(){
	local DISPLAY_TEXT="$1"

	printf "%s" "$DISPLAY_TEXT" 2> /dev/null
	#printf "%s" "$DISPLAY_TEXT" 2>&1 /dev/null
}

display_message_center_complex(){
    local DISPLAY_TEXT_MESSAGE=$1
	local CHARACTER_REPETITION="#"
	local DISPLAY_TEXT_LENGTH=$(string_count_character "$DISPLAY_TEXT_MESSAGE")
    local SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_MAXIMUM=$(utils_screen_size_count_limit_maximum_characters_horizontal)
    local SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF="$(utils_screen_size_count_limit_half_characters_horizontal $SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_MAXIMUM $DISPLAY_TEXT_LENGTH)"

    #Displaying before text
    utils_screen_size_fill_limit_half_characters_horizontal "$CHARACTER_REPETITION" "$SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF" "${COLOR_STATUS_SUCCESS}"

    #Displaying the text
    display_message_default_simple "${DISPLAY_TEXT_MESSAGE}"

    #Displaying after text
    case $(utils_check_if_variable_number_is_even "$DISPLAY_TEXT_LENGTH") in
        "false") SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF=$(($SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF+1)) ;;
        #"true") SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF=$(($SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF+0)) ;;
    esac

    utils_screen_size_fill_limit_half_characters_horizontal "$CHARACTER_REPETITION" "$SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF" "${COLOR_STATUS_SUCCESS}"
}

display_message_center_simple(){
    local DISPLAY_TEXT_MESSAGE=$1
	local CHARACTER_REPETITION=" "
	local DISPLAY_TEXT_LENGTH=$(string_count_character "$DISPLAY_TEXT_MESSAGE")
    local SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_MAXIMUM=$(utils_screen_size_count_limit_maximum_characters_horizontal)
    local SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF="$(utils_screen_size_count_limit_half_characters_horizontal $SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_MAXIMUM $DISPLAY_TEXT_LENGTH)"

    #Displaying before text
    utils_screen_size_fill_limit_half_characters_horizontal "$CHARACTER_REPETITION" "$SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF" "${COLOR_STATUS_SUCCESS}"

    #Displaying the text
    display_message_default_simple "${DISPLAY_TEXT_MESSAGE}"

    #Displaying after text
    case $(utils_check_if_variable_number_is_even "$DISPLAY_TEXT_LENGTH") in
        "false") SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF=$(($SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF+1)) ;;
        #"true") SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF=$(($SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF+0)) ;;
    esac

    utils_screen_size_fill_limit_half_characters_horizontal "$CHARACTER_REPETITION" "$SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF" "${COLOR_STATUS_SUCCESS}"
}

display_message_default_complex(){
	local DISPLAY_TEXT="$1"

	#echo -e "$DISPLAY_TEXT"
	printf "$DISPLAY_TEXT\n"
	#printf "%s\n" "$DISPLAY_TEXT"
}

display_message_default_simple(){
	local DISPLAY_TEXT="$1"

	#echo -n "$DISPLAY_TEXT"
	printf "$DISPLAY_TEXT"
	#printf "%s" "$DISPLAY_TEXT"
}

display_message_empty_complex(){
	local DISPLAY_TEXT="This is an empty function. Please fill it with some instructions"
	local CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	local CHARACTER_REPETITION=$(string_repeat_character $CHARACTERS_UNITS "#")

	display_message_default_complex "${COLOR_STATUS_EMPTY}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_empty_simple(){
	local DISPLAY_TEXT="This is an empty function. Please fill it with some instructions"

	#display_message_default_simple "${DISPLAY_TEXT}"
	display_message_default_simple "${COLOR_STATUS_EMPTY}${DISPLAY_TEXT}${COLOR_END}"
}

display_message_error_complex(){
	local DISPLAY_TEXT="ERROR! ${1}"
	local CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	local CHARACTER_REPETITION=$(string_repeat_character $CHARACTERS_UNITS "#")

	display_message_default_complex "${COLOR_STATUS_ERROR}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_error_simple(){
	local DISPLAY_TEXT="ERROR! $1"

	#display_message_default_simple "${DISPLAY_TEXT}"
	display_message_default_simple "${COLOR_STATUS_ERROR}${DISPLAY_TEXT}${COLOR_END}"
}

display_message_separator_complex(){
	local CHARACTER_REPETITION="#"
    local SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF=$(utils_screen_size_count_limit_maximum_characters_horizontal)
    local i=0

    utils_screen_size_fill_limit_half_characters_horizontal "$CHARACTER_REPETITION" "$SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF" "${COLOR_STATUS_SUCCESS}"

    display_message_default_simple "\n"
}

display_message_separator_simple(){
	local CHARACTERS_UNITS=30 #$(string_count_character "$DISPLAY_TEXT")
	local CHARACTER_REPETITION=$(string_repeat_character $CHARACTERS_UNITS "#")

	display_message_default_simple "${COLOR_STATUS_DEFAULT}${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_success_complex(){
	local DISPLAY_TEXT="***${1}***"
	local CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	local CHARACTER_REPETITION=$(string_repeat_character $CHARACTERS_UNITS "#")

	display_message_default_complex "${COLOR_STATUS_SUCCESS}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_success_simple(){
	local DISPLAY_TEXT="$1"

	#display_message_default_simple "${DISPLAY_TEXT}"
	display_message_default_simple "${COLOR_STATUS_SUCCESS}${DISPLAY_TEXT}${COLOR_END}"

}

display_message_tabular_text_complex(){
    #display_message_tabular_text_complex "Henrik:Beck:henrikbeck95@gmail.com\nSomebody:Surname:some_email_address@something.com"
    #display_message_tabular_text_complex "$(head -4 /etc/passwd)"
    
    local DISPLAY_TEXT="$1"
    #local DISPLAY_TEXT="$@"

	display_message_default_complex "$DISPLAY_TEXT" | tr : , | sed -e 's/^/| /' -e 's/,/,| /g' -e 's/$/,|/' | column -t -s,
}

display_message_tabular_text_simple(){
    #display_message_tabular_text_simple "Henrik:Beck:henrikbeck95@gmail.com\nSomebody:Surname:some_email_address@something.com"
    #display_message_tabular_text_simple "$(head -4 /etc/passwd)"
    
    local DISPLAY_TEXT="$1"
    #local DISPLAY_TEXT="$@"

	display_message_default_simple "$DISPLAY_TEXT" | tr : , | sed -e 's/^/| /' -e 's/,/,| /g' -e 's/$/,|/' | column -t -s,
}

display_message_warning_complex(){
	local DISPLAY_TEXT="$1"
	local CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	local CHARACTER_REPETITION=$(string_repeat_character $CHARACTERS_UNITS "#")

	display_message_default_complex "${COLOR_STATUS_WARNING}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_warning_simple(){
	local DISPLAY_TEXT="$1"

	#display_message_default_simple "${DISPLAY_TEXT}"
	display_message_default_simple "${COLOR_STATUS_WARNING}${DISPLAY_TEXT}${COLOR_END}"
}