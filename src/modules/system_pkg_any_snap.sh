#############################
#System package manager - SNAP
#############################

#@annotation_must_be_created
system_pkg_any_snap_repository_add() {
	display_message_value_status_warning_complex "Adding Snap $* repository"

	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Snap $* repository has been added"
}

#@annotation_must_be_created
system_pkg_any_snap_repository_remove() {
	display_message_value_status_warning_complex "Removing Snap $* repository"

	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Snap $* repository has been added"
}

system_pkg_any_snap_repository_syncronize() {
	display_message_value_status_warning_complex "Syncronizing Snap $* repository"

	utils_exit_if_user_does_not_have_root_previledges

	case $DEBUG in
	"false") snap update ;;
	"true") snap update -y ;;
	esac

	display_message_value_status_success_complex "Snap $* repository has been syncronized"
}

system_pkg_any_snap_software_install() {
	display_message_value_status_warning_complex "Installing Snap $* software"

	utils_exit_if_user_does_not_have_root_previledges

	case $DEBUG in
	"false") snap install "$@" ;;
	"true") snap install -y "$@" ;;
	esac

	display_message_value_status_success_complex "Snap $* software(s) has/have been installed"
}

system_pkg_any_snap_software_list() {
	display_message_value_status_warning_complex "Listing Snap softwares"

	snap list
}

system_pkg_any_snap_software_uninstall() {
	display_message_value_status_warning_complex "Uninstalling Snap $* software"

	utils_exit_if_user_does_not_have_root_previledges

	case $DEBUG in
	"false") snap remove "$@" ;;
	"true") snap remove -y "$@" ;;
	esac

	display_message_value_status_success_complex "Snap $* software(s) has/have been uninstalled"
}
