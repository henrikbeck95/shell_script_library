#############################
#Math converter time
#############################

math_converter_time_from_microseconds_to_seconds(){
    local VALUE_MICROSECONDS="$1"
    local RESULT

    RESULT=$(math_calculator "$VALUE_MICROSECONDS / 1000000")

    display_message_value_number_simple "$RESULT"
}

math_converter_time_from_string_to_amount_of_seconds(){
    #math_converter_time_from_string_to_amount_of_seconds "hh:mm:ss"
    #math_converter_time_from_string_to_amount_of_seconds "hh:mm:ss.xyz"
    #math_converter_time_from_string_to_amount_of_seconds "01:03:41"

    local TIME_STRING_FULL_COLLON="$1"
    local TIME_STRING_FULL_SPACE
    local TIME_VALUE_HOURS
    local TIME_VALUE_MINUTES
    local TIME_VALUE_SECONDS
    local RESULT

    TIME_STRING_FULL_SPACE=$(string_replace_character_from_colon_to_space "$TIME_STRING_FULL_COLLON")

    TIME_VALUE_HOURS=$(echo "$TIME_STRING_FULL_SPACE" | awk '{print $1}')
    TIME_VALUE_MINUTES=$(echo "$TIME_STRING_FULL_SPACE" | awk '{print $2}')
    TIME_VALUE_SECONDS=$(echo "$TIME_STRING_FULL_SPACE" | awk '{print $3}')
    #TIME_VALUE_MILLISECONDS=$(echo "$TIME_STRING_FULL_SPACE" | awk '{print $4}')

    RESULT=$(math_calculator "($TIME_VALUE_HOURS * 3600) + ($TIME_VALUE_MINUTES * 60) + $TIME_VALUE_SECONDS")

    display_message_value_number_simple "$RESULT"
}

math_converter_time_from_string_to_amount_of_minutes(){
    #math_converter_time_from_string_to_amount_of_minutes "hh:mm:ss"
    #math_converter_time_from_string_to_amount_of_minutes "hh:mm:ss.xyz"
    #math_converter_time_from_string_to_amount_of_minutes "01:03:41"

    local TIME_STRING_FULL_COLLON="$1"
    local TIME_VALUE_SECONDS
    local RESULT
    
    TIME_VALUE_SECONDS=$(math_converter_time_from_string_to_amount_of_seconds "$TIME_STRING_FULL_COLLON")

    RESULT=$((TIME_VALUE_SECONDS / 60))

    display_message_value_number_simple "$RESULT"
}

math_converter_time_from_string_to_amount_of_hours(){
    #math_converter_time_from_string_to_amount_of_hours "hh:mm:ss"
    #math_converter_time_from_string_to_amount_of_hours "hh:mm:ss.xyz"
    #math_converter_time_from_string_to_amount_of_hours "01:03:41"

    local TIME_STRING_FULL_COLLON="$1"
    local TIME_VALUE_MINUTES
    local RESULT
    
    TIME_VALUE_SECONDS=$(math_converter_time_from_string_to_amount_of_minutes "$TIME_STRING_FULL_COLLON")
    
    RESULT=$((TIME_VALUE_SECONDS / 60))

    display_message_value_number_simple "$RESULT"
}