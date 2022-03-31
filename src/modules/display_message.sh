#############################
#Display message
#############################

display_message_simple(){
	#echo -n "$1"
	#printf "%s" "$1"
	printf "$1"
}

display_message_default(){
	#echo -e "$1"
	#printf "%s\n" "$1"
	printf "$1\n"
}

display_message_empty(){
	local DISPLAY_TEXT="This is an empty function. Please fill it with some instructions"
	local CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	local CHARACTER_REPETITION=$(string_repeat_character $CHARACTERS_UNITS "#")

	display_message_default "${COLOR_GRAY_DARK}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_error(){
	local DISPLAY_TEXT="Error! ${1}"
	local CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	local CHARACTER_REPETITION=$(string_repeat_character $CHARACTERS_UNITS "#")

	display_message_default "${COLOR_RED_LIGHT}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_success(){
	local DISPLAY_TEXT="***${1}***"
	local CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	local CHARACTER_REPETITION=$(string_repeat_character $CHARACTERS_UNITS "#")

	display_message_default "${COLOR_GREEN_LIGHT}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_warning(){
	local DISPLAY_TEXT="$1"
	local CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	local CHARACTER_REPETITION=$(string_repeat_character $CHARACTERS_UNITS "#")

	display_message_default "${COLOR_YELLOW}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}