#############################
#System package manager - Flatpak
#############################

system_pkg_any_flatpak_repository_add(){
	display_message_success_complex "Adding Flatpak $@ repository"
	
	#flatpak remote-add --if-not-exists $@
	#flatpak remote-add --user --if-not-exists $@
	flatpak remote-add --system --if-not-exists $@
	
	display_message_success_complex "Flatpak $@ repository has been added"
}

system_pkg_any_flatpak_repository_list(){
	display_message_success_complex "Listing Flatpak $@ repositories"

	flatpak remote-list
}

system_pkg_any_flatpak_repository_remove(){
	display_message_success_complex "Removing Flatpak $@ repository"
	
	#flatpak remote-delete $@
	#flatpak remote-delete --user $@
	flatpak remote-delete --system $@

	display_message_success_complex "Flatpak $@ repository has been added"
}

system_pkg_any_flatpak_repository_syncronize(){
	display_message_success_complex "Syncronizing Flatpak $@ repository"
    
	flatpak update
	
	display_message_success_complex "Flatpak $@ repository has been syncronized"
}

system_pkg_any_flatpak_software_install(){
	display_message_success_complex "Installing Flatpak $@ software"
	
	case $DEBUG in
		"false") flatpak install $@ ;;
		"true") flatpak install -y $@ ;;
	esac
	
	display_message_success_complex "Flatpak $@ software(s) has/have been installed"
}

system_pkg_any_flatpak_software_list(){
	display_message_success_complex "Listing Flatpak $@ softwares"
	
	flatpak list
}

system_pkg_any_flatpak_software_uninstall(){
	display_message_success_complex "Uninstalling Flatpak $@ software"
    
	case $DEBUG in
		"false") flatpak uninstall $@ ;;
		"true") flatpak uninstall -y $@ ;;
	esac
	
	display_message_success_complex "Flatpak $@ software(s) has/have been uninstalled"
}