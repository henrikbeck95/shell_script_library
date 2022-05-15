#############################
#System package manager - Rust
#############################

#label_must_be_created
system_pkg_any_rust_cargo_repository_add(){
	display_message_warning_complex "Adding Rust - Cargo $@ repository"
		
	display_message_empty_complex

	display_message_success_complex "Rust - Cargo $@ repository has been added"
}

#label_must_be_created
system_pkg_any_rust_cargo_repository_remove(){
	display_message_warning_complex "Removing Rust - Cargo $@ repository"
	
	display_message_empty_complex

	display_message_success_complex "Rust - Cargo $@ repository has been added"
}

#label_must_be_created
system_pkg_any_rust_cargo_repository_syncronize(){
	display_message_warning_complex "Syncronizing Rust - Cargo $@ repository"

	display_message_empty_complex
	
	display_message_success_complex "Rust - Cargo $@ repository has been syncronized"
}

#label_must_be_created
system_pkg_any_rust_cargo_software_list(){
	display_message_warning_complex "List Rust - Cargo softwares"

	display_message_empty_complex
}

#label_must_be_created
system_pkg_any_rust_cargo_software_install(){
	display_message_warning_complex "Installing Rust - Cargo $@ software"
	
	display_message_empty_complex
	
	display_message_success_complex "Rust - Cargo $@ software(s) has/have been installed"
}

#label_must_be_created
system_pkg_any_rust_cargo_software_uninstall(){
	display_message_warning_complex "Uninstalling Rust - Cargo $@ software"

	display_message_empty_complex
		
	display_message_success_complex "Rust - Cargo $@ software(s) has/have been uninstalled"
}