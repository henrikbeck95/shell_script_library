#############################
#String
#############################

string_check_if_string_pattern_matches(){
    local CONTENT_STRING=$1
    local FILE_PATH=$2

	#Check if strings matches only if the file exists
	if [[ -f "$FILE_PATH" ]]; then
		if grep -q "$CONTENT_STRING" "$FILE_PATH"; then
			display_message_simple "true"
		else
			display_message_simple "false"
		fi
	else
		display_message_simple "fail"
	fi
}

string_convert_from_lower_to_upper(){
	display_message_simple ${@^^}
}

string_convert_from_upper_to_lower(){
	display_message_simple ${@,,}
}

string_count_character(){
	display_message_simple "${#1}"
}

string_repeat_character(){
    local VALUE_SIZE=$1
    local VALUE_CHARACTER=$2

	for ((i=0; i < $VALUE_SIZE; i++)); do
		display_message_simple "$VALUE_CHARACTER"
	done
}

string_replace_backslash_to_forward_slash(){
	echo "$1" | sed 's/\\/\//g'
}

string_replace_forward_slash_to_backslash_cancelled(){
	local TEXT_OLD="\/"
	local TEXT_NEW="\\\/"

	#Replace all the match values from a console
	echo "$1" | sed 's/\//\\\//g'
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

string_replace_text(){
	local PATH_FILE="$1"
	local TEXT_OLD="$2"
	local TEXT_NEW="$3"

	#Replace all the match values in a text file
	sed -i "s/$TEXT_OLD/$TEXT_NEW/g" $PATH_FILE
}

string_split_number_digits_integer(){
	local VALUE_NUMBER=$1
    
	#printf "$1" | cut -d. -f1
	echo "$1" | cut -d. -f1
}

string_split_number_digits_decimal(){
	local VALUE_NUMBER=$1

	if [[ $VALUE_NUMBER == *"."* ]]; then
		#There is decimal digits and number is positive
		#printf "$VALUE_NUMBER" | cut -d. -f2
		echo "$VALUE_NUMBER" | cut -d. -f2
	#if [[ $VALUE_NUMBER == *"."* ]] && [[ $VALUE_NUMBER != *"-"* ]]; then
	#	#There is decimal digits and number is positive
	#	printf "$VALUE_NUMBER" | cut -d. -f2
	elif [[ $VALUE_NUMBER == *"."* ]] && [[ $VALUE_NUMBER == *"-"* ]]; then
		#There is decimal digits and number is negative
		#printf "$VALUE_NUMBER" | cut -d. -f3
		echo "$VALUE_NUMBER" | cut -d. -f3
	else
		#There is not decimal digits
		printf ""
	fi
}

string_write_exclusive_line_on_a_file(){
	case $(string_check_if_string_pattern_matches "$1" "$2") in
		"true" | "fail") display_message_error "String already exists on file" ;;
		"false")
			echo "$1" >> "$2"
			display_message_success "String has been appended on the last line of the file"
			;;
	esac
}