#############################
#System battery
#############################

system_battery_check_if_charger_is_connected() {
    local VALUE_BATTERY_STATUS

    VALUE_BATTERY_STATUS=$(system_battery_level_status)

    if [[ "$VALUE_BATTERY_STATUS" == "Charging" ]]; then
        display_message_value_text_default_simple "true"
    else
        display_message_value_text_default_simple "false"
    fi
}

system_battery_check_if_level_is_full() {
    local VALUE_BATTERY_STATUS
    local VALUE_BATTERY_LEVEL

    VALUE_BATTERY_STATUS=$(system_battery_level_status)
    VALUE_BATTERY_LEVEL=$(system_battery_level_current)

    if [[ "$VALUE_BATTERY_STATUS" == "true" && $VALUE_BATTERY_LEVEL -eq 100 ]]; then
        display_message_value_text_default_simple "true"
    else
        display_message_value_text_default_simple "false"
    fi
}

system_battery_check_if_level_is_low() {
    local VALUE_BATTERY_LOW=15
    local VALUE_BATTERY_STATUS
    local VALUE_BATTERY_LEVEL

    VALUE_BATTERY_STATUS=$(system_battery_level_status)
    VALUE_BATTERY_LEVEL=$(system_battery_level_current)

    if [[ "$VALUE_BATTERY_STATUS" == "false" && $VALUE_BATTERY_LEVEL -lt $VALUE_BATTERY_LOW ]]; then
        display_message_value_text_default_simple "true"
    else
        display_message_value_text_default_simple "false"
    fi
}

system_battery_level_current() {
    local PATH_SYSTEM_FILE_BATTERY_LEVEL_CURRENT

    PATH_SYSTEM_FILE_BATTERY_LEVEL_CURRENT=$(cat /sys/class/power_supply/BAT1/capacity)

    display_message_value_text_default_simple "$PATH_SYSTEM_FILE_BATTERY_LEVEL_CURRENT"
}

#@annotation_must_be_updated
system_battery_level_percentage() {
    local SYSTEM_BATTERY_LEVEL_PERCENTAGE

    SYSTEM_BATTERY_LEVEL_PERCENTAGE=$(acpi -b | grep -E -o '[0-9][0-9]?%')

    display_message_value_text_default_simple "$SYSTEM_BATTERY_LEVEL_PERCENTAGE"
}

#@annotation_must_be_updated
system_battery_level_status() {
    local SYSTEM_BATTERY_LEVEL_STATUS

    SYSTEM_BATTERY_LEVEL_STATUS=$(cat /sys/class/power_supply/BAT1/status)

    display_message_value_text_default_simple "$SYSTEM_BATTERY_LEVEL_STATUS"
}

#@annotation_must_be_updated
system_battery_time_remaining() {
    local SYSTEM_BATTERY_TIME_REMAINING

    SYSTEM_BATTERY_TIME_REMAINING=$(acpi -b | grep -E -o '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]?')

    display_message_value_text_default_simple "$SYSTEM_BATTERY_TIME_REMAINING"
}

#@annotation_must_be_updated
system_battery_warning() {
    local VALUE_BATTERY_REMAINING
    local VALUE_BATTERY_LEVEL

    VALUE_BATTERY_REMAINING=$(system_battery_time_remaining)
    VALUE_BATTERY_LEVEL=$(system_battery_level_current)

    if [[ $(system_battery_check_if_level_is_full) == "true" ]]; then
        display_message_value_status_warning_simple "Full charged ${VALUE_BATTERY_LEVEL}%. Remove the charger now!"
    elif [[ $(system_battery_check_if_level_is_low) == "true" ]]; then
        display_message_value_status_warning_simple "Low battery ${VALUE_BATTERY_LEVEL}%. Remaining: $VALUE_BATTERY_REMAINING. Connect the charger now"
    fi
}
