#############################
#Display notification
#############################

display_notification_send() {
    #local ARGUMENTS="$*"
    #local ARGUMENTS="$@"

    case $(utils_check_if_user_has_root_previledges) in
    "false")
        notify-send "$@"
        #notify-send "$ARGUMENTS"
        ;;
    "true")
        #Detect the name of the display in use
        local AUX_DISPLAY=":$(ls /tmp/.X11-unix/* | sed 's#/tmp/.X11-unix/X##' | head -n 1)"

        #Detect the user using such display
        local AUX_USER=$(who | grep '('$AUX_DISPLAY')' | awk '{print $1}' | head -n 1)

        #Detect the id of the user
        local AUX_UID=$(id -u $AUX_USER)

        #Execute the command
        sudo -u $AUX_USER DISPLAY=$AUX_DISPLAY DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$AUX_UID/bus notify-send "$@"
        #sudo -u $AUX_USER DISPLAY=$AUX_DISPLAY DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$AUX_UID/bus notify-send "$ARGUMENTS"
        ;;
    esac
}

#@annotation_must_be_improved
display_notification_low() {
    local VALUE_MESSAGE="$1"
    local VALUE_ICONS="$2"

    if [[ $VALUE_ICONS != "" ]]; then
        display_notification_send --expire-time 1500 --urgency=low --icon="${VALUE_ICONS}" "$VALUE_MESSAGE"
    else
        display_notification_send --expire-time 1500 --urgency=low "$VALUE_MESSAGE"
    fi
}

#@annotation_must_be_improved
display_notification_normal() {
    local VALUE_MESSAGE="$1"
    local VALUE_ICONS="$2"

    if [[ $VALUE_ICONS != "" ]]; then
        display_notification_send --expire-time 1500 --urgency=normal --icon="${VALUE_ICONS}" "$VALUE_MESSAGE"
    else
        display_notification_send --expire-time 1500 --urgency=normal "$VALUE_MESSAGE"
    fi
}

#@annotation_must_be_improved
display_notification_warning() {
    local VALUE_MESSAGE="$1"
    local VALUE_ICONS="$2"

    if [[ $VALUE_ICONS != "" ]]; then
        display_notification_send --expire-time 1500 --urgency=critical --icon="${VALUE_ICONS}" "$VALUE_MESSAGE"
    else
        display_notification_send --expire-time 1500 --urgency=critical "$VALUE_MESSAGE"
    fi
}
