#############################
#System permission
#############################

system_permission_set_executable(){
	display_message_value_status_warning_complex "Giving executable permission to $* file(s)"
	
	chmod +x "$@"

	display_message_value_status_success_complex "File(s) $* has/have been given executable permission"
}