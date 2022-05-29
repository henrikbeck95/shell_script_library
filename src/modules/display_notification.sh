#############################
#Display notification
#############################

display_notification_low(){
    local VALUE_MESSAGE="$1"
    local VALUE_ICONS="$2"

    if [[ $VALUE_ICONS != "" ]]; then
        notify-send --expire-time 1500 --urgency=low --icon="${VALUE_ICONS}" "$VALUE_MESSAGE"
    else
        notify-send --expire-time 1500 --urgency=low "$VALUE_MESSAGE"
    fi
}

display_notification_normal(){
    local VALUE_MESSAGE="$1"
    local VALUE_ICONS="$2"

    if [[ $VALUE_ICONS != "" ]]; then
        notify-send --expire-time 1500 --urgency=normal --icon="${VALUE_ICONS}" "$VALUE_MESSAGE"
    else
        notify-send --expire-time 1500 --urgency=normal "$VALUE_MESSAGE"
    fi
}

display_notification_warning(){
    local VALUE_MESSAGE="$1"
    local VALUE_ICONS="$2"

    if [[ $VALUE_ICONS != "" ]]; then
        notify-send --expire-time 1500 --urgency=critical --icon="${VALUE_ICONS}" "$VALUE_MESSAGE"
    else
        notify-send --expire-time 1500 --urgency=critical "$VALUE_MESSAGE"
    fi
}