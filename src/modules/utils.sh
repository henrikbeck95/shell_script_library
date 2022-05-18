#############################
#Utilities
#############################

utils_browser_open_url(){
	display_message_warning_complex "Opening $@ from $BROWSER browser software"

	xdg-open $@ &
}

#label_must_be_improved
utils_check_architecture(){
    #case $($ARCHITECTURE) in
    case $(getconf LONG_BIT) in
		"32") echo "32-bits" ;;
		"64") echo "64-bits" ;;
		*) display_message_error_complex "" ;;
	esac
}

utils_check_if_file_exists(){
    local VALUE_PATH_FILE="$1"

    if [[ -f $VALUE_PATH_FILE ]]; then
        display_message_default_simple "true"
    else
        display_message_default_simple "false"
    fi
}

utils_check_if_folder_exists(){
    local VALUE_PATH_FOLDER="$1"

    if [[ -d $VALUE_PATH_FOLDER ]]; then
        display_message_default_simple "true"
    else
        display_message_default_simple "false"
    fi
}

utils_check_if_firmware_supports_uefi(){
	#if [ -z "$(ls -A /sys/firmware/efi/efivars)" ]; then
	if [ -z "$(ls -A /sys/firmware/efi/efivars 2>&1 /dev/null)" ]; then
		display_message_default_simple "false"
	else
		display_message_default_simple "true"
	fi
}

utils_check_if_function_exists(){
    local FUNCTION_NAME=$1
    
    #declare -F "$1" > /dev/null;
	
	#declare -f -F "$1" > /dev/null
    #return $?

    if [[ $(declare -F "$FUNCTION_NAME") ]]; then
        echo "true"
    else
        echo "false"
    fi
}

utils_check_if_internet_connection_exists(){
    display_message_warning_complex "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        display_message_default_simple "true"
    else
        display_message_default_simple "false"
    fi
}

utils_check_if_software_is_installed(){
	if command -v $1 >/dev/null; then
        display_message_default_simple "true"
    else
        display_message_default_simple "false"
    fi
}

utils_check_if_user_exists(){
    local SEARCH_USERNAME=$1

	if [[ $(grep ^$SEARCH_USERNAME: /etc/passwd) != "" ]]; then
        display_message_default_simple "true"
	else
        display_message_default_simple "false"
	fi
}

utils_check_if_user_has_root_previledges(){
	if [[ $UID != 0 ]]; then
		display_message_error_simple "You must be root for preduring this step."
		exit 127;
	fi
}

utils_check_if_variable_exists(){
	local VALUE_VARIABLE=$1

	if [[ -n "$VALUE_VARIABLE" ]]; then
		display_message_default_simple "true"
	else
		display_message_default_simple "false"
	fi
}

utils_check_if_variable_is_null(){
    local VALUE_VARIABLE=$1

    if [[ "$VALUE_VARIABLE" == "" ]]; then
		display_message_default_simple "true"
	else
		display_message_default_simple "false"
    fi
}

utils_check_if_variable_is_boolean(){
	local VALUE_VARIABLE=$1

    case $VALUE_VARIABLE in
        "false" | "true") display_message_default_simple "true" ;;
        *) display_message_default_simple "false" ;;
    esac
}

utils_check_if_variable_is_char(){
	local VALUE_VARIABLE=$1
    
    case ${#VALUE_VARIABLE} in
        1) display_message_default_simple "true" ;;
        *) display_message_default_simple "false" ;;
    esac
}

utils_check_if_variable_is_float(){
    local VALUE_VARIABLE=$1

    #if [[ "$VALUE_VARIABLE" -eq "$VALUE_VARIABLE" ]] 2> /dev/null; then
	if [[ $(echo "$VALUE_VARIABLE" | grep "^[0-9]*[.][0-9]*$" && val=`echo $?`) ]] || [[ $(echo "$VALUE_VARIABLE" | grep "^-[0-9]*[.][0-9]*$" && val=`echo $?`) ]]; then
	#if [[ $(($VALUE_VARIABLE+0.5)) -eq $(($VALUE_VARIABLE+0.5)) ]]; then
	#if [[ $(awk "BEGIN{ print $VALUE_VARIABLE + 0.5 }") -eq $(awk "BEGIN{ print $VALUE_VARIABLE + 0.5 }") ]]; then
		display_message_default_simple "true"
	else
		display_message_default_simple "false"
	fi
}

