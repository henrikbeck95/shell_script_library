##############################
#Syntactic analyzer
##############################

syntactic_analyzer_set_variable_name() {
    local VALUE="$1"
    local VARIABLE_NAME

    VARIABLE_NAME=$(string_get_content_signal_before '=' "$VALUE")

    display_message_value_text_default_simple "${VARIABLE_NAME}"
}

syntactic_analyzer_set_variable_value_boolean() {
    local VALUE="$1"
    local VARIABLE_VALUE

    VARIABLE_VALUE=$(string_get_content_signal_after_number '=' "$VALUE")

    case $(utils_check_if_variable_is_boolean "$VARIABLE_VALUE") in
    "false") syntactic_analyzer_status_error "boolean" ;;
    "true") display_message_value_text_default_simple "$VARIABLE_VALUE" ;;
    esac
}

syntactic_analyzer_set_variable_value_char() {
    local VALUE="$1"
    local VARIABLE_VALUE

    VARIABLE_VALUE=$(string_get_content_signal_after_number '=' "$VALUE")

    case $(utils_check_if_variable_is_char "$VARIABLE_VALUE") in
    "false") syntactic_analyzer_status_error "char" ;;
    "true") display_message_value_text_default_simple "$VARIABLE_VALUE" ;;
    esac
}

syntactic_analyzer_set_variable_value_float() {
    local VALUE="$1"
    local VARIABLE_VALUE

    VARIABLE_VALUE=$(string_get_content_signal_after_number '=' "$VALUE")

    case $(utils_check_if_variable_is_number "$VARIABLE_VALUE") in
    "false") syntactic_analyzer_status_error "float" ;;
    "true") display_message_value_number_simple "$VARIABLE_VALUE" ;;
    esac
}

syntactic_analyzer_set_variable_value_int() {
    local VALUE="$1"
    local VARIABLE_VALUE

    VARIABLE_VALUE=$(string_get_content_signal_after_number '=' "$VALUE")

    case $(utils_check_if_variable_is_integer "$VARIABLE_VALUE") in
    "false") syntactic_analyzer_status_error "int" ;;
    "true") display_message_value_number_simple "$VARIABLE_VALUE" ;;
    esac
}

syntactic_analyzer_set_variable_value_object() {
    local VALUE="$1"
    local VARIABLE_VALUE

    VARIABLE_VALUE=$(string_get_content_signal_after_number '=' "$VALUE")

    case $(utils_check_if_variable_exists "$VARIABLE_VALUE") in
    "false") syntactic_analyzer_status_error "object" ;;
    "true") display_message_value_text_default_simple "$VARIABLE_VALUE" ;;
    esac
}

syntactic_analyzer_set_variable_value_string() {
    local VALUE="$1"
    local VARIABLE_VALUE

    VARIABLE_VALUE=$(string_get_content_signal_after_number '=' "$VALUE")

    case $(utils_check_if_variable_is_string "$VARIABLE_VALUE") in
    "false") syntactic_analyzer_status_error "string" ;;
    "true") display_message_value_text_default_simple "$VARIABLE_VALUE" ;;
    esac
}

syntactic_analyzer_status_error() {
    local VALUE="$1"

    set -e
    echo "'${VALUE}' contains invalid values for this primitive type."
    #false
    set +e
}
