#############################
#Array
#############################

#@annotation_must_be_updated
array_display_element_all_horizontal() {
    #array_display_element_all_horizontal "${ARRAY[@]}"
    local ARRAY=("$@")

    echo -e "${ARRAY[@]}"
    #display_message_value_text_default_complex "${ARRAY[@]}"
}

#@annotation_must_be_updated
array_display_element_all_vertical() {
    #array_display_element_all_vertical "${ARRAY[@]}"
    local ARRAY=("$@")

    for i in "${ARRAY[@]}"; do
        echo "$i"
        #display_message_value_text_default_complex $i
    done
}

#@annotation_must_be_updated
array_edit_element_remove_index_first() {
    #array_get_element_index_first "${ARRAY[@]}"
    local ARRAY_ELEMENT_ALL=("$@")

    unset "ARRAY_ELEMENT_ALL[0]"

    display_message_value_text_default_complex "${ARRAY_ELEMENT_ALL[@]}"
}

#@annotation_must_be_updated
array_edit_element_remove_index_last() {
    #array_get_element_index_last "${ARRAY[@]}"
    #result=($(array_get_element_index_last "${ARRAY[@]}"))
    local ARRAY_ELEMENT_ALL=("$@")

    unset "ARRAY_ELEMENT_ALL[-1]"

    display_message_value_text_default_complex "${ARRAY_ELEMENT_ALL[@]}"
}

#@annotation_must_be_updated
array_edit_element_sort_normal() {
    printf '%s\n' "${ARRAY_OPERATING_SYSTEM_FILE[@]}" | sort
    #display_message_value_text_default_complex "${ARRAY_OPERATING_SYSTEM_FILE[@]}" | sort
}

#@annotation_must_be_updated
array_edit_element_sort_inverted() {
    printf '%s\n' "${ARRAY_OPERATING_SYSTEM_FILE[@]}" | sort --reverse
    #display_message_value_text_default_complex "${ARRAY_OPERATING_SYSTEM_FILE[@]}" | sort --reverse
}

#@annotation_must_be_updated
array_get_element_index_first() {
    #array_edit_element_remove_index_first "${ARRAY[@]}"
    local ARRAY_ELEMENT_ALL=("$@")
    local ARRAY_ELEMENT_FIRST="${ARRAY_ELEMENT_ALL[0]}"

    display_message_value_text_default_simple "$ARRAY_ELEMENT_FIRST"
}

#@annotation_must_be_updated
array_get_element_index_last() {
    #array_edit_element_remove_index_last "${ARRAY[@]}"
    local ARRAY_ELEMENT_ALL=("$@")
    local ARRAY_LENGTH_NORMAL=${#ARRAY_ELEMENT_ALL[@]}
    local ARRAY_LENGTH_AUX=$((ARRAY_LENGTH_NORMAL - 1))
    local ARRAY_ELEMENT_LAST="${ARRAY_ELEMENT_ALL[$ARRAY_LENGTH_AUX]}"

    display_message_value_text_default_simple "$ARRAY_ELEMENT_LAST"
}

#arraylength=${#array[@]}
#array_get_size_total(){}

#array_get_size_less_one(){}

#@annotation_must_be_updated
array_find_element_index_from_value() {
    #array_find_element_index_from_value "${ARRAY[@]}" "apt"
    local ARRAY_ELEMENT_ALL=("$@")

    local ARRAY_ELEMENT_AUX
    ARRAY_ELEMENT_AUX=($(array_edit_element_remove_index_last "${ARRAY_ELEMENT_ALL[@]}"))

    local ARRAY_LENGTH_NORMAL=${#ARRAY_ELEMENT_ALL[@]}
    local ARRAY_LENGTH_AUX=$((ARRAY_LENGTH_NORMAL - 1))
    local ARRAY_ELEMENT_LAST="${ARRAY_ELEMENT_ALL[$ARRAY_LENGTH_AUX]}"
    local ARRAY_ELEMENT_INDEX=-1

    for i in "${!ARRAY_ELEMENT_AUX[@]}"; do
        if [[ "${ARRAY_ELEMENT_AUX[$i]}" = "$ARRAY_ELEMENT_LAST" ]]; then
            ARRAY_ELEMENT_INDEX=$i
            break
        fi
    done

    if [ "$ARRAY_ELEMENT_INDEX" -gt -1 ]; then
        display_message_value_text_default_simple "$ARRAY_ELEMENT_INDEX"
    else
        display_message_value_text_default_simple "Element $ARRAY_ELEMENT_LAST is not in Array."
    fi
}

#@annotation_must_be_updated
array_check_if_element_exists() {
    #array_check_if_element_exists "${ARRAY[@]}" "yummy"
    local ARRAY_ELEMENT_ALL=("$@")
    local RESULT

    RESULT=$(array_find_element_index_from_value "${ARRAY_ELEMENT_ALL[@]}")

    case $(utils_check_if_variable_is_number "$RESULT") in
    "false") display_message_value_text_default_simple "false" ;;
    "true") display_message_value_text_default_simple "true" ;;
    esac
}

array_check_if_is_empty(){
    local ARRAY_LIST=("$@")

    #if [[ -n "$ARRAY_LIST" ]]; then
    if [[ "${#ARRAY_LIST[@]}" -eq 0 ]]; then
        display_message_value_text_default_simple "true"
    else
        display_message_value_text_default_simple "false"
    fi
}