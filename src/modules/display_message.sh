#############################
#Display message
#############################

#Clear
#display_message_center_complex(){}

#with #####
#display_message_center_simple(){}

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
    local CHARACTERS_UNITS=`tput cols`
    local i=0

    while [ $i -lt $CHARACTERS_UNITS ]; do
        display_message_default_simple "${CHARACTER_REPETITION}"
        i=$(($i+1))

	    display_message_default_simple "${COLOR_STATUS_SUCCESS}${CHARACTER_REPETITION}${COLOR_END}"
        i=$(($i+1))
    done
    
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