utils_check_if_variable_is_integer(){
    local VALUE_VARIABLE=$1

    #if [[ "$VALUE_VARIABLE" =~ ^[0-9]+$ ]]; then
    #if [[ "$VALUE_VARIABLE" -eq "$VALUE_VARIABLE" ]] 2> /dev/null; then
    #if [[ $VALUE_VARIABLE =~ ^[[:digit:]]+$ ]]; then
    if [[ $VALUE_VARIABLE =~ ^[[:digit:]]+$ ]] || [[ $VALUE_VARIABLE =~ ^-[[:digit:]]+$ ]]; then
		display_message_default_simple "true"
	else
		display_message_default_simple "false"
    fi
}

utils_check_if_variable_is_number(){
    local VALUE_VARIABLE=$1

    case $(utils_check_if_variable_is_integer $VALUE_VARIABLE) in
        "false")
            case $(utils_check_if_variable_is_float $VALUE_VARIABLE) in
                "false") display_message_default_simple "false" ;;
                "true") display_message_default_simple "true" ;;
            esac
            ;;
        "true") display_message_default_simple "true" ;;
    esac
}

utils_check_if_variable_is_string(){
	local VALUE_VARIABLE=$1

	case $(utils_check_if_variable_is_null $VALUE_VARIABLE) in
        "false")
			case $(utils_check_if_variable_is_number $VALUE_VARIABLE) in
				"false") display_message_default_simple "true" ;;
				"true") display_message_default_simple "false" ;;
			esac
			;;
        "true") display_message_default_simple "false" ;;
    esac
}

utils_check_if_variable_number_is_even(){
    local VALUE_NUMBER=$1

    if [[ $(($VALUE_NUMBER % 2)) -eq 0 ]]; then
        display_message_default_simple "true"
    else
        display_message_default_simple "false"
    fi
}

utils_check_if_variable_number_is_odd(){
    local VALUE_NUMBER=$1

    if [[ ! $(($VALUE_NUMBER % 2)) -eq 0 ]]; then
        display_message_default_simple "true"
    else
        display_message_default_simple "false"
    fi
}

utils_check_if_virtualization_is_enabled(){
	#if [[ $(egrep '^flags.*(vmx|svm)' /proc/cpuinfo) ]]; then

	if [[ $(hostnamectl | grep "Virtualization" | awk '{print $2}') ]]; then
	#if [[ $(LC_ALL=C lscpu | grep Virtualization) ]]; then
		display_message_default_simple "true"
	else
		display_message_default_simple "false"
	fi
}

utils_check_operating_system_birthday(){
	#Display the info about when the operating was installed on the machine
	stat -c %w /
}

utils_check_processor_family(){
	PROCESSOR=$(cat /proc/cpuinfo | grep vendor_id | head -1 | awk '{print $3}')
	#PROCESSOR=$(cat /sys/devices/virtual/dmi/id/board_{vendor,name,version})

	display_message_default_simple "$PROCESSOR"
}

#label_must_be_tested
utils_clear_file(){
	local PATH_FILE=$1

	display_message_warning_complex "Clearing terminal history"

	case $(utils_check_if_file_exists "$PATH_FILE") in
		"false") 
			display_message_error_complex "File $PATH_FILE does not exists"
			break
			;;
		"true")
			cat /dev/null > $PATH_FILE
			break
			;;
	esac
}

#label_must_be_tested
utils_clear_history(){
	local QUESTION_TERMINAL_HISTORY

	display_message_warning_complex "Clearing terminal history"

	while true; do
		read -p "Inform what you want: [ash | bash | zsh | skip] " QUESTION_TERMINAL_HISTORY

		case $QUESTION_TERMINAL_HISTORY in
			"ash")
				utils_clear_file "$HOME/.ash_history"
				break
				;;
			"bash")
				utils_clear_file "$HOME/.bash_history"
				break
				;;
			"zsh")
				utils_clear_file "$HOME/.zsh_history"
				break
				;;
			"skip") break ;;
			*) display_message_error_simple "Please answer file or partition." ;;
		esac
	done
}

