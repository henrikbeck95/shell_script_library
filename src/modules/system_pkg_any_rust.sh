#############################
#System package manager - Rust
#############################

#@annotation_must_be_created
system_pkg_any_rust_cargo_repository_add() {
	display_message_value_status_warning_complex "Adding Rust - Cargo $* repository"

	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Rust - Cargo $* repository has been added"
}

#@annotation_must_be_created
system_pkg_any_rust_cargo_repository_remove() {
	display_message_value_status_warning_complex "Removing Rust - Cargo $* repository"

	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Rust - Cargo $* repository has been added"
}

#@annotation_must_be_created
system_pkg_any_rust_cargo_repository_syncronize() {
	display_message_value_status_warning_complex "Syncronizing Rust - Cargo $* repository"

	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Rust - Cargo $* repository has been syncronized"
}

#@annotation_must_be_created
system_pkg_any_rust_cargo_software_list() {
	display_message_value_status_warning_complex "List Rust - Cargo softwares"

	display_message_value_status_empty_complex
}

#@annotation_must_be_created
system_pkg_any_rust_cargo_software_install() {
	display_message_value_status_warning_complex "Installing Rust - Cargo $* software"

	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Rust - Cargo $* software(s) has/have been installed"
}

#@annotation_must_be_created
system_pkg_any_rust_cargo_software_uninstall() {
	display_message_value_status_warning_complex "Uninstalling Rust - Cargo $* software"

	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Rust - Cargo $* software(s) has/have been uninstalled"
}
