#############################
#Utilities
#############################

utils_browser_open_url(){
	display_message_value_status_warning_complex "Opening $* from $BROWSER browser software"

	xdg-open "$@" &
}

utils_calculate_area_triangule() {
	#utils_calculate_area_triangule "3" "4" "5"

	local SIDE_A=$1
	local SIDE_B=$2
	local SIDE_C=$3
	local RESULT_AUX
	local RESULT_FINAL

	RESULT_AUX=$(math_calculate "($SIDE_A + $SIDE_B + $SIDE_C) / 2")
	RESULT_FINAL=$(math_sqrt "($RESULT_AUX * ($RESULT_AUX - $SIDE_A) * ($RESULT_AUX - $SIDE_B) * ($RESULT_AUX - $SIDE_C))" "2")

	display_message_value_number_simple "$RESULT_FINAL"
}

utils_calculate_area_square() {
	#utils_calculate_area_square "6"

	local SIDE_LENGTH=$1
	local RESULT=$((SIDE_LENGTH * SIDE_LENGTH))

	display_message_value_number_simple "$RESULT"
}

utils_calculate_area_rectangle() {
	#utils_calculate_area_rectangle "3" "5"

	local SIDE_LENGTH=$1
	local SIDE_WIDTH=$2
	local RESULT=$((SIDE_LENGTH * SIDE_WIDTH))

	display_message_value_number_simple "$RESULT"
}

#@annotation_must_be_improved
utils_check_architecture(){
    #case $($ARCHITECTURE) in
    case $(getconf LONG_BIT) in
		"32") echo "32-bits" ;;
		"64") echo "64-bits" ;;
		*) display_message_value_status_error_complex "" ;;
	esac
}

#@annotation_must_be_created
#utils_check_if_device_is_desktop(){}

#@annotation_must_be_created
#utils_check_if_device_is_mobile(){}

#@annotation_must_be_created
#utils_check_if_device_is_laptop(){}

utils_check_if_file_exists(){
    local VALUE_PATH_FILE="$1"

    if [[ -f $VALUE_PATH_FILE ]]; then
        display_message_value_text_default_simple "true"
    else
        display_message_value_text_default_simple "false"
    fi
}

utils_check_if_folder_exists(){
    local VALUE_PATH_FOLDER="$1"

    if [[ -d $VALUE_PATH_FOLDER ]]; then
        display_message_value_text_default_simple "true"
    else
        display_message_value_text_default_simple "false"
    fi
}

#@annotation_must_be_updated
utils_check_if_firmware_supports_uefi(){
	#if [ -z "$(ls -A /sys/firmware/efi/efivars)" ]; then
	if [ -z "$(ls -A /sys/firmware/efi/efivars 2>&1 /dev/null)" ]; then
		display_message_value_text_default_simple "false"
	else
		display_message_value_text_default_simple "true"
	fi
}

utils_check_if_function_exists(){
    local FUNCTION_NAME="$1"
    
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
    display_message_value_status_warning_complex "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        display_message_value_text_default_simple "true"
    else
        display_message_value_text_default_simple "false"
    fi
}

utils_check_if_path_is_inside_git_project_anywhere(){
    local PATH_FOLDER="$1"
    local RESULT

    cd "$PATH_FOLDER" || exit

    RESULT="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
    
    if [ "$RESULT" == "true" ]; then
        display_message_value_text_default_simple "true"
    else
        display_message_value_text_default_simple "false"
    fi

    cd - || exit
}

utils_check_if_path_is_inside_git_project_root(){
    #utils_check_if_path_is_inside_git_project_root "/etc/"
    #utils_check_if_path_is_inside_git_project_root "$HOME/"
    #utils_check_if_path_is_inside_git_project_root "$HOME/.asdf/"
    #utils_check_if_path_is_inside_git_project_root "$HOME/.asdf/downloads/java/"

    local PATH_FOLDER="$1"
    local PATH_ROOT

    cd "$PATH_FOLDER" || exit

    #Remove last / character if user has set it
    if [[ $(string_get_content_character_last "$PATH_FOLDER") == "/" ]]; then
        PATH_FOLDER=$(string_get_content_character_from_begin "$PATH_FOLDER" "-1")
    fi

    PATH_ROOT=$(utils_get_path_git_project_root "$PATH_FOLDER")

    #Display the result value
    if [[ "$PATH_FOLDER" == "$PATH_ROOT" ]]; then
        display_message_value_text_default_simple "true"
    else
        display_message_value_text_default_simple "false"
    fi

    cd - || exit
}

utils_check_if_software_is_installed(){
    local SOFTWARE_NAME="$1"

    if command -v "$SOFTWARE_NAME" >/dev/null; then
        display_message_value_text_default_simple "true"
    else
        display_message_value_text_default_simple "false"
    fi
}

utils_check_if_user_exists(){
    local SEARCH_USERNAME="$1"

	if [[ $(grep ^"$SEARCH_USERNAME": /etc/passwd) != "" ]]; then
        display_message_value_text_default_simple "true"
	else
        display_message_value_text_default_simple "false"
	fi
}

utils_check_if_user_has_root_previledges(){
	if [[ $UID != 0 ]]; then
		display_message_value_status_error_simple "You must be root for preduring this step."
		exit 127;
	fi
}

