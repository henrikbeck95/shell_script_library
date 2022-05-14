#############################
#System power
#############################

#label_must_be_improved
system_power_hibernate(){
    system_power_lock
    systemctl hibernate
}
#label_must_be_improved
system_power_lock(){
    xdg-screensaver lock
    #lock # i3lock
    #i3lock -n --color '#0a81f5'
}

#label_must_be_improved
system_power_logout(){
    loginctl terminate-user $username || i3-msg exit

    #loginctl terminate-session <id>
    #gnome-session-quit
}

#label_must_be_improved
system_power_reboot(){
	reboot || systemctl reboot
}

#label_must_be_improved
system_power_shutdown_cancel(){
    display_message_warning_complex "Operating system shutdown has been canceled!"

    shutdown -c
}

#label_must_be_improved
system_power_shutdown_now(){
    poweroff || shutdown || systemctl poweroff
}

system_power_shutdown_time(){
	local QUESTION_TIME

    while true; do
        read -p "Informe how many minutes you want to wait for shutting down the operating system: " QUESTION_TIME #Try: 5

        case $QUESTION_TIME in
            "") display_message_default_complex "Please, answer the question for proceduring." ;;
            *) break ;;
        esac
    done

    display_message_warning_complex "Operating system is up $QUESTION_TIME to be shutted down!"

    shutdown -h +$QUESTION_TIME
}

##label_must_be_improved
system_power_suspend(){
    system_power_lock
    systemctl suspend
    #loginctl suspend
}

#label_must_be_improved
system_power_reload_desktop_environment(){
    i3 restart
}

system_sessions_list(){
    loginctl list-sessions
}

system_sessions_kill(){
    local VALUE_SESSION_ID=$1
    
    loginctl terminate-session $VALUE_SESSION_ID
}