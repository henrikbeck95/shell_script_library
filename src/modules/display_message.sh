#############################
#Display message
#############################

#Clock
#while : ; do printf "\r$(date)" && sleep 1 ; done

#Print log
#printf + date + content

display_message_content_line_clear() {
	#echo -n "\r"
	printf "\r"
}

display_message_content_line_replace() {
	local DISPLAY_TEXT="$1"

	#echo -n "\r$DISPLAY_TEXT"
	#printf "\r$DISPLAY_TEXT"
	printf "\r%s" "$DISPLAY_TEXT"
}

display_message_position_align_center_complex() {
	local DISPLAY_TEXT_MESSAGE="$1"
	local CHARACTER_REPETITION="#"

	local DISPLAY_TEXT_LENGTH
	local SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_MAXIMUM
	local SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF

	DISPLAY_TEXT_LENGTH=$(string_count_character "$DISPLAY_TEXT_MESSAGE")
	SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_MAXIMUM=$(utils_screen_size_count_limit_maximum_characters_horizontal)
	SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF=$(utils_screen_size_count_limit_half_characters_horizontal "$SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_MAXIMUM" "$DISPLAY_TEXT_LENGTH")

	#Displaying before text
	utils_screen_size_fill_limit_half_characters_horizontal "$CHARACTER_REPETITION" "$SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF" "${COLOR_STATUS_SUCCESS}"

	#Displaying the text
	display_message_value_text_default_simple "${DISPLAY_TEXT_MESSAGE}"

	#Displaying after text
	case $(utils_check_if_variable_number_is_even "$DISPLAY_TEXT_LENGTH") in
	"false") SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF=$(($SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF + 1)) ;;
		#"true") SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF=$(($SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF+0)) ;;
	esac

	utils_screen_size_fill_limit_half_characters_horizontal "$CHARACTER_REPETITION" "$SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF" "${COLOR_STATUS_SUCCESS}"
}

display_message_position_align_center_simple() {
	local DISPLAY_TEXT_MESSAGE="$1"
	local CHARACTER_REPETITION=" "
	local DISPLAY_TEXT_LENGTH
	local SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_MAXIMUM
	local SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF

	DISPLAY_TEXT_LENGTH=$(string_count_character "$DISPLAY_TEXT_MESSAGE")
	SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF=$(utils_screen_size_count_limit_half_characters_horizontal "$SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_MAXIMUM" "$DISPLAY_TEXT_LENGTH")
	SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_MAXIMUM=$(utils_screen_size_count_limit_maximum_characters_horizontal)

	#Displaying before text
	utils_screen_size_fill_limit_half_characters_horizontal "$CHARACTER_REPETITION" "$SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF" "${COLOR_STATUS_SUCCESS}"

	#Displaying the text
	display_message_value_text_default_simple "${DISPLAY_TEXT_MESSAGE}"

	#Displaying after text
	case $(utils_check_if_variable_number_is_even "$DISPLAY_TEXT_LENGTH") in
	"false") SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF=$((SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF + 1)) ;;
		#"true") SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF=$((SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF+0)) ;;
	esac

	utils_screen_size_fill_limit_half_characters_horizontal "$CHARACTER_REPETITION" "$SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF" "${COLOR_STATUS_SUCCESS}"
}

display_message_separator_complex() {
	local CHARACTER_REPETITION="#"
	local SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF

	SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF=$(utils_screen_size_count_limit_maximum_characters_horizontal)

	utils_screen_size_fill_limit_half_characters_horizontal "$CHARACTER_REPETITION" "$SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF" "${COLOR_STATUS_SUCCESS}"

	display_message_value_text_default_simple "\n"
}

display_message_separator_simple() {
	local CHARACTERS_UNITS
	local CHARACTER_REPETITION

	CHARACTERS_UNITS=30 #$(string_count_character "$DISPLAY_TEXT")
	CHARACTER_REPETITION=$(string_repeat_character $CHARACTERS_UNITS "#")

	display_message_value_text_default_simple "${COLOR_STATUS_DEFAULT}${CHARACTER_REPETITION}${COLOR_END}"
}

#display_message_tabular_number_complex(){}

#display_message_tabular_number_number(){}

display_message_tabular_text_complex() {
	local DISPLAY_TEXT="$1"
	#local DISPLAY_TEXT="$@"

	display_message_value_text_default_complex "$DISPLAY_TEXT" | tr : , | sed -e 's/^/| /' -e 's/,/,| /g' -e 's/$/,|/' | column -t -s,
}

display_message_tabular_text_simple() {
	local DISPLAY_TEXT="$1"
	#local DISPLAY_TEXT="$@"

	display_message_value_text_default_simple "$DISPLAY_TEXT" | tr : , | sed -e 's/^/| /' -e 's/,/,| /g' -e 's/$/,|/' | column -t -s,
}

display_message_value_number_complex() {
	local DISPLAY_TEXT="$1"

	#printf "%s\n" "$DISPLAY_TEXT"
	printf "%s\n" "$DISPLAY_TEXT" 2>/dev/null
	#printf '%.2f\n' "$DISPLAY_TEXT"
}

display_message_value_number_simple() {
	local DISPLAY_TEXT="$1"

	#printf "%s" "$DISPLAY_TEXT"
	printf "%s" "$DISPLAY_TEXT" 2>/dev/null
	#printf "%s\n" "$DISPLAY_TEXT" 2> /dev/null
	#printf "%s" "$DISPLAY_TEXT" 2>&1 /dev/null

	#echo -e "parentPid:\t\t$(top_level_parent_pid)"
	#echo -e "$TOP_LEVEL_PARENT_PID"

	#echo -e "isReturn:\t\t$(utils_check_if_output_is_return)"
	#echo -e "isStdout:\t\t$(utils_check_if_output_is_stdout)"
}