utils_check_if_variable_exists(){
	local VALUE_VARIABLE="$1"

	if [[ -n "$VALUE_VARIABLE" ]]; then
		display_message_value_text_default_simple "true"
	else
		display_message_value_text_default_simple "false"
	fi
}

utils_check_if_variable_is_null(){
	#utils_check_if_variable_is_null ""
	#utils_check_if_variable_is_null "testing"
    
	local VALUE_VARIABLE="$1"

    #if [[ "$VALUE_VARIABLE" == "" ]]; then
    if [[ -z "$VALUE_VARIABLE" ]]; then
		display_message_value_text_default_simple "true"
	else
		display_message_value_text_default_simple "false"
    fi
}

utils_check_if_variable_is_boolean(){
	local VALUE_VARIABLE="$1"

    case $VALUE_VARIABLE in
        0 | 1 | "false" | "true") display_message_value_text_default_simple "true" ;;
        *) display_message_value_text_default_simple "false" ;;
    esac
}

utils_check_if_variable_is_char(){
	local VALUE_VARIABLE="$1"
    
    case ${#VALUE_VARIABLE} in
        1) display_message_value_text_default_simple "true" ;;
        *) display_message_value_text_default_simple "false" ;;
    esac
}

utils_check_if_variable_is_float(){
    local VALUE_VARIABLE="$1"

    #if [[ "$VALUE_VARIABLE" -eq "$VALUE_VARIABLE" ]] 2> /dev/null; then
	if [[ $(echo "$VALUE_VARIABLE" | grep "^[0-9]*[.][0-9]*$" && val=$(echo $?)) ]] || [[ $(echo "$VALUE_VARIABLE" | grep "^-[0-9]*[.][0-9]*$" && val=$(echo $?)) ]]; then
	#if [[ $(($VALUE_VARIABLE+0.5)) -eq $(($VALUE_VARIABLE+0.5)) ]]; then
	#if [[ $(awk "BEGIN{ print $VALUE_VARIABLE + 0.5 }") -eq $(awk "BEGIN{ print $VALUE_VARIABLE + 0.5 }") ]]; then
		display_message_value_text_default_simple "true"
	else
		display_message_value_text_default_simple "false"
	fi
}

utils_check_if_variable_is_integer(){
    local VALUE_VARIABLE="$1"

    #if [[ "$VALUE_VARIABLE" =~ ^[0-9]+$ ]]; then
    #if [[ "$VALUE_VARIABLE" -eq "$VALUE_VARIABLE" ]] 2> /dev/null; then
    #if [[ $VALUE_VARIABLE =~ ^[[:digit:]]+$ ]]; then
    if [[ $VALUE_VARIABLE =~ ^[[:digit:]]+$ ]] || [[ $VALUE_VARIABLE =~ ^-[[:digit:]]+$ ]]; then
		display_message_value_text_default_simple "true"
	else
		display_message_value_text_default_simple "false"
    fi
}

utils_check_if_variable_is_number(){
    local VALUE_VARIABLE="$1"

    case $(utils_check_if_variable_is_integer "$VALUE_VARIABLE") in
        "false")
            case $(utils_check_if_variable_is_float "$VALUE_VARIABLE") in
                "false") display_message_value_text_default_simple "false" ;;
                "true") display_message_value_text_default_simple "true" ;;
            esac
            ;;
        "true") display_message_value_text_default_simple "true" ;;
    esac
}

utils_check_if_variable_is_string(){
	local VALUE_VARIABLE="$1"

	case $(utils_check_if_variable_is_null "$VALUE_VARIABLE") in
        "false")
			case $(utils_check_if_variable_is_number "$VALUE_VARIABLE") in
				"false") display_message_value_text_default_simple "true" ;;
				"true") display_message_value_text_default_simple "false" ;;
			esac
			;;
        "true") display_message_value_text_default_simple "false" ;;
    esac
}

utils_check_if_variable_number_is_even(){
    local VALUE_NUMBER="$1"

	case $(utils_check_if_variable_is_integer "$VALUE_NUMBER") in
		"false") display_message_value_text_default_simple "false" ;;
		"true")
			if [[ $((VALUE_NUMBER % 2)) -eq 0 ]]; then
				display_message_value_text_default_simple "true"
			else
				display_message_value_text_default_simple "false"
			fi
			;;
	esac
}

utils_check_if_variable_number_is_odd(){
	local VALUE_NUMBER="$1"

	case $(utils_check_if_variable_is_integer "$VALUE_NUMBER") in
		"false") display_message_value_text_default_simple "false" ;;
		"true")
    		if [[ ! $((VALUE_NUMBER % 2)) -eq 0 ]]; then
				display_message_value_text_default_simple "true"
			else
				display_message_value_text_default_simple "false"
			fi
			;;
	esac
}

utils_check_if_variable_number_is_prime() {
	#utils_check_if_variable_number_is_prime "27"
	#utils_check_if_variable_number_is_prime "29"

	local VARIABLE_VALUE=$1

	for ((i = 2; i <= VARIABLE_VALUE / 2; i++)); do
		if [[ $((VARIABLE_VALUE % i)) -eq 0 ]]; then
			display_message_value_text_default_simple "false"
			return 0 #Exit from the function without existing from the script file
		fi
	done

	display_message_value_text_default_simple "true"
}

