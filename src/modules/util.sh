#############################
#Utilities
#############################

util_browser_open_url(){
	display_message_default "Opening $@ from $BROWSER browser software"

	xdg-open $@ &
}

util_check_if_file_exists(){
    local VALUE_PATH_FILE="$1"

    if [[ -f $VALUE_PATH_FILE ]]; then
        echo "true"
    else
        echo "false"
    fi
}

util_check_if_folder_exists(){
    local VALUE_PATH_FOLDER="$1"

    if [[ -d $VALUE_PATH_FOLDER ]]; then
        echo "true"
    else
        echo "false"
    fi
}

util_check_if_firmware_supports_uefi(){
	#if [ -z "$(ls -A /sys/firmware/efi/efivars)" ]; then
	if [ -z "$(ls -A /sys/firmware/efi/efivars 2>&1 /dev/null)" ]; then
		display_message_default "false"
	else
		display_message_default "true"
	fi
}

util_check_if_internet_connection_exists(){
    display_message_default "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        display_message_default "true"
    else
        display_message_default "false"
    fi
}

util_check_if_software_is_installed(){
	if command -v $1 >/dev/null; then
        display_message_default "true"
    else
        display_message_default "false"
    fi
}

util_check_if_user_exists(){
    local SEARCH_USERNAME=$1

	if [[ $(grep ^$SEARCH_USERNAME: /etc/passwd) != "" ]]; then
        display_message_default "true"
	else
        display_message_default "false"
	fi
}

util_check_if_user_has_root_previledges(){
	if [[ $UID != 0 ]]; then
		display_message_default "You must be root for preduring this step!"
		exit 127;
	fi
}

util_check_if_virtualization_is_enabled(){
	#if [[ $(egrep '^flags.*(vmx|svm)' /proc/cpuinfo) ]]; then

	if [[ $(hostnamectl | grep "Virtualization" | awk '{print $2}') ]]; then
	#if [[ $(LC_ALL=C lscpu | grep Virtualization) ]]; then
		display_message_default "true"
	else
		display_message_default "false"
	fi
}

util_check_processor_family(){
	PROCESSOR=$(cat /proc/cpuinfo | grep vendor_id | head -1 | awk '{print $3}')
	#PROCESSOR=$(cat /sys/devices/virtual/dmi/id/board_{vendor,name,version})

	display_message_default "$PROCESSOR"
}

util_clear_history(){
	display_message_default "Clearing terminal history"

	while true; do
		read -p "Inform what you want: [ash | bash | zsh | skip] " QUESTION_TERMINAL_HISTORY

		case $QUESTION_TERMINAL_HISTORY in
			"ash")
				cat /dev/null > $HOME/.ash_history
				break
				;;
			"bash")
				cat /dev/null > $HOME/.bash_history
				break
				;;
			"zsh")
				cat /dev/null > $HOME/.zsh_history
				break
				;;
			"skip") break ;;
			*) display_message_default "Please answer file or partition." ;;
		esac
	done
}

util_download_file(){
	case $# in
		1)
			display_message_warning "Downloading $1 file"
			curl -L -O $1
			#wget -c $1
			display_message_success "$1 file has been downloaded"
			;;
		2) 
			display_message_warning "Downloading $1 file to $2"

			mkdir -p $2

			cd $2
			pwd
			curl -L -O $1
			#wget -c $1 -O $2
			cd -

			display_message_success "$1 file has been downloaded to $2"
			;;
		*) display_message_error "Invalid option" ;;
	esac
}

util_edit_file(){
	#gedit $@
	#nano $@
	#vi -O $@
	vim -O $@
}

util_export_desktop_environment(){
	echo "$XDG_CURRENT_DESKTOP"
}

util_export_variables_bios(){
	display_message_default "Exporting/loading BIOS variables"

	case $(util_check_if_firmware_supports_uefi) in
		"false")
			IS_BIOS_UEFI="legacy"
		
			display_message_error "Consider enabling the UEFI before keep running this setup installtion. There may be some errors"
			;;
		"true") IS_BIOS_UEFI="uefi" ;;
	esac

	display_message_warning "Your device BIOS is $IS_BIOS_UEFI"
}

util_export_variables_virtualization(){
	IS_VIRTUALIATION=$(util_check_if_virtualization_is_enabled)

	if [[ $IS_VIRTUALIATION == "true" ]]; then
		display_message_warning "I know you are using a virtual machine!"

		PARTITION_PATH="/dev/vda"
		PARTITION_BOOT="/dev/vda1"
		PARTITION_ROOT="/dev/vda2"
		PARTITION_FILE="/dev/vda3"
		PARTITION_SWAP="/dev/vda4"

	else
		display_message_warning "Great! You are installing on your host machine!"

		PARTITION_PATH="/dev/sda"
		PARTITION_BOOT="/dev/sda1"
		PARTITION_ROOT="/dev/sda2"
		PARTITION_FILE="/dev/sda3"
		PARTITION_SWAP="/dev/sda4"
	fi
}

util_extract_file_tar(){
	display_message_default "Extracting $@ file(s)"

	tar -zxvf $@ || tar -xzf $@ || tar -xf $@
	
	display_message_success "File(s) $@ has/have been extracted"
}

util_extract_file_zip(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	mkdir -p $FILE_DESTINY

	unzip $FILE_ORIGIN -d $FILE_DESTINY
}

util_git_repository_clone(){
	display_message_success "Cloning $1 Git repository"

	util_path_directory_create $HOME/Documents/developement/
	
	cd $HOME/Documents/developement/
	git clone $1
	cd -
	
	display_message_success "$1 Git repository has been cloned"
}

#label_must_be_improved
util_git_setup_credentials(){
	display_message_default "Setting up Git credentials to $1 - $2"

	#Set Git e-mail credential
	git config --global user.email "$1" #Try: "henrikbeck95@gmail.com"
	
	#Set Git username credential
	git config --global user.name "$2" #Try: "Henrik Beck"

	#Store Git credentials to cache file
	#git config --global credential.helper store

	#git pull
	#cat ~/.git-credentials

	display_message_success "Git setup credentials has been set to $1 - $2"
}

util_load_operating_system_properties(){
	source /etc/os-*
}

util_path_directory_create(){
	display_message_warning "Creating $@ folder directory"
	
	if [[ ! -d $@/ ]]; then
		mkdir -p $@/
	fi

	display_message_success "$@ folder directory has been created"
}

util_symbolic_link_create(){
	display_message_warning "Creating symbolic link to $1 to $2"
	
	ln -sf $1 $2

	display_message_success "Symbolic link from $1 to $2 has been created"
}

util_update_fonts_cache(){
	display_message_default "Update cache from $HOME/.fonts/, /usr/share/fonts/ and /usr/local/share/fonts/ fonts pathes"
	
	fc-cache update

	display_message_success "Font cache pathes from $HOME/.fonts/, /usr/share/fonts/ and /usr/local/share/fonts/ have been updated"
}