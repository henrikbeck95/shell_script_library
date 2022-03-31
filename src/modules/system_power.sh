#############################
#System power
#############################

system_power_hibernate(){
    system_power_lock
    systemctl hibernate
}

system_power_lock(){
    xdg-screensaver lock
    #lock # i3lock
    #i3lock -n --color '#0a81f5'
}

system_power_logout(){
    loginctl terminate-user $username || i3-msg exit

    #loginctl terminate-session <id>
    #gnome-session-quit
}

system_power_reboot(){
    systemctl reboot || reboot
}

system_power_shutdown_cancel(){
    echo "Operating system shutdown has been canceled!" ""
    shutdown -c
}

system_power_shutdown_now(){
    poweroff || shutdown || systemctl poweroff
}

system_power_shutdown_time(){
    while true; do
        read -p "Informe how many minutes you want to wait for shutting down the operating system: " QUESTION_TIME #5

        case $QUESTION_TIME in
            "") display_message_default "Please, answer the question for proceduring." ;;
            *) break ;;
        esac
    done

    echo "Operating system is up $QUESTION_TIME to be shutted down!"

    shutdown -h +$QUESTION_TIME
}

system_power_suspend(){
    system_power_lock
    systemctl suspend
    #loginctl suspend
}

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