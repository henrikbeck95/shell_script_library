#############################
#System permission
#############################

system_permission_set_executable(){
	display_message_default "Giving executable permission to $@ file(s)"
	
	chmod +x $@

	display_message_success "File(s) $@ has/have been given executable permission"
}