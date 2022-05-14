#############################
#System battery
#############################

system_battery_check_if_charger_is_connected(){
    local VALUE_BATTERY_STATUS=$(system_battery_level_status)

    if [[ "$VALUE_BATTERY_STATUS" == "Charging" ]] ; then
        display_message_default_simple "true"
    else
        display_message_default_simple "false"
    fi
}

system_battery_check_if_level_is_full(){
    local VALUE_BATTERY_STATUS=$(system_battery_level_status)
    local VALUE_BATTERY_LEVEL=$(system_battery_level_current)

    if [[ "$VALUE_BATTERY_STATUS" == "true" && $VALUE_BATTERY_LEVEL -eq 100 ]] ; then
        display_message_default_simple "true"
    else
        display_message_default_simple "false"
    fi
}

system_battery_check_if_level_is_low(){
    local VALUE_BATTERY_STATUS=$(system_battery_level_status)
    local VALUE_BATTERY_LEVEL=$(system_battery_level_current)
    local VALUE_BATTERY_LOW=15

    if [[ "$VALUE_BATTERY_STATUS" == "false" && $VALUE_BATTERY_LEVEL -lt $VALUE_BATTERY_LOW ]] ; then
        display_message_default_simple "true"
    else
        display_message_default_simple "false"
    fi
}

system_battery_level_current(){
    display_message_default_simple $(cat /sys/class/power_supply/BAT1/capacity)
}

system_battery_level_percentage(){
    display_message_default_simple $(acpi -b | grep -E -o '[0-9][0-9]?%')
}

system_battery_level_status(){
    display_message_default_simple $(cat /sys/class/power_supply/BAT1/status)
}

system_battery_time_remaining(){
    display_message_default_simple $(acpi -b | grep -E -o '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]?')
}

system_battery_warning(){
	local VALUE_BATTERY_REMAINING=$(system_battery_time_remaining)
	local VALUE_BATTERY_LEVEL=$(system_battery_level_current)

    if [[ $(system_battery_check_if_level_is_full) == "true" ]]; then
        display_message_warning_simple "Full charged ${VALUE_BATTERY_LEVEL}%. Remove the charger now!"
    elif [[ $(system_battery_check_if_level_is_low) == "true" ]]; then
        display_message_warning_simple "Low battery ${VALUE_BATTERY_LEVEL}%. Remaining: $VALUE_BATTERY_REMAINING. Connect the charger now"
    fi
}