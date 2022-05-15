#############################
#System package manager - Python
#############################

#label_must_be_created
system_pkg_any_python_anaconda_repository_add(){
	display_message_warning_complex "Adding Python - Anaconda $@ repository"

	display_message_empty_complex

	display_message_success_complex "Python - Anaconda $@ repository has been added"
}

#label_must_be_created
system_pkg_any_python_anaconda_repository_remove(){
	display_message_warning_complex "Remove Python - Anaconda $@ repository"
	
	display_message_empty_complex
	
	display_message_success_complex "Python - Anaconda $@ repository has been added"
}

#label_must_be_created
system_pkg_any_python_anaconda_repository_syncronize(){
	display_message_warning_complex "Syncronizing Python - Anaconda $@ repository"
	
	display_message_empty_complex

	display_message_success_complex "Python - Anaconda $@ repository has been syncronized"
}

#label_must_be_created
system_pkg_any_python_anaconda_software_install(){
	display_message_warning_complex "Installing Python - Anaconda $@ software"
		
	display_message_empty_complex
	
	display_message_success_complex "Python - Anaconda $@ software(s) has/have been installed"
}

#label_must_be_created
system_pkg_any_python_anaconda_software_list(){
	display_message_warning_complex "Listing Python - Anaconda softwares"

	display_message_empty_complex
}

#label_must_be_created
system_pkg_any_python_anaconda_software_uninstall(){
	display_message_warning_complex "Uninstalling Python - Anaconda $@ software"

	display_message_empty_complex
	
	display_message_success_complex "Python - Anaconda $@ software(s) has/have been uninstalled"
}

#label_must_be_created
system_pkg_any_python_pip_repository_add(){
	display_message_warning_complex "Adding Python - Pip3 $@ repository"

	display_message_empty_complex
		
	display_message_success_complex "Python - Pip3 $@ repository has been added"
}

#label_must_be_created
system_pkg_any_python_pip_repository_remove(){
	display_message_warning_complex "Removing Python - Pip3 $@ repository"
	
	display_message_empty_complex
	
	display_message_success_complex "Python - Pip3 $@ repository has been added"
}

#label_must_be_created
system_pkg_any_python_pip_repository_syncronize(){
	display_message_warning_complex "Syncronizing Python - Pip3 $@ repository"

	display_message_empty_complex
	
	display_message_success_complex "Python - Pip3 $@ repository has been syncronized"
}

system_pkg_any_python_pip_software_install(){
	display_message_warning_complex "Installing Python - Pip3 $@ software"
	
    case $DEBUG in
		"false") pip3 install $@ ;;
		"true") pip3 install -y $@ ;;
	esac

	display_message_success_complex "Python - Pip3 $@ software(s) has/have been installed"
}

system_pkg_any_python_pip_software_list(){
	display_message_warning_complex "Listing Python - Pip3 softwares"

	pip3 list
}

#label_must_be_created
system_pkg_any_python_pip_software_uninstall(){
	display_message_warning_complex "Uninstalling Python - Pip3 $@ software"

	display_message_empty_complex
	
	display_message_success_complex "Python - Pip3 $@ software(s) has/have been uninstalled"
}