utils_check_if_virtualization_is_enabled(){
	#if [[ $(egrep '^flags.*(vmx|svm)' /proc/cpuinfo) ]]; then

	if [[ $(hostnamectl | grep "Virtualization" | awk '{print $2}') ]]; then
	#if [[ $(LC_ALL=C lscpu | grep Virtualization) ]]; then
		display_message_value_text_default_simple "true"
	else
		display_message_value_text_default_simple "false"
	fi
}

utils_check_operating_system_birthday(){
	#Display the info about when the operating was installed on the machine
	stat -c %w /
}

utils_check_operating_system_kernel_name(){
    case $(uname -s) in
        "Darwin") display_message_value_text_default_simple "darwin" ;; #In fact it is XNU
        "Linux") display_message_value_text_default_simple "linux" ;;
        CYGWIN* | MINGW32* | MYMS* |MINGGW* ) display_message_value_text_default_simple "nt" ;;
        *) display_message_value_status_error_simple "Other operating system" ;;
    esac
}

utils_check_operating_system_kernel_version(){
    case $(utils_check_operating_system_kernel_name) in
        "darwin") uname -r ;;
        "linux") uname -r ;;
        "nt") display_message_value_status_empty_simple ;;
        *) display_message_value_status_error_simple "Other operating system" ;;
    esac
}

#@annotation_must_be_improved
utils_check_operating_system_linux_distro(){
	declare -A ARRAY_OPERATING_SYSTEM_FILE

    #Verify if system file exists according to the operating system
	#ARRAY_VARIABLE[TITLE]=VALUE
    ARRAY_OPERATING_SYSTEM_FILE[/etc/alpine-release]=alpine
    ARRAY_OPERATING_SYSTEM_FILE[/etc/arch-release]=archlinux
    #ARRAY_OPERATING_SYSTEM_FILE[/etc/pacman.conf]=archlinux
    ARRAY_OPERATING_SYSTEM_FILE[/etc/debian_version]=debian
    ARRAY_OPERATING_SYSTEM_FILE[/etc/gentoo-release]=gentoo
    ARRAY_OPERATING_SYSTEM_FILE[/etc/redhat-release]=redhat
    ARRAY_OPERATING_SYSTEM_FILE[/etc/slackpkg/slackpkg.conf]=slackware
    ARRAY_OPERATING_SYSTEM_FILE[/etc/SuSE-release]=opensuse

    #Return all the installed package managers (only the array title)
    for i in "${!ARRAY_OPERATING_SYSTEM_FILE[@]}"; do
       if [[ -f "$i" ]]; then
            display_message_value_text_default_complex "${ARRAY_OPERATING_SYSTEM_FILE[$i]}"
            #display_message_value_text_default_simple "${ARRAY_OPERATING_SYSTEM_FILE[$i]}"
            break
        fi
    done
}

#@annotation_must_be_improved
utils_check_operating_system_name(){
	if [[ $(utils_check_operating_system_kernel_name) == "darwin" ]]; then
		display_message_value_text_default_simple "MacOS X"
	elif [[ $(utils_check_operating_system_kernel_name) == "linux" ]]; then
		display_message_value_text_default_simple "$(utils_check_operating_system_linux_distro)"
	elif [[ $(utils_check_operating_system_kernel_name) == "nt" ]]; then
		display_message_value_text_default_simple "Windows"
	else
		display_message_value_text_default_simple "null"
	fi
}

#@annotation_must_be_improved
utils_check_operating_system_platform(){
    local SYSTEM_KERNEL_NAME
    
    SYSTEM_KERNEL_NAME=$(utils_check_operating_system_kernel_name)

    if [[ $(uname) == "Darwin" ]]; then
        display_message_value_text_default_simple "apple_macos_x"
    elif [[ ${SYSTEM_KERNEL_NAME:0:5} == "Linux" ]]; then
        display_message_value_text_default_simple "linux"
    elif [[ ${SYSTEM_KERNEL_NAME:0:10} == "Linux" ]]; then
        display_message_value_text_default_simple "microsoft_windows_nt_32_bits"
    elif [[ ${SYSTEM_KERNEL_NAME:0:10} == "Linux" ]]; then
        display_message_value_text_default_simple "microsoft_windows_nt_64_bits"
    else
        display_message_value_status_error_simple ""
    fi
}

utils_check_operating_system_memory_dynamic_time(){
    #utils_check_operating_system_memory_dynamic_time "2"
    
    local TIME_DELAY_SECONDS="$1"

    #Monitor memory without top or htop
    watch -n "$TIME_DELAY_SECONDS" -d '/bin/free -m'
}

utils_check_operating_system_memory_static_ram_gigabyte(){
	local SYSTEM_MEMORY_RAM_GB
	
	SYSTEM_MEMORY_RAM_GB="$(free -h | awk '/^Mem:/ {print $3 "/" $2}')"

	display_message_value_text_default_simple "$SYSTEM_MEMORY_RAM_GB RAM "
}

#@annotation_must_be_tested
#@annotation_must_be_improved
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
    for i in "${!ARRAY_OPERATING_SYSTEM_FILE[@]}"; do
       if [[ -f "$i" ]]; then
            display_message_value_text_default_complex "${ARRAY_OPERATING_SYSTEM_FILE[$i]}"
            #display_message_value_text_default_simple "${ARRAY_OPERATING_SYSTEM_FILE[$i]}"
            break
        fi
    done
}