#label_must_be_tested
utils_convert_pdf_color(){
	local FILE_INPUT="$1"		#./input.pdf
	local FILE_OUTPUT="$2"		#./output.pdf
	local COLOR_ORIGIN="$3"		#black
	local COLOR_DESTINY="$4"	#blue

	magick convert -density 300 $FILE_INPUT -fill $COLOR_DESTINY -opaque $COLOR_ORIGIN $FILE_OUTPUT
}

utils_download_file(){
	local PATH_URL=$1
	local PATH_DESTINY=$2

	case $# in
		1)
			display_message_warning_complex "Downloading $PATH_URL file"
			curl -L -O $PATH_URL
			#wget -c $PATH_URL
			display_message_success_complex "$PATH_URL file has been downloaded"
			break
			;;
		2) 
			display_message_warning_complex "Downloading $PATH_URL file to $PATH_DESTINY"

			mkdir -p $PATH_DESTINY/

			cd $PATH_DESTINY/
			pwd
			curl -L -O $PATH_URL
			#wget -c $PATH_URL -O $PATH_DESTINY
			cd -

			display_message_success_complex "$PATH_URL file has been downloaded to $PATH_DESTINY"
			break
			;;
		*)
			display_message_error_complex "Invalid parameters have been set"
			break
		;;
	esac
}

utils_edit_file(){
	#gedit $@
	#nano $@
	#vi -O $@
	vim -O $@
}

utils_export_desktop_environment(){
	display_message_default_simple "$XDG_CURRENT_DESKTOP"
}

utils_export_variables_bios(){
	display_message_warning_complex "Exporting/loading BIOS variables"

	case $(utils_check_if_firmware_supports_uefi) in
		"false")
			display_message_warning_complex "Consider enabling the UEFI before keep running this setup installtion. There may be some errors"
			export IS_BIOS_UEFI="legacy"
			break
			;;
		"true")
			export IS_BIOS_UEFI="uefi"
			break
			;;
	esac

	display_message_warning_complex "Your device BIOS is $IS_BIOS_UEFI"
}

utils_export_variables_virtualization(){
	local IS_VIRTUALIATION=$(utils_check_if_virtualization_is_enabled)

	if [[ $IS_VIRTUALIATION == "true" ]]; then
		display_message_warning_complex "I know you are using a virtual machine!"

		export PARTITION_PATH="/dev/vda"
		export PARTITION_BOOT="/dev/vda1"
		export PARTITION_ROOT="/dev/vda2"
		export PARTITION_FILE="/dev/vda3"
		export PARTITION_SWAP="/dev/vda4"

	else
		display_message_warning_complex "Great! You are installing on your host machine!"

		export PARTITION_PATH="/dev/sda"
		export PARTITION_BOOT="/dev/sda1"
		export PARTITION_ROOT="/dev/sda2"
		export PARTITION_FILE="/dev/sda3"
		export PARTITION_SWAP="/dev/sda4"
	fi
}

##label_must_be_improved
utils_extract_file_tar(){
	display_message_warning_complex "Extracting $@ file(s)"

	tar -zxvf $@ || tar -xzf $@ || tar -xf $@
	
	display_message_success_complex "File(s) $@ has/have been extracted"
}

utils_extract_file_zip(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"
	
	display_message_warning_complex "Extracting $@ file(s)"

	mkdir -p $FILE_DESTINY/
	unzip $FILE_ORIGIN -d $FILE_DESTINY
	
	display_message_success_complex "File(s) $@ has/have been extracted"
}

utils_generate_link_file_version_latest_github(){
    #Try: curl -fsSL github.com/henrikbeck95/shell_script_library/releases/latest/download/shell-script-library -O
	#Try: curl -fsSL github.com/${REPOSITORY_OWNER}/${REPOSITORY_NAME}/releases/latest/download/${REPOSITORY_FILE} -O
	#Try: curl -fsSL $(utils_generate_link_file_version_latest_github "henrikbeck95" "shell_script_library" "shell-script-library") -O
	local REPOSITORY_OWNER=$1
	local REPOSITORY_NAME=$2
	local REPOSITORY_FILE=$3


	display_message_default "https://github.com/${REPOSITORY_OWNER}/${REPOSITORY_NAME}/releases/latest/download/${REPOSITORY_FILE}"
}

