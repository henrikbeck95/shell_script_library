#############################
#System package manager - Flatpak
#############################

system_pkg_any_flatpak_repository_add() {
	#system_pkg_any_flatpak_repository_add "--system" "flathub" "???"

	display_message_value_status_success_complex "Adding Flatpak $* repository"

	local FLATPAK_AREA_WIDE="$1" #For system wide try: --system || For per-user try: --user
	local FLATPAK_REPOSITORY_NAME="$2"
	local FLATPAK_REPOSITORY_LINK="$3"

	#flatpak remote-add --if-not-exists "$@"
	#flatpak remote-add --user --if-not-exists "$@"
	#flatpak remote-add --system --if-not-exists "$@"
	flatpak remote-add "$FLATPAK_AREA_WIDE" --if-not-exists "$FLATPAK_REPOSITORY_NAME" "$FLATPAK_REPOSITORY_LINK"

	display_message_value_status_success_complex "Flatpak $* repository has been added"
}

system_pkg_any_flatpak_repository_list() {
	display_message_value_status_success_complex "Listing Flatpak $* repositories"

	flatpak remote-list
}

#@annotation_must_be_improved
system_pkg_any_flatpak_repository_remove() {
	display_message_value_status_success_complex "Removing Flatpak $* repository"

	#flatpak remote-delete "$@"
	#flatpak remote-delete --user "$@"
	flatpak remote-delete --system "$@"

	display_message_value_status_success_complex "Flatpak $* repository has been added"
}

system_pkg_any_flatpak_repository_syncronize() {
	display_message_value_status_success_complex "Syncronizing Flatpak $* repository"

	flatpak update

	display_message_value_status_success_complex "Flatpak $* repository has been syncronized"
}

#@annotation_must_be_improved
system_pkg_any_flatpak_software_install() {
	display_message_value_status_success_complex "Installing Flatpak $* software"

	case $DEBUG in
	"false") flatpak install "$@" ;;
	"true") flatpak install -y "$@" ;;
	esac

	display_message_value_status_success_complex "Flatpak $* software(s) has/have been installed"
}

system_pkg_any_flatpak_software_list() {
	display_message_value_status_success_complex "Listing Flatpak $* softwares"

	flatpak list
}

#@annotation_must_be_improved
system_pkg_any_flatpak_software_uninstall() {
	display_message_value_status_success_complex "Uninstalling Flatpak $* software"

	case $DEBUG in
	"false") flatpak uninstall "$@" ;;
	"true") flatpak uninstall -y "$@" ;;
	esac

	display_message_value_status_success_complex "Flatpak $* software(s) has/have been uninstalled"
}
