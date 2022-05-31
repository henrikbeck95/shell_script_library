#############################
#System daemon
#############################

#@annotation_must_be_created
#Insert OpenRC
system_daemon_check_init_system() {
	#case $(cat /procat /proc/1/comm) in
	case $(cat /proc/1/comm) in
	"init") display_message_value_text_default_simple "init" ;;
	"openrc") display_message_value_text_default_simple "openrc" ;;
	"systemd") display_message_value_text_default_simple "systemd" ;;
	*) display_message_value_status_error_simple "unknown" ;;
	esac
}

system_daemon_disable_later() {
	utils_check_if_user_has_root_previledges

	display_message_value_text_default_complex "Disabling $* process on start up (after rebooting)"

	case $(system_daemon_check_init_system) in
	"openrc") rc-update del "$@" default ;;
	"systemd") systemctl disable "$@" ;;
	*) display_message_value_status_empty_simple ;;
	esac
}

system_daemon_disable_now() {
	utils_check_if_user_has_root_previledges

	display_message_value_text_default_complex "Disabling $* process on start up (right now)"

	case $(system_daemon_check_init_system) in
	"openrc") rc-service "$@" stop && rc-update del "$@" ;;
	"systemd") systemctl disable --now "$@" ;;
	*) display_message_value_status_empty_simple ;;
	esac
}

system_daemon_enable_later() {
	utils_check_if_user_has_root_previledges

	display_message_value_text_default_complex "Enabling $* process on start up (after rebooting)"

	case $(system_daemon_check_init_system) in
	"openrc") rc-update add "$@" default ;;
	"systemd") systemctl enable "$@" ;;
	*) display_message_value_status_empty_simple ;;
	esac
}

system_daemon_enable_now() {
	utils_check_if_user_has_root_previledges

	display_message_value_text_default_complex "Enabling $* process on start up (right now)"

	case $(system_daemon_check_init_system) in
	"openrc") rc-service "$@" start && rc-update add "$@" ;;
	"systemd") systemctl enable --now "$@" ;;
	*) display_message_value_status_empty_simple ;;
	esac
}

system_daemon_reload() {
	utils_check_if_user_has_root_previledges

	display_message_value_text_default_complex "Restart system init process"

	case $(system_daemon_check_init_system) in
	"openrc") display_message_value_status_empty_simple ;;
	"systemd") systemctl daemon-reload ;;
	*) display_message_value_status_error_simple "Unsupported system init" ;;
	esac
}

system_daemon_restart() {
	utils_check_if_user_has_root_previledges

	display_message_value_text_default_complex "Restarting $* process"

	case $(system_daemon_check_init_system) in
	"openrc") rc-service "$@" restart ;;
	"systemd") systemctl restart "$@" ;;
	*) display_message_value_status_empty_simple ;;
	esac
}

system_daemon_start() {
	utils_check_if_user_has_root_previledges

	display_message_value_text_default_complex "Starting $* process now"

	case $(system_daemon_check_init_system) in
	"openrc") rc-service "$@" start ;;
	"systemd") systemctl start "$@" ;;
	*) display_message_value_status_empty_simple ;;
	esac
}

system_daemon_status() {
	#utils_check_if_user_has_root_previledges

	display_message_value_text_default_complex "Getting $* process status"

	case $(system_daemon_check_init_system) in
	#"openrc") rc-status ;;
	#"openrc") rc-status --list ;;
	"openrc") rc-service "$@" status ;;
	"systemd") systemctl status "$@" ;;
	*) display_message_value_status_empty_simple ;;
	esac
}

system_daemon_stop() {
	utils_check_if_user_has_root_previledges

	display_message_value_text_default_complex "Stopping $* process now"

	case $(system_daemon_check_init_system) in
	"openrc") rc-service "$@" stop ;;
	"systemd") systemctl stop "$@" ;;
	*) display_message_value_status_empty_simple ;;
	esac
}
