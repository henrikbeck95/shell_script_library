#############################
#String
#############################

string_check_if_string_pattern_matches(){
    local CONTENT_STRING=$1
    local FILE_PATH=$2

	#Check if strings matches only if the file exists
	if [[ -f "$FILE_PATH" ]]; then
		if grep -q "$CONTENT_STRING" "$FILE_PATH"; then
			display_message_default_simple "true"
		else
			display_message_default_simple "false"
		fi
	else
		display_message_error_simple "fail"
	fi
}

string_convert_path_directory_from_unix_to_windows(){
    #string_convert_path_directory_from_unix_to_windows "/home/henrikbeck95/.asdf/"

    local PATH=$1
    local PATTERN_OLD="/"
    local PATTERN_NEW="\\"

    local RESULT=$(changeStringComplex "$PATH" "$PATTERN_OLD" "$PATTERN_NEW")
    
    display_message_default_simple "C:\\${RESULT}"
}

string_convert_path_directory_from_windows_to_unix(){
    # string_convert_path_directory_from_windows_to_unix "D://home\henrikbeck95\.asdf\\"
    local PATH=$1
    local PATTERN_OLD="\\"
    local PATTERN_NEW="/"

    local SYSTEM_DISK="${PATH:0:1}"
    local SYSTEM_DISK_LOWERCASE="${SYSTEM_DISK,,}"
    local SYSTEM_DISK_UPPERCASE="${SYSTEM_DISK^^}"

    local RESULT_AUX=$(changeStringSlashesFromBackwardToForward "$PATH" "$PATTERN_OLD" "$PATTERN_NEW")
    local RESULT_FINAL=$(changeStringComplex "$RESULT_AUX" "$SYSTEM_DISK_UPPERCASE://" "/mnt/${SYSTEM_DISK_LOWERCASE}/")

    display_message_default_simple "${RESULT_FINAL}"
}

string_convert_from_lower_to_upper(){
	display_message_default_simple "${@^^}"
}

string_convert_from_upper_to_lower(){
	display_message_default_simple "${@,,}"
}

string_count_character(){
	display_message_default_simple "${#1}"
}

string_get_content_between_interval(){
    #string_get_content_between_interval "Shell Script Library" "6" "6"
    
    local CONTENT_STRING=$1
    local VALUE_INTERVAL_BEGIN=$2
    local VALUE_INTERVAL_END=$3
    local RESULT=${CONTENT_STRING:$VALUE_INTERVAL_BEGIN:$VALUE_INTERVAL_END}

    display_message_default_simple "$RESULT"
}

string_get_content_character_first(){
    #string_get_content_character_first "Henrik Beck"
    
    local VALUE_VARIABLE=$1
    local VALUE_SIZE=$2
    local RESULT="${VALUE_VARIABLE::1}"

    display_message_default_simple "$RESULT"
}

string_get_content_character_from_begin(){
    #string_get_content_character_from_begin "Henrik Beck" "3"

    local VALUE_VARIABLE=$1
    local VALUE_SIZE=$2
    local RESULT="${VALUE_VARIABLE::VALUE_SIZE}"

    display_message_default_simple "$RESULT"
}

string_get_content_character_from_end(){
    #string_get_content_character_from_end "Henrik Beck" "3"

    local VALUE_VARIABLE=$1
    local VALUE_SIZE=$(($2 * -1))
    local RESULT="${VALUE_VARIABLE: $VALUE_SIZE}"

    display_message_default_simple "$RESULT"
}

string_get_content_character_last(){
    #string_get_content_character_last "Henrik Beck"

    local VALUE_VARIABLE=$1
    local VALUE_SIZE=$2
    local RESULT="${VALUE_VARIABLE: -1}"

    display_message_default_simple "$RESULT"
}

#label_must_be_improved
string_get_content_signal_before(){
    local VALUE_SIGNAL=$1
    local VALUE_VARIABLE=$(string_remove_empty_space_all $2)
    local VALUE_RESULT="${VALUE_VARIABLE%$VALUE_SIGNAL*}" #
    #local VALUE_RESULT="${VALUE_VARIABLE%%$VALUE_SIGNAL*}" #

    display_message_default_simple "$VALUE_RESULT"
}

string_get_content_signal_after_number(){
    local VALUE_SIGNAL=$1
    local VALUE_VARIABLE=$(string_remove_empty_space_all $2)
    #local VALUE_RESULT="${VALUE_VARIABLE#*$VALUE_SIGNAL}" #Since first value after match
    local VALUE_RESULT="${VALUE_VARIABLE##*$VALUE_SIGNAL}" #Only last value after match

    display_message_number_simple "$VALUE_RESULT"
}