#display_message_value_status_empty_center(){}

display_message_value_status_empty_complex() {
	local DISPLAY_TEXT="This is an empty function. Please fill it with some instructions"
	local CHARACTERS_UNITS
	local CHARACTER_REPETITION

	CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	CHARACTER_REPETITION=$(string_repeat_character "$CHARACTERS_UNITS" "#")

	display_message_value_text_default_complex "${COLOR_STATUS_EMPTY}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_value_status_empty_simple() {
	local DISPLAY_TEXT="This is an empty function. Please fill it with some instructions"

	#display_message_value_text_default_simple "${DISPLAY_TEXT}"
	display_message_value_text_default_simple "${COLOR_STATUS_EMPTY}${DISPLAY_TEXT}${COLOR_END}"
}

#display_message_value_status_error_center(){}

display_message_value_status_error_complex() {
	#local DISPLAY_TEXT="¯\_(ツ)_/¯ ERROR! $1"
	local DISPLAY_TEXT="¯\_(ツ)_/¯ FAILURE! $1"
	local CHARACTERS_UNITS
	local CHARACTER_REPETITION

	CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	CHARACTER_REPETITION=$(string_repeat_character "$CHARACTERS_UNITS" "#")

	display_message_value_text_default_complex "${COLOR_STATUS_ERROR}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_value_status_error_simple() {
	#local DISPLAY_TEXT="¯\_(ツ)_/¯ ERROR! $1"
	local DISPLAY_TEXT="¯\_(ツ)_/¯ FAILURE! $1"

	#display_message_value_text_default_simple "${DISPLAY_TEXT}"
	display_message_value_text_default_simple "${COLOR_STATUS_ERROR}${DISPLAY_TEXT}${COLOR_END}"
}

#display_message_value_status_success_center(){}

display_message_value_status_success_complex() {
	local DISPLAY_TEXT="***${1}***"
	local CHARACTERS_UNITS
	local CHARACTER_REPETITION

	CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	CHARACTER_REPETITION=$(string_repeat_character "$CHARACTERS_UNITS" "#")

	display_message_value_text_default_complex "${COLOR_STATUS_SUCCESS}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_value_status_success_simple() {
	local DISPLAY_TEXT="$1"

	#display_message_value_text_default_simple "${DISPLAY_TEXT}"
	display_message_value_text_default_simple "${COLOR_STATUS_SUCCESS}${DISPLAY_TEXT}${COLOR_END}"
}

#display_message_value_status_warning_center(){}

display_message_value_status_warning_complex() {
	local DISPLAY_TEXT="$1"
	local CHARACTERS_UNITS
	local CHARACTER_REPETITION

	CHARACTERS_UNITS=$(string_count_character "$DISPLAY_TEXT")
	CHARACTER_REPETITION=$(string_repeat_character "$CHARACTERS_UNITS" "#")

	display_message_value_text_default_complex "${COLOR_STATUS_WARNING}${CHARACTER_REPETITION}\n${DISPLAY_TEXT}\n${CHARACTER_REPETITION}${COLOR_END}"
}

display_message_value_status_warning_simple() {
	local DISPLAY_TEXT="$1"

	#display_message_value_text_default_simple "${DISPLAY_TEXT}"
	display_message_value_text_default_simple "${COLOR_STATUS_WARNING}${DISPLAY_TEXT}${COLOR_END}"
}

#@annotation_must_be_improved
display_message_value_text_block_complex() {
	local TEXT_INPUT="$1"
	#local TEXT_TAB_SPACE=$(echo -e "\t")

	local TEXT_REMOVING_MARGIN_LEFT=$(sed 's/^ *//' <<<$TEXT_INPUT)
	#local TEXT_REMOVING_MARGIN_LEFT=$(sed '1d;s/^.*//' <<< $TEXT_INPUT)

	#sed 's/\//\'$'\t/g' <<< '
	#sed 's/\t/\'\\t'\t/g' <<< '

	#cat <<< "$TEXT_REMOVING_MARGIN_LEFT"
	#printf '%s\n' "$TEXT_REMOVING_MARGIN_LEFT"
	echo -e "$TEXT_REMOVING_MARGIN_LEFT"

	#local TEXT_REPLACING_TO_LINE_BREAK=$()
	#echo -e "$TEXT_REPLACING_TO_LINE_BREAK"

	#local TEXT_REPLACING_TO_TABS=$(sed 's/\\t/    /g' <<< $TEXT_INPUT)
	#local TEXT_REPLACING_TO_TABS=$(sed 's/\//\'$'\t/g' <<< $TEXT_INPUT)
	#local TEXT_REPLACING_TO_TABS=$(sed 's/\t/\'\\t'\t/g' <<< $TEXT_INPUT)
	#echo -e "$TEXT_REPLACING_TO_TABS"

	#printf %s "\
	#"

	#cat <<< '
	#'

	#display_message_value_text_block_simple '
	#'
}

display_message_value_text_block_simple() {
	#printblock
	printf %s "\
        $*
    "
}

#println
display_message_value_text_default_complex() {
	local DISPLAY_TEXT="$1"

	#echo -e "$DISPLAY_TEXT"
	printf "$DISPLAY_TEXT\n"
	#printf "%s\n" "$DISPLAY_TEXT"
}

display_message_value_text_default_simple() {
	local DISPLAY_TEXT="$1"

	#echo -n "$DISPLAY_TEXT"
	printf "$DISPLAY_TEXT"
	#printf "%s" "$DISPLAY_TEXT"
}
