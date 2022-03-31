#############################
#System daemon
#############################

#label_must_be_created
system_daemon_check_init_system(){
    display_message_default "Testing..."
}

system_daemon_disable_later(){
	tools_check_if_user_has_root_previledges

	display_message_default "Disable $@ process on start up from OpenRC (after rebooting)"

    case $(system_daemon_check_init_system) in
		"openrc") rc-update del $@ default ;;
		"systemd") systemctl disable $@ ;;
		*) 
	esac
}

system_daemon_disable_now(){
	tools_check_if_user_has_root_previledges

	display_message_default "Disable $@ process on start up from OpenRC (right now)"

    case $(system_daemon_check_init_system) in
		"openrc") rc-service $@ stop && rc-update del $@ ;;
		"systemd")systemctl disable --now $@ ;;
		*) 
	esac
}

system_daemon_enable_later(){
	tools_check_if_user_has_root_previledges

	display_message_default "Enable $@ process on start up from OpenRC (after rebooting)"

    case $(system_daemon_check_init_system) in
		"openrc") rc-update add $@ default ;;
		"systemd")systemctl enable $@ ;;
		*) 
	esac
}

system_daemon_enable_now(){
	tools_check_if_user_has_root_previledges

	display_message_default "Enable $@ process on start up from OpenRC (right now)"

    case $(system_daemon_check_init_system) in
		"openrc") rc-service $@ start && rc-update add $@ ;;
		"systemd") systemctl enable --now $@ ;;
		*) 
	esac
}

system_daemon_restart(){
	tools_check_if_user_has_root_previledges

	display_message_default "Restart $@ process from OpenRC"

    case $(system_daemon_check_init_system) in
		"openrc") rc-service $@ restart ;;
		"systemd") systemctl restart $@ ;;
		*) 
	esac
}

system_daemon_start(){
	tools_check_if_user_has_root_previledges

	display_message_default "Start $@ process now from OpenRC"

    case $(system_daemon_check_init_system) in
		"openrc") rc-service $@ start ;;
		"systemd") systemctl start $@ ;;
		*) 
	esac
}

system_daemon_status(){
	#tools_check_if_user_has_root_previledges

	display_message_default "Get $@ process status from OpenRC"

    case $(system_daemon_check_init_system) in
		#"openrc") rc-status ;;
		#"openrc") rc-status --list ;;
		"openrc") rc-service $@ status ;;
		"systemd") systemctl status $@ ;;
		*) 
	esac
}

system_daemon_stop(){
	tools_check_if_user_has_root_previledges

	display_message_default "Stop $@ process now from OpenRC"

    case $(system_daemon_check_init_system) in
		"openrc") rc-service $@ stop ;;
		"systemd")systemctl stop $@ ;;
		*) 
	esac
}