string_get_content_signal_after_string(){
    local VALUE_SIGNAL=$1
    local VALUE_VARIABLE=$(string_remove_empty_space_all $2)
    #local VALUE_RESULT="${VALUE_VARIABLE#*$VALUE_SIGNAL}" #Since first value after match
    local VALUE_RESULT="${VALUE_VARIABLE##*$VALUE_SIGNAL}" #Only last value after match

    display_message_default_simple "$VALUE_RESULT"
}

string_remove_empty_space_all(){
    #local VALUE_VARIABLE="Hello      world."
    local VALUE_VARIABLE="$@"

    display_message_default_simple "${VALUE_VARIABLE//[[:space:]]/}"
}

string_repeat_character(){
    local VALUE_SIZE=$1
    local VALUE_CHARACTER=$2

	for ((i=0; i < $VALUE_SIZE; i++)); do
		display_message_default_simple "$VALUE_CHARACTER"
	done
}

#label_must_be_improved
#label_must_be_deprecated
#string_replace_slash_from_backward_to_forward
string_replace_backslash_to_forward_slash(){
	display_message_default_simple "$1" | sed 's/\\/\//g'
}

#label_must_be_improved
#label_must_be_deprecated
#string_replace_slash_from_forward_to_backward
string_replace_forward_slash_to_backslash_cancelled(){
	local TEXT_OLD="\/"
	local TEXT_NEW="\\\/"

	#Replace all the match values from a console
	display_message_default_simple "$1" | sed 's/\//\\\//g'
}

string_replace_pattern_from_old_to_new_simple(){
    local STRING="$1"
    local PATTERN_OLD="$2"
    local PATTERN_NEW="$3"

    display_message_default_simple "${STRING/$PATTERN_OLD/$PATTERN_NEW}"
}

string_replace_pattern_from_old_to_new_complex(){
    local STRING="$1"
    local PATTERN_OLD="$2"
    local PATTERN_NEW="$3"

    display_message_default_simple "${STRING//$PATTERN_OLD/$PATTERN_NEW}"
}

string_replace_number(){
	local PATH_FILE="$1"
	local TEXT_OLD_LINE_NUMBER="$2"
	local TEXT_NEW="$3"

	#Replace all the text from the line number
    sed -i "$TEXT_OLD_LINE_NUMBER c\\$TEXT_NEW" $PATH_FILE
}

string_replace_output(){
	local TEXT_OLD="$1"
	local TEXT_NEW="$2"

	#Replace all the match values from a sonsole
	sed -s "s/$TEXT_OLD/$TEXT_NEW/g"
}

string_replace_slash_from_backward_to_forward(){
    local STRING="$1"
    local PATTERN_OLD="$2"
    local PATTERN_NEW="$3"
    
    display_message_default_simple "${STRING//\\//}"
}

#string_replace_slash_from_forward_to_backward(){}

string_replace_text(){
	local PATH_FILE="$1"
	local TEXT_OLD="$2"
	local TEXT_NEW="$3"

	#Replace all the match values in a text file
	sed -i "s/$TEXT_OLD/$TEXT_NEW/g" $PATH_FILE
}

#label_must_be_tested
#label_must_be_improved
string_split_number_digits_integer(){
	local VALUE_NUMBER=$1
    
	#printf "$1" | cut -d. -f1
	#echo "$1" | cut -d. -f1
	display_message_default_simple "$1" | cut -d. -f1
}

#label_must_be_tested
#label_must_be_improved
string_split_number_digits_decimal(){
	local VALUE_NUMBER=$1

	if [[ $VALUE_NUMBER == *"."* ]]; then
		#There is decimal digits and number is positive
		display_message_default_simple "$VALUE_NUMBER" | cut -d. -f2
	elif [[ $VALUE_NUMBER == *"."* ]] && [[ $VALUE_NUMBER == *"-"* ]]; then
		#There is decimal digits and number is negative
		display_message_default_simple "$VALUE_NUMBER" | cut -d. -f3
	else
		#There is not decimal digits
		display_message_default_simple ""
	fi
}

#label_must_be_tested
string_write_exclusive_line_on_a_file(){
	case $(string_check_if_string_pattern_matches "$1" "$2") in
		"false")
			display_message_default_simple "$1" >> "$2"
			display_message_success_complex "String has been appended on the last line of the file"
			break
			;;
		"true" | "fail")
			display_message_error_complex "String already exists on file"
			break
			;;
	esac
}