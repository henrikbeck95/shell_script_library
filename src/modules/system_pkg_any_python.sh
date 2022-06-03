#############################
#System package manager - Python
#############################

#@annotation_must_be_created
system_pkg_any_python_anaconda_repository_add() {
	display_message_value_status_warning_complex "Adding Python - Anaconda $* repository"

	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Python - Anaconda $* repository has been added"
}

#@annotation_must_be_created
system_pkg_any_python_anaconda_repository_remove() {
	display_message_value_status_warning_complex "Remove Python - Anaconda $* repository"

	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Python - Anaconda $* repository has been added"
}

#@annotation_must_be_created
system_pkg_any_python_anaconda_repository_syncronize() {
	display_message_value_status_warning_complex "Syncronizing Python - Anaconda $* repository"

	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Python - Anaconda $* repository has been syncronized"
}

#@annotation_must_be_created
system_pkg_any_python_anaconda_software_install() {
	display_message_value_status_warning_complex "Installing Python - Anaconda $* software"

	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Python - Anaconda $* software(s) has/have been installed"
}

#@annotation_must_be_created
system_pkg_any_python_anaconda_software_list() {
	display_message_value_status_warning_complex "Listing Python - Anaconda softwares"

	display_message_value_status_empty_complex
}

#@annotation_must_be_created
system_pkg_any_python_anaconda_software_uninstall() {
	display_message_value_status_warning_complex "Uninstalling Python - Anaconda $* software"

	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Python - Anaconda $* software(s) has/have been uninstalled"
}

#@annotation_must_be_created
system_pkg_any_python_pip_repository_add() {
	display_message_value_status_warning_complex "Adding Python - Pip3 $* repository"

	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Python - Pip3 $* repository has been added"
}

#@annotation_must_be_created
system_pkg_any_python_pip_repository_remove() {
	display_message_value_status_warning_complex "Removing Python - Pip3 $* repository"

	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Python - Pip3 $* repository has been added"
}

#@annotation_must_be_created
system_pkg_any_python_pip_repository_syncronize() {
	display_message_value_status_warning_complex "Syncronizing Python - Pip3 $* repository"

	#/usr/bin/python3.10 -m pip install --upgrade pip
	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Python - Pip3 $* repository has been syncronized"
}

system_pkg_any_python_pip_software_install() {
	display_message_value_status_warning_complex "Installing Python - Pip3 $* software"

	case $DEBUG in
	"false") pip3 install "$@" ;;
	"true") pip3 install -y "$@" ;;
	esac

	display_message_value_status_success_complex "Python - Pip3 $* software(s) has/have been installed"
}

system_pkg_any_python_pip_software_list() {
	display_message_value_status_warning_complex "Listing Python - Pip3 softwares"

	pip3 list
}

#@annotation_must_be_created
system_pkg_any_python_pip_software_uninstall() {
	display_message_value_status_warning_complex "Uninstalling Python - Pip3 $* software"

	display_message_value_status_empty_complex

	display_message_value_status_success_complex "Python - Pip3 $* software(s) has/have been uninstalled"
}
