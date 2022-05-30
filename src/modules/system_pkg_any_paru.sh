#############################
#System package manager - Paru
#############################

#@annotation_must_be_created
system_pkg_any_paru_repository_add(){
	display_message_value_status_warning_complex "Adding Paru $* repository"
	
	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Paru $* repository has been added"
}

#@annotation_must_be_created
system_pkg_any_paru_repository_remove(){
	display_message_value_status_warning_complex "Removing Paru $* repository"
	
	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Paru $* repository has been removed"
}

#@annotation_must_be_created
system_pkg_any_paru_repository_syncronize(){
	display_message_value_status_warning_complex "Syncronizing Paru $* repository"
	
	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Paru $* repository has been syncronized"
}

#@annotation_must_be_created
system_pkg_any_paru_software_install(){
	display_message_value_status_warning_complex "Installing Paru $* software"
	
	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Paru $* software has been installed"
}

#@annotation_must_be_created
system_pkg_any_paru_software_list(){
	display_message_value_status_warning_complex "Listing Paru $* softwares"
	
	display_message_value_status_empty_complex
}

#@annotation_must_be_created
system_pkg_any_paru_software_uninstall(){
	display_message_value_status_warning_complex "Uninstalling Paru $* software"

	display_message_value_status_empty_complex
	
	display_message_value_status_success_complex "Paru $* software has been unistalled"
}