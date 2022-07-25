#############################
#Display progress
#############################

display_progress_bar_percentage_simple(){
	local VALUE_CURRENT="$1"
	local VALUE_FINISH="$2"
	local VALUE_PERCENTAGE

	VALUE_PERCENTAGE=$(math_percentage "$VALUE_CURRENT" "$VALUE_FINISH")

	display_message_content_line_replace "${VALUE_CURRENT}/${VALUE_FINISH} = $VALUE_PERCENTAGE %"
}

display_progress_bar_percentage_complex(){
	local VALUE_CURRENT="$1"
	local VALUE_FINISH="$2"
	local VALUE_PERCENTAGE

	VALUE_PERCENTAGE=$(math_percentage "$VALUE_CURRENT" "$VALUE_FINISH")

	display_message_value_status_success_complex "${VALUE_CURRENT}/${VALUE_FINISH} = $VALUE_PERCENTAGE %"
}