utils_check_processor_family(){
	local PROCESSOR

    case $(utils_check_if_file_exists "") in
        "false") display_message_value_status_error_simple "Unknown" ;;
        "true") 
            PROCESSOR=$(cat /proc/cpuinfo | grep vendor_id | head -1 | awk '{print $3}')
            #PROCESSOR=$(cat /sys/devices/virtual/dmi/id/board_{vendor,name,version})
	        
            display_message_value_text_default_simple "$PROCESSOR"
            ;;
    esac

}

utils_chronometer_countdown(){
	#utils_chronometer_countdown "00:00:02" #2 seconds
	#utils_chronometer_countdown "00:01:10" #1 minute and 10 seconds
    
	local timeHours=${1:0:2}
    local timeMinutes=${1:3:2}
    local timeSeconds=${1:6:2}

    local timeDisplay=$((timeHours * 3600 + timeMinutes * 60 + timeSeconds))

    while [[ $timeDisplay -gt 0 ]]; do
        sleep 1 &
        printf "\r%02d:%02d:%02d" $((timeDisplay / 3600)) $(((timeDisplay / 60) % 60))  $((timeDisplay % 60))
        timeDisplay=$((timeDisplay - 1))
        wait
    done

    display_message_value_text_default_complex ""
}

#@annotation_must_be_tested
utils_clear_file(){
	local PATH_FILE="$1"

	display_message_value_status_warning_complex "Clearing terminal history"

	case $(utils_check_if_file_exists "$PATH_FILE") in
		"false") 
			display_message_value_status_error_complex "File $PATH_FILE does not exists"
			;;
		"true")
			cat /dev/null > "$PATH_FILE"
			;;
	esac
}

#@annotation_must_be_tested
utils_clear_history(){
	local QUESTION_TERMINAL_HISTORY

	display_message_value_status_warning_complex "Clearing terminal history"

	while true; do
		read -rp "Inform what you want: [ash | bash | zsh | skip] " QUESTION_TERMINAL_HISTORY

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
			*) display_message_value_status_error_simple "Please answer file or partition." ;;
		esac
	done
}

utils_convert_numeric_base_calculator() {
	local MATH_EXPRESSION="$1"
	local FLOAT_POINT_VALUE="0"
	local RESULT

	#echo "$MATH_EXPRESSION" | bc -l
	#printf "%0.${FLOAT_POINT_VALUE}f\n" $(bc -l <<< scale=${FLOAT_POINT_VALUE}\;${MATH_EXPRESSION})
	#printf "%0.${FLOAT_POINT_VALUE}f\n" $(bc -q <<< scale=${FLOAT_POINT_VALUE}\;${MATH_EXPRESSION})
	#display_message_value_number_simple $(bc -l <<< scale=${FLOAT_POINT_VALUE}\;${MATH_EXPRESSION})

	RESULT=$(bc -l <<<scale=${FLOAT_POINT_VALUE}\;"$MATH_EXPRESSION")

	display_message_value_number_simple "$RESULT"
}

utils_convert_numeric_base_from_binary_to_decimal() {
	#utils_convert_numeric_base_from_binary_to_decimal "1001"

	local VALUE_NUMBER="$1"
	local NUMERIC_BASE_INPUT="2"
	local NUMERIC_BASE_OUTPUT="1111"
	local MATH_EXPRESSION="ibase=$NUMERIC_BASE_INPUT;obase=$NUMERIC_BASE_OUTPUT;$VALUE_NUMBER"
	local RESULT

	RESULT=$(utils_convert_numeric_base_calculator "$MATH_EXPRESSION")

	display_message_value_number_simple "$RESULT"
}

utils_convert_numeric_base_from_binary_to_octal() {
	#utils_convert_numeric_base_from_binary_to_octal "111"

	local VALUE_NUMBER="$1"
	local NUMERIC_BASE_INPUT="2"
	local NUMERIC_BASE_OUTPUT="8"
	local MATH_EXPRESSION="ibase=$NUMERIC_BASE_INPUT;obase=$NUMERIC_BASE_OUTPUT;$VALUE_NUMBER"
	local RESULT

	RESULT=$(utils_convert_numeric_base_calculator "$MATH_EXPRESSION")

	display_message_value_number_simple "$RESULT"
}

utils_convert_numeric_base_from_decimal_to_binary() {
	#utils_convert_numeric_base_from_decimal_to_binary "9"

	local VALUE_NUMBER="$1"
	local NUMERIC_BASE_INPUT="10"
	local NUMERIC_BASE_OUTPUT="2"
	local MATH_EXPRESSION="ibase=$NUMERIC_BASE_INPUT;obase=$NUMERIC_BASE_OUTPUT;$VALUE_NUMBER"
	local RESULT

	RESULT=$(utils_convert_numeric_base_calculator "$MATH_EXPRESSION")

	display_message_value_number_simple "$RESULT"
}

utils_convert_numeric_base_from_decimal_to_octal() {
	#utils_convert_numeric_base_from_decimal_to_octal "12"

	local VALUE_NUMBER="$1"
	local NUMERIC_BASE_INPUT="10"
	local NUMERIC_BASE_OUTPUT="8"
	local MATH_EXPRESSION="ibase=$NUMERIC_BASE_INPUT;obase=$NUMERIC_BASE_OUTPUT;$VALUE_NUMBER"
	local RESULT

	RESULT=$(utils_convert_numeric_base_calculator "$MATH_EXPRESSION")

	display_message_value_number_simple "$RESULT"
}

