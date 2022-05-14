#############################
#Display message
#############################

#label_must_be_tested
#label_must_be_improved
display_message_default_complex(){
	#echo -e "$1"
	#printf "%s\n" "$1"
	printf "$1\n"
}

#label_must_be_tested
#label_must_be_improved
display_message_default_simple(){
	#echo -n "$1"
	#printf "%s" "$1"

	#echo "$1"
	printf "$1"
}

display_message_empty_complex(){
	local DISPLAY_TEXT="This is an empty function. Please fill it with some instructions"
	local CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	local CHARACTER_REPETITION=$(string_repeat_character $CHARACTERS_UNITS "#")

	display_message_default_complex "${COLOR_GRAY_DARK}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_empty_simple(){
	local DISPLAY_TEXT="This is an empty function. Please fill it with some instructions"

	display_message_default_simple "${DISPLAY_TEXT}"
}

display_message_error_complex(){
	local DISPLAY_TEXT="ERROR! ${1}"
	local CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	local CHARACTER_REPETITION=$(string_repeat_character $CHARACTERS_UNITS "#")

	display_message_default_complex "${COLOR_RED_LIGHT}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_error_simple(){
	local DISPLAY_TEXT="ERROR! $1"

	display_message_default_simple "${DISPLAY_TEXT}"
}

display_message_success_complex(){
	local DISPLAY_TEXT="***${1}***"
	local CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	local CHARACTER_REPETITION=$(string_repeat_character $CHARACTERS_UNITS "#")

	display_message_default_complex "${COLOR_GREEN_LIGHT}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_success_simple(){
	local DISPLAY_TEXT="$1"

	display_message_default_simple "${DISPLAY_TEXT}"
}

display_message_warning_complex(){
	local DISPLAY_TEXT="$1"
	local CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	local CHARACTER_REPETITION=$(string_repeat_character $CHARACTERS_UNITS "#")

	display_message_default_complex "${COLOR_YELLOW}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_warning_simple(){
	local DISPLAY_TEXT="$1"

	display_message_default_simple "${DISPLAY_TEXT}"
}