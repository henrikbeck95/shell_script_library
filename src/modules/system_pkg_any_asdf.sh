#############################
#System package manager - ASDF
#############################

system_pkg_any_asdf_repository_add(){
	display_message_warning_complex "Adding ASDF $@ repository"
	
	asdf plugin add $@ || asdf plugin-add $@
	system_pkg_any_asdf_repository_syncronize $@

	display_message_success_complex "ASDF $@ repository has been added"
}

system_pkg_any_asdf_repository_remove(){
	display_message_warning_complex "Removing ASDF $@ repository"
	
	asdf plugin remove $@

	display_message_success_complex "ASDF $@ repository has been removed"
}

system_pkg_any_asdf_repository_syncronize(){
	display_message_warning_complex "Syncronizing ASDF $@ repository"
	
	asdf plugin update $@

	display_message_success_complex "ASDF $@ repository has been syncronized"
}

system_pkg_any_asdf_software_install(){
	display_message_warning_complex "Installing ASDF $@ software"
	
	asdf #install python 3.7.4
	asdf install $@

	display_message_success_complex "ASDF $@ software has been installed"
}

system_pkg_any_asdf_software_list(){
	display_message_warning_complex "Listing ASDF $@ softwares"
	
	asdf list
}

system_pkg_any_asdf_software_uninstall(){
	display_message_warning_complex "Uninstalling ASDF $@ software"

	asdf uninstall $@ #Try: python 3.7.4
	
	display_message_success_complex "ASDF $@ software has been unistalled"
}