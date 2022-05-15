#############################
#System package manager - Node
#############################

#label_must_be_created
system_pkg_any_node_npm_repository_add(){
	display_message_warning_complex "Adding Node - NPM $@ repository"

	display_message_empty_complex

	display_message_success_complex "Node - NPM $@ repository has been added"
}

#label_must_be_created
system_pkg_any_node_npm_repository_remove(){
	display_message_warning_complex "Removing Node - NPM $@ repository"
	
	display_message_empty_complex
	
	display_message_success_complex "Node - NPM $@ repository has been added"
}

system_pkg_any_node_npm_repository_syncronize(){
	display_message_warning_complex "Syncronizing Node - NPM $@ repository"
	
	npm install npm@latest -g
	
	display_message_success_complex "Node - NPM $@ repository has been syncronized"
}

system_pkg_any_node_npm_software_install_global(){
	display_message_warning_complex "Installing Node - NPM (globally) $@ software"
	
	npm install -g $@
	
	display_message_success_complex "Node - NPM (globally) $@ software(s) has/have been installed"
}

system_pkg_any_node_npm_software_install_local(){
	display_message_warning_complex "Installing Node - NPM (locally) $@ software"
	
	npm install $@
	
	display_message_success_complex "Node - NPM (locally) $@ software(s) has/have been installed"
}

system_pkg_any_node_npm_software_list(){
	display_message_warning_complex "Listing Node - NPM softwares"

	display_message_warning_complex "Listing all local installed Node libraries"
	npm list

	display_message_warning_complex "Listing all globally installed Node libraries"
	npm list -g
}

system_pkg_any_node_npm_software_uninstall_global(){
	display_message_warning_complex "Uninstalling Node - NPM (gloablly) $@ software"
	
	npm uninstall -g $@
	
	display_message_success_complex "Node - NPM (gloablly) $@ software(s) has/have been uninstalled"
}

system_pkg_any_node_npm_software_uninstall_local(){
	display_message_warning_complex "Uninstalling Node - NPM (locally) $@ software"
	
	npm uninstall $@
	
	display_message_success_complex "Node - NPM (locally) $@ software(s) has/have been uninstalled"
}

#label_must_be_created
system_pkg_any_node_yarn_repository_add(){
	display_message_warning_complex "Adding Node - YARN $@ repository"
		
	display_message_empty_complex

	display_message_success_complex "Node - YARN $@ repository has been added"
}

#label_must_be_created
system_pkg_any_node_yarn_repository_remove(){
	display_message_warning_complex "Removing Node - YARN $@ repository"
	
	display_message_empty_complex
	
	display_message_success_complex "Node - YARN $@ repository has been added"
}

#label_must_be_created
system_pkg_any_node_yarn_repository_syncronize(){
	display_message_warning_complex "Syncronizing Node - YARN $@ repository"

	display_message_empty_complex
	
	display_message_success_complex "Node - YARN $@ repository has been syncronized"
}

#label_must_be_created
system_pkg_any_node_yarn_software_install(){
	display_message_warning_complex "Installing Node - YARN $@ software"

	display_message_empty_complex
	
	display_message_success_complex "Node - YARN $@ software(s) has/have been installed"
}

#label_must_be_created
system_pkg_any_node_yarn_software_list(){
	display_message_warning_complex "Listing Node - YARN softwares"

	display_message_empty_complex
}

#label_must_be_created
system_pkg_any_node_yarn_software_uninstall(){
	display_message_warning_complex "Uninstalling Node - YARN $@ software"
		
	display_message_empty_complex
	
	display_message_success_complex "Node - YARN $@ software(s) has/have been uninstalled"
}