utils_git_repository_clone(){
	local PATH_REPOSITORY_URL=$1

	display_message_warning_complex "Cloning $PATH_REPOSITORY_URL Git repository"

	utils_path_directory_create "$HOME/eclipse-workspace"
	
	cd $HOME/eclipse-workspace/
	git clone $PATH_REPOSITORY_URL
	cd -
	
	display_message_success_complex "$PATH_REPOSITORY_URL Git repository has been cloned"
}

#label_must_be_improved
utils_git_setup_credentials(){
	local USER_EMAIL=$1
	local USER_NAME=$2

	display_message_warning_complex "Setting up Git credentials to $USER_EMAIL - $USER_NAME"

	#Set Git e-mail credential
	git config --global user.email "$USER_EMAIL" #Try: "henrikbeck95@gmail.com"
	
	#Set Git username credential
	git config --global user.name "$USER_NAME" #Try: "Henrik Beck"

	#Store Git credentials to cache file
	#git config --global credential.helper store

	#git pull
	#cat $HOME/.git-credentials | less

	display_message_success_complex "Git setup credentials has been set to $USER_EMAIL - $USER_NAME"
}

utils_load_operating_system_properties(){
	source /etc/os-*
}

utils_move_file(){
	local PATH_ORIGIN=$1
	local PATH_DESTINY=$2

	mv $PATH_ORIGIN $PATH_DESTINY #|| mv -avr $PATH_ORIGIN $PATH_DESTINY
}

#label_must_be_tested
#label_must_be_improved
utils_check_package_manager(){
    declare -A ARRAY_OPERATING_SYSTEM_FILE

    #Verify if system file exists according to the operating system
    ARRAY_OPERATING_SYSTEM_FILE[/etc/debian_version]=apt
    ARRAY_OPERATING_SYSTEM_FILE[/etc/alpine-release]=apk
    ARRAY_OPERATING_SYSTEM_FILE[/etc/gentoo-release]=emerge
    #ARRAY_OPERATING_SYSTEM_FILE[/etc/paru.conf]=paru
    ARRAY_OPERATING_SYSTEM_FILE[/etc/arch-release]=pacman
    #ARRAY_OPERATING_SYSTEM_FILE[/etc/pacman.conf]=pacman
    ARRAY_OPERATING_SYSTEM_FILE[/etc/slackpkg/slackpkg.conf]=slackpkg
    ARRAY_OPERATING_SYSTEM_FILE[/etc/redhat-release]=yum
    ARRAY_OPERATING_SYSTEM_FILE[/etc/SuSE-release]=zypper

    #Return all the installed package managers
    for i in ${!ARRAY_OPERATING_SYSTEM_FILE[@]}; do
       if [[ -f $i ]]; then
            display_message_default_complex "${ARRAY_OPERATING_SYSTEM_FILE[$i]}"
            #display_message_default_simple "${ARRAY_OPERATING_SYSTEM_FILE[$i]}"
            break
        fi
    done
}

utils_path_directory_create(){
	local PATH_FOLDER=$1

	display_message_warning_complex "Creating $PATH_FOLDER folder directory"
	
	if [[ ! -d $PATH_FOLDER/ ]]; then
		mkdir -p $PATH_FOLDER/
	fi

	display_message_success_complex "$PATH_FOLDER folder directory has been created"
}

utils_remove_file(){
	local PATH_FILE=$1

	rm $PATH_FILE || rm -f $PATH_FILE || rm -fr $PATH_FILE
}

utils_screen_size_count_limit_maximum_characters_horizontal(){
    local CHARACTERS_UNITS=$(tput cols)

    display_message_default_simple "$CHARACTERS_UNITS"
}

#utils_screen_size_count_limit_maximum_characters_vertical(){}

utils_symbolic_link_create(){
	local PATH_ORIGIN=$1
	local PATH_DESTINY=$2

	display_message_warning_complex "Creating symbolic link to $PATH_ORIGIN to $PATH_DESTINY"
	
	ln -sf $PATH_ORIGIN $PATH_DESTINY

	display_message_success_complex "Symbolic link from $PATH_ORIGIN to $PATH_DESTINY has been created"
}

utils_update_fonts_cache(){
	display_message_warning_complex "Update cache from $HOME/.fonts/, /usr/share/fonts/ and /usr/local/share/fonts/ fonts pathes"
	
	fc-cache update || fc-cache -f -v

	display_message_success_complex "Font cache pathes from $HOME/.fonts/, /usr/share/fonts/ and /usr/local/share/fonts/ have been updated"
}