utils_convert_numeric_base_from_octal_to_binary() {
	#utils_convert_numeric_base_from_octal_to_binary "12"

	local VALUE_NUMBER="$1"
	local NUMERIC_BASE_INPUT="8"
	local NUMERIC_BASE_OUTPUT="2"
	local MATH_EXPRESSION="ibase=$NUMERIC_BASE_INPUT;obase=$NUMERIC_BASE_OUTPUT;$VALUE_NUMBER"
	local RESULT

	RESULT=$(utils_convert_numeric_base_calculator "$MATH_EXPRESSION")

	display_message_value_number_simple "$RESULT"
}

utils_convert_numeric_base_from_octal_to_decimal() {
	#utils_convert_numeric_base_from_octal_to_decimal "14"

	local VALUE_NUMBER="$1"
	local NUMERIC_BASE_INPUT="8"
	local NUMERIC_BASE_OUTPUT="1111"
	local MATH_EXPRESSION="ibase=$NUMERIC_BASE_INPUT;obase=$NUMERIC_BASE_OUTPUT;$VALUE_NUMBER"
	local RESULT

	RESULT=$(utils_convert_numeric_base_calculator "$MATH_EXPRESSION")

	display_message_value_number_simple "$RESULT"
}

#@annotation_must_be_tested
utils_convert_pdf_color(){
	local FILE_INPUT="$1"		#./input.pdf
	local FILE_OUTPUT="$2"		#./output.pdf
	local COLOR_ORIGIN="$3"		#black
	local COLOR_DESTINY="$4"	#blue

	magick convert -density 300 "$FILE_INPUT" -fill "$COLOR_DESTINY" -opaque "$COLOR_ORIGIN" "$FILE_OUTPUT"
}

utils_convert_temperature_celsius_to_fahrenheit() {
	#utils_convert_temperature_celsius_to_fahrenheit "100"

	local TEMPERATURE_CELSIUS=$1

	math_calculate "$TEMPERATURE_CELSIUS * 1.8 + 32" "2"
}

utils_convert_temperature_fahrenheit_to_celsius() {
	#utils_convert_temperature_fahrenheit_to_celsius "212"

	local TEMPERATURE_FAHRENHEIT=$1

	math_calculate "($TEMPERATURE_FAHRENHEIT - 32) / 1.8" "2"
}

utils_download_file(){
	local PATH_URL="$1"
	local PATH_DESTINY="$2"

	case $# in
		1)
			display_message_value_status_warning_complex "Downloading $PATH_URL file"
			curl -L -O "$PATH_URL"
			#wget -c $PATH_URL
			display_message_value_status_success_complex "$PATH_URL file has been downloaded"
			;;
		2) 
			display_message_value_status_warning_complex "Downloading $PATH_URL file to $PATH_DESTINY"

			mkdir -p "$PATH_DESTINY/"

			cd "$PATH_DESTINY/" || exit
			pwd
			curl -L -O "$PATH_URL"
			#wget -c "$PATH_URL" -O "$PATH_DESTINY"
			cd - || exit

			display_message_value_status_success_complex "$PATH_URL file has been downloaded to $PATH_DESTINY"
			;;
		*)
			display_message_value_status_error_complex "Invalid parameters have been set"
		;;
	esac
}

utils_download_file_latest_version(){
	#utils_download_file_latest_version "henrikbeck95" "shell_script_library" "shell-script-library"
	
	local REPOSITORY_OWNER="$1"
	local REPOSITORY_NAME="$2"
	local REPOSITORY_FILE=$3
	local RESULT
    
    RESULT=$(utils_generate_link_file_version_latest_github "$REPOSITORY_OWNER" "$REPOSITORY_NAME" "$REPOSITORY_FILE")

    #display_message_value_text_default_complex "Downloading $RESULT file..."
    utils_download_file "$RESULT"
}

utils_download_website(){
    local URL_LINK="$1"

    wget -r -erobots=off "$URL_LINK"
    #wget -r -p -U Mozilla --wait=10 --limit-rate=35K $URL_LINK
}

utils_edit_file(){
	#gedit "$@"
	#nano "$@"
	#vi -O "$@"
	vim -O "$@"
}

utils_effects_spinner(){
    local CHARACTERS_AVALIABLE='/-\|'

    printf ' '

    while true; do
        printf '\b%.1s' "$CHARACTERS_AVALIABLE"
        CHARACTERS_AVALIABLE=${CHARACTERS_AVALIABLE#?}${CHARACTERS_AVALIABLE%???}
    done
}

utils_export_desktop_environment(){
	display_message_value_text_default_simple "$XDG_CURRENT_DESKTOP"
}

utils_export_variables_bios(){
	display_message_value_status_warning_complex "Exporting/loading BIOS variables"

	case $(utils_check_if_firmware_supports_uefi) in
		"false")
			display_message_value_status_warning_complex "Consider enabling the UEFI before keep running this setup installtion. There may be some errors"
			export IS_BIOS_UEFI="legacy"
			;;
		"true")
			export IS_BIOS_UEFI="uefi"
			;;
	esac

	display_message_value_status_warning_complex "Your device BIOS is $IS_BIOS_UEFI"
}

utils_export_variables_virtualization(){
	local IS_VIRTUALIATION
	
	IS_VIRTUALIATION=$(utils_check_if_virtualization_is_enabled)

	if [[ $IS_VIRTUALIATION == "true" ]]; then
		display_message_value_status_warning_complex "I know you are using a virtual machine!"

		export PARTITION_PATH="/dev/vda"
		export PARTITION_BOOT="/dev/vda1"
		export PARTITION_ROOT="/dev/vda2"
		export PARTITION_FILE="/dev/vda3"
		export PARTITION_SWAP="/dev/vda4"

	else
		display_message_value_status_warning_complex "Great! You are installing on your host machine!"

		export PARTITION_PATH="/dev/sda"
		export PARTITION_BOOT="/dev/sda1"
		export PARTITION_ROOT="/dev/sda2"
		export PARTITION_FILE="/dev/sda3"
		export PARTITION_SWAP="/dev/sda4"
	fi
}

utils_extract_file_detect_any() {
	#alias x=utils_extract_file_detect_any
    
	setopt localoptions noautopushd

    if (( $# == 0 )); then
		echo -e "Usage: extract [-option] [file ...]\nOptions:\n-r, --remove    Remove archive after unpacking."
    fi

    local remove_archive=1

    if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
        remove_archive=0
        shift
    fi

    local pwd="$PWD"

    while (( $# > 0 )); do
        if [[ ! -f "$1" ]]; then
            echo "extract: '$1' is not a valid file" >&2
            shift
            continue
        fi

        local success=0
        local extract_dir="${1:t:r}"
        local file="$1" full_path="${1:A}"

        case "${file:l}" in
			(*.7z) utils_extract_file_method_7zip "$file" ;;
			(*.bz2) utils_extract_file_method_bz2 "$file" ;;
			(*.cab) utils_extract_file_method_zip "$extract_dir" "$file" ;;
			(*.cpio) utils_extract_file_method_cpio "$file" ;;
			(*.lz4) utils_extract_file_method_lz4 "$file" ;;
			(*.lzma) utils_extract_file_method_lzma "$file" ;;
			(*.rar) utils_extract_file_method_rar "$file" ;;
			(*.tar) utils_extract_file_method_tar "$file" ;;
			(*.tar.bz2|*.tbz|*.tbz2) utils_extract_file_method_tar_bz2 "$file" ;;
			(*.tar.lz4) utils_extract_file_method_tar_lz4 "$file" ;;
			(*.tar.xz|*.txz) utils_extract_file_method_tar_xz "$file" ;;
			(*.tar.zma|*.tlz) utils_extract_file_method_tar_zma "$file" ;;
			(*.tar.zst|*.tzst) utils_extract_file_method_tar_zst  "$file" ;;
			(*.xz) utils_extract_file_method_xz "$file" ;;
			(*.z) utils_extract_file_method_z "$file" ;;
			(*.zip|*.war|*.jar|*.ear|*.sublime-package|*.ipa|*.ipsw|*.xpi|*.apk|*.aar|*.whl) utils_extract_file_method_zip "$file" "$extract_dir" ;;
			(*.zst) utils_extract_file_method_zst "$file" ;;
            
			(*.gz) (( $+commands[pigz] )) && pigz -dk "$file" || gunzip -k "$file" ;;
			(*.lrz) (( $+commands[lrunzip] )) && lrunzip "$file" ;;
            #(*.tar.gz|*.tgz) (( $+commands[pigz] )) && { pigz -dc "$file" | tar xv } || tar zxvf "$file" ;;
            (*.tar.gz|*.tgz) (( $+commands[pigz] )) && pigz -dc "$file" | tar xv || tar zxvf "$file" ;;
            (*.tar.lz) (( $+commands[lzip] )) && tar xvf "$file" ;;
            (*.tar.lrz) (( $+commands[lrzuntar] )) && lrzuntar "$file" ;;

            (*.rpm)
                command mkdir -p "$extract_dir" && builtin cd -q "$extract_dir" \
                && rpm2cpio "$full_path" | cpio --quiet -id ;;

            (*.deb)
                command mkdir -p "$extract_dir/control" "$extract_dir/data"
                    builtin cd -q "$extract_dir" || exit; ar vx "$full_path" > /dev/null
                    builtin cd -q control || exit; extract ../control.tar.*
                    builtin cd -q ../data || exit; extract ../data.tar.*
                    builtin cd -q .. || exit; command rm ./*.tar.* debian-binary ;;

            (*)
                echo "extract: '$file' cannot be extracted" >&2
                success=1 ;;
        esac

        (( success = success > 0 ? success : $? ))
        (( success == 0 && remove_archive == 0 )) && rm "$full_path"
        shift

        #Go back to original working directory in case we ran cd previously
        builtin cd -q "$pwd" || exit
    done
}

utils_extract_file_method_7zip(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	7za x "$FILE_ORIGIN"

    #Individually 7zip all files in current directory
    #for i in *.*; do
    #    7z a "$i".7z "$i"
    #done
}

utils_extract_file_method_bz2(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	bunzip2 "$FILE_ORIGIN"
}

utils_extract_file_method_cab(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	mkdir -p "$FILE_DESTINY"
	cabextract -d "$FILE_ORIGIN" "$FILE_DESTINY"
}

utils_extract_file_method_cpio(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	cpio -idmvF "$FILE_ORIGIN"
}

utils_extract_file_method_lz4(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	lz4 -d "$FILE_ORIGIN"
}

utils_extract_file_method_lzma(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	unlzma "$FILE_ORIGIN"
}

utils_extract_file_method_rar(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	unrar x -ad "$FILE_ORIGIN"

	#unrar -e ./Aula\ 03\ -\ Program$'\342'$'\225'$'\236'o\ de\ Computadores.rar
	#unrar -e ./Aula\ 03\ -\ Program$'\342'$'\225'$'\236'o\ de\ Computadores.rar .
}

utils_extract_file_method_tar(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	#tar -zxvf $FILE_ORIGIN || tar -xzf $FILE_ORIGIN || tar -xf $FILE_ORIGIN
	tar xvf "$FILE_ORIGIN"
}

utils_extract_file_method_tar_bz2(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	tar xvjf "$FILE_ORIGIN"
}

utils_extract_file_method_tar_lz4(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	lz4 -c -d "$FILE_ORIGIN" | tar xvf -
}

utils_extract_file_method_tar_zst(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	#tar --zstd --help &> /dev/null \
	tar --zstd -xvf "$FILE_ORIGIN" || zstdcat "$FILE_ORIGIN" | tar xvf -
}

utils_extract_file_method_tar_zma(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	#tar --lzma --help &> /dev/null \
	tar --lzma -xvf "$FILE_ORIGIN" || lzcat "$FILE_ORIGIN" | tar xvf -
}

utils_extract_file_method_tar_xz(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	#tar --xz --help &> /dev/null \
	tar --xz -xvf "$FILE_ORIGIN" || xzcat "$FILE_ORIGIN" | tar xvf -
}

utils_extract_file_method_xz(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	unxz "$FILE_ORIGIN"
}

utils_extract_file_method_z(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	uncompress "$FILE_ORIGIN"
}

utils_extract_file_method_zip(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	mkdir -p "$FILE_DESTINY"
	unzip "$FILE_ORIGIN" -d "$FILE_DESTINY"
}

utils_extract_file_method_zst(){
	local FILE_ORIGIN="$1"
	local FILE_DESTINY="$2"

	unzstd "$FILE_ORIGIN"
}

utils_generate_link_file_version_latest_github(){
    #Try: curl -fsSL github.com/henrikbeck95/shell_script_library/releases/latest/download/shell-script-library -O
	#Try: curl -fsSL github.com/${REPOSITORY_OWNER}/${REPOSITORY_NAME}/releases/latest/download/${REPOSITORY_FILE} -O
	#Try: curl -fsSL $(utils_generate_link_file_version_latest_github "henrikbeck95" "shell_script_library" "shell-script-library") -O
	local REPOSITORY_OWNER="$1"
	local REPOSITORY_NAME="$2"
	local REPOSITORY_FILE=$3


	display_message_value_text_default_simple "https://github.com/${REPOSITORY_OWNER}/${REPOSITORY_NAME}/releases/latest/download/${REPOSITORY_FILE}"
}

utils_generate_number_random_from_interval_set(){
    local RANDOM_INTERVAL_BEGIN
    local RANDOM_INTERVAL_FINISH
    local RESULT

    #Check if the arguments values are valid
    if [[ $# -ne 2 ]]; then
        display_message_value_status_error_simple "To generate random number must have two arguments (begin, start) values"
        exit 127
    elif [[ $1 -lt $2 ]]; then
        RANDOM_INTERVAL_BEGIN="$1"
        RANDOM_INTERVAL_FINISH=$(($2 + 1))
    else
        RANDOM_INTERVAL_BEGIN=$(($2 + 1))
        RANDOM_INTERVAL_FINISH="$1"
    fi

    #Generate the random number
    if [[ $1 -eq $2 ]]; then
        RESULT="$1"
    else
		#RESULT=$[($RANDOM % ($RANDOM_INTERVAL_FINISH - $RANDOM_INTERVAL_BEGIN)) + $RANDOM_INTERVAL_BEGIN]
        RESULT="$(( (RANDOM % (RANDOM_INTERVAL_FINISH - RANDOM_INTERVAL_BEGIN)) + RANDOM_INTERVAL_BEGIN ))"
    fi

    display_message_value_number_simple "$RESULT"
}

#@annotation_must_be_improved
utils_get_all_groups() {
	#How to get a list of all groups in Linux
	#/etc/group file stores the details of groups that are present on the system.

	awk -F: '{print $1}' /etc/group || cut -d ":" -f 1 /etc/group
}

#@annotation_must_be_improved
utils_get_all_users() {
	#How to get a list of all users in Linux
	#/etc/passwd stores the details of users that are present on the system.

	awk -F: '{print $1}' /etc/passwd || cut -d ":" -f 1 /etc/passwd
}

utils_get_path_git_project_root(){
    local PATH_FOLDER="$1"

	cd "$PATH_FOLDER" || exit

    case $(utils_check_if_path_is_inside_git_project_anywhere "$PATH_FOLDER") in
        "false")
            display_message_value_status_error_simple "The current path is not part of a Git project"
            ;;
        "true")
                local RESULT
            RESULT="$(git rev-parse --show-toplevel 2>/dev/null)"
            display_message_value_text_default_simple "$RESULT"
            ;;
    esac

	cd - || exit
}

utils_git_repository_clone(){
	local PATH_REPOSITORY_URL="$1"
	local PATH_DIRECTORY_LOCAL="$2"

	display_message_value_status_warning_complex "Cloning $PATH_REPOSITORY_URL Git repository"

	case $# in
		1) 
			utils_path_directory_create "$HOME/eclipse-workspace"
			
			cd "$HOME/eclipse-workspace/" || exit
			git clone "$PATH_REPOSITORY_URL"
			cd - || exit
			;;		
		2) 
			utils_path_directory_create "$PATH_DIRECTORY_LOCAL"
			
			git clone "$PATH_REPOSITORY_URL" "$PATH_DIRECTORY_LOCAL"
			;;
		*) 
	esac

	display_message_value_status_success_complex "$PATH_REPOSITORY_URL Git repository has been cloned"
}

#@annotation_must_be_improved
utils_git_setup_credentials(){
	local USER_EMAIL="$1"
	local USER_NAME="$2"

	display_message_value_status_warning_complex "Setting up Git credentials to $USER_EMAIL - $USER_NAME"

	#Set Git e-mail credential
	git config --global user.email "$USER_EMAIL" #Try: "henrikbeck95@gmail.com"
	
	#Set Git username credential
	git config --global user.name "$USER_NAME" #Try: "Henrik Beck"

	#Store Git credentials to cache file
	#git config --global credential.helper store

	#git pull
	#cat $HOME/.git-credentials | less

	display_message_value_status_success_complex "Git setup credentials has been set to $USER_EMAIL - $USER_NAME"
}

utils_load_operating_system_properties(){
        local OPERATING_SYSTEM_FILES="/etc/os-*"
        
        # shellcheck source=/dev/null
        source "${OPERATING_SYSTEM_FILES}"
}

utils_move_file(){
	local PATH_ORIGIN="$1"
	local PATH_DESTINY="$2"

	mv "$PATH_ORIGIN" "$PATH_DESTINY" #|| mv -avr "$PATH_ORIGIN $PATH_DESTINY"
}

utils_path_directory_create(){
	local PATH_FOLDER="$1"

	display_message_value_status_warning_complex "Creating $PATH_FOLDER folder directory"
	
	if [[ ! -d "$PATH_FOLDER" ]]; then
		mkdir -p "$PATH_FOLDER"
	fi

	display_message_value_status_success_complex "$PATH_FOLDER folder directory has been created"
}

utils_remove_file(){
	local PATH_FILE="$1"

	rm "$PATH_FILE" || rm -f "$PATH_FILE" || rm -fr "$PATH_FILE"
}

utils_screen_size_count_limit_half_characters_horizontal(){
    local SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_MAXIMUM="$1"
	local DISPLAY_TEXT_LENGTH="$2"
    local RESULT=$(((SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_MAXIMUM-DISPLAY_TEXT_LENGTH)/2))

    display_message_value_text_default_simple "$RESULT"
}

utils_screen_size_count_limit_maximum_characters_horizontal(){
    local CHARACTERS_UNITS
    
    CHARACTERS_UNITS=$(tput cols)

    display_message_value_text_default_simple "$CHARACTERS_UNITS"
}

#@annotation_must_be_created
#utils_screen_size_count_limit_maximum_characters_vertical(){}

#CREATE CASE VARIABLE COLOR DOES NOT EXIST, SET DEFAULT VALUE
utils_screen_size_fill_limit_half_characters_horizontal(){
	local CHARACTER_REPETITION="$1"
    local SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF="$2"
    local COLOR_VALUE="$3"
    local i=0

    while [ "$i" -lt "$SCREEN_SIZE_CHARACTERS_UNITS_LIMIT_HALF" ]; do
        #display_message_value_text_default_simple "${CHARACTER_REPETITION}"
        #i=$(($i+1))

	    display_message_value_text_default_simple "${COLOR_VALUE}${CHARACTER_REPETITION}${COLOR_END}"
        i=$((i+1))
    done
}

utils_simulate_typing(){
    #utils_simulate_typing "Welcome to Shell Script Library!"
    
    local DISPLAY_TEXT="$1"

    display_message_value_text_default_complex "$DISPLAY_TEXT" | pv -qL 10
}

utils_symbolic_link_create(){
	local PATH_ORIGIN="$1"
	local PATH_DESTINY="$2"

	display_message_value_status_warning_complex "Creating symbolic link to $PATH_ORIGIN to $PATH_DESTINY"
	
	ln -sf "$PATH_ORIGIN" "$PATH_DESTINY"

	display_message_value_status_success_complex "Symbolic link from $PATH_ORIGIN to $PATH_DESTINY has been created"
}

utils_update_fonts_cache(){
	display_message_value_status_warning_complex "Update cache from $HOME/.fonts/, /usr/share/fonts/ and /usr/local/share/fonts/ fonts pathes"
	
	fc-cache update || fc-cache -f -v

	display_message_value_status_success_complex "Font cache pathes from $HOME/.fonts/, /usr/share/fonts/ and /usr/local/share/fonts/ have been updated"
}