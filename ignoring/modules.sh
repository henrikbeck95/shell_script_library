#!/usr/bin/env sh

#############################
#System backup
#############################

#label_must_be_created
system_backup_setup(){
	case $BACKUP_TOOL in
		"btrfk") display_message_empty ;;
		"snapper") 
			#Command line interface (CLI)
			system_package_manager_pacman_software_install \
				snapper
			
			umount /.snapshots/
			rm -fr /.snapshots/
			snapper -c root create-config /

			string_replace_text_from_text_pattern "/etc/snapper/configs/root" 'ALLOW_USERS=""' "ALLOW_USERS=\"$QUESTION_USERNAME\""

			#Change all the limits for timeline cleanup to 0 value
			util_edit_file /etc/snapper/configs/root

			#Create a /boot/ directory backup when Linux kernel gets updated
			echo -e "[Trigger]\nOperation = Upgrade\nOperation = Install\nOperation = Remove\nType = Package\nTarget = linux*\n\n[Action]\nDepends = rsync\nDescription = Backing up /boot/ directory when Linux kernel gets updated\nWhen = PreTransaction\nExec = /usr/bin/rsync -a delete /boot/ /.bootbackup/" > /usr/share/libalpm/hooks/50_bootbackup.hook

			util_edit_file /usr/share/libalpm/hooks/50_bootbackup.hook

			chmod a+rx /.snapshots/

			system_daemon_enable_now snapper-timeline.timer
			system_daemon_enable_now snapper-cleanup.timer
			system_daemon_enable_now grub-btrfs.path

			#reboot
			#snapper -c root list #root = #$USER
			#snapper -c root create -c timeline --description 'After install'
			#snapper -c root list
			#reboot
			#Remove read only
			#snapper -c root create -c timeline --description 'Before GUI'
			#snapper -c root list

			#############################
			#Graphic user interface (GUI)
			#git clone https://aur.archlinux.org/snapper-gui-git.git
			#cd snapper-gui-git/
			#makepkg -si PKGBUILD
			#############################

			#snapper -c root list
			#btrfs property list -ts /.snapshots/$NUMBER/snapshot/ #3
			#btrfs property set -ts /.snapshots/$NUMBER/snapshot/ ro false #3
			;;
		"timeshift") display_message_empty ;;
		*) display_message_empty ;;
	esac
}

#############################
#System disk
#############################

system_disk_generate_fstab(){
	display_message_default "Generate the /etc/fstab file"
	
	genfstab -U /mnt >> /mnt/etc/fstab

	#Check if the /etc/fstab file was generated correctly
	cat /mnt/etc/fstab
}

#############################
#System package manager - DNF
#############################

#label_must_be_fixed
system_package_manager_dnf_operatingSystem_upgrade(){
	util_check_if_user_has_root_previledges

    #Replace repository database
	dnf upgrade
	system_package_manager_dnf_repository_syncronize
	
	dnf upgrade --refresh -y

	system_package_manager_dnf_software_install_single dnf-plugin-system-upgrade --best
	
    #Upgrade distro version - Fedora
	#dnf system-upgrade download --refresh --releasever=35
	#dnf system-upgrade download --refresh --releasever=$(rpm -E %fedora) #MUST ADD +1
	dnf system-upgrade download --refresh --releasever=$(($(rpm -E %fedora)+1)) #MUST ADD +1
}

#############################
#System package manager - Python
#############################

#label_must_be_edited
#label_must_be_improved
system_package_manager_any_python_software_setup(){
    case $PYTHON_PKG in
        "anaconda") 
            cd $HOME/Downloads/
            #Download Anaconda script file
            https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh
            cd -

            #Import Anaconda script file
            bash ~/Downloads/Anaconda3-2021.11-Linux-x86_64.sh
            ;;
        "pip") 
            #Install Python plugin
            system_package_manager_any_asdf_repository_add python
            
            #List all Python plugins available
            system_package_manager_any_asdf_software_list all python

            #Install Python versions
            system_package_manager_any_asdf_software_install python 3.6-dev
            system_package_manager_any_asdf_software_install python 3.6.0
            system_package_manager_any_asdf_software_install python 3.9.2

            #Set Python environment
            asdf global python 3.9.2
            cd ~/Documents/voice_assistant_linux/ && asdf local python 3.6-dev #Your current working directory

            #Check if Python version
            python --version
        *) display_message_error "No Python package manager has been defined" ;;
    esac

    display_message_success "Python $PYTHON_PKG package manager setup has been installed"
}

#############################
#System package manager - AUR
#############################

system_package_manager_aur_software_setup(){
	display_message_default "Install ArchLinux - AUR setup"
	
    #Paru
	util_path_directory_create $HOME/compilation/
	git clone https://aur.archlinux.org/paru.git $HOME/compilation/paru

	cd $HOME/compilation/paru/
	makepkg -si
	cd -

	display_message_default "ArchLinux - AUR setup has been installed"
}

#############################
#Utilities
#############################

#util_change_shell_user(){}
#util_change_shell_root(){}

util_ask_username(){
    while true; do
        read -p "Inform the username: " QUESTION_USERNAME #henrikbeck95

        case $QUESTION_USERNAME in
            "") echo "Please answer your username." ;;
            *) break ;;
        esac
    done
}

util_change_hostname_label(){
	display_message_default "Change the hostname"

	#Applying the hostname to /etc/hostname file
	read -p "Inform the hostname you want: " QUESTION_HOST #biomachine
	echo "$QUESTION_HOST" > /etc/hostname #biomachine

	#Applying the hostname to /etc/hosts file
	echo -e "
	127.0.0.1\t\tlocalhost
	::1\t\t\tlocalhost
	127.0.0.1\t\t$QUESTION_HOST.localdomain\t\t$QUESTION_HOST" >> /etc/hosts
}

util_change_language_keyboard_default(){
	display_message_default "Changing the keyboard layout to Brazilian Portuguese keymap"
    
	case $NAME in
        "Alpine") : ;;
        "Arch Linux")
			display_message_default "Changing for Brazilian Portuguese keymap"

			#Uncomment the line: # pt_BR.UTF-8 UTF-8
			string_replace_text_from_text_pattern "/etc/locale.gen" "#pt_BR.UTF-8 UTF-8" "pt_BR.UTF-8 UTF-8"

			#Apply the new settings
			export LANG=pt_BR.UTF-8
			;;
        "CentOS Linux" | "Fedora") : ;; #Native installed
        *) display_message_error "" ;;
    esac

	display_message_success "Keyboard layout has been changed to Brazilian Portuguese keymap"
}

util_change_language_keyboard_definitive(){
	display_message_default "Change the language"

	#util_edit_file /etc/locale.gen #Uncomment the pt_BR.UTF-8 UTF-8 line
	locale-gen
	
	echo LANG=en_US.UTF-8 >> /etc/locale.conf
	#echo LANG=pt_BR.UTF-8 >> /etc/locale.conf

	echo KEYMAP=br-abnt2 >> /etc/vconsole.conf
}

util_change_language_keyboard_temporary(){
	display_message_default "Changing the keyboard layout settings"
    
	case $NAME in
        "Alpine") loadkeys setxkbmap -model abnt2 -layout br ;;
        "Arch Linux") loadkeys br-abnt2 ;;
        "CentOS Linux" | "Fedora") : ;; #Native installed
        *) display_message_error "" ;;
    esac

	display_message_success "Keyboard layout has been changed"
}

util_change_password_root(){
	display_message_default "Change the root password"

	passwd
}

util_change_timezone(){
	display_message_default "Search for UTC time zone"
	timedatectl list-timezones | grep Sao_Paulo
	
	display_message_default "Apply the UTC time zone"
	ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
	
	display_message_default "Sync UTC clock with the hardware machine"
	hwclock --systohc --utc #UTC clock

	#timedatectl set-ntp true
	#hwclock --systohc #Hardware clock
}

#label_must_be_tested
util_connect_network_wifi_iwctl(){
	display_message_default "Connect to Wi-Fi network"

	while true; do
		read -p "Inform what you want (when finish type skip): [iwctl/terminal/skip] " QUESTION_WIFI_METHOD

		case $QUESTION_WIFI_METHOD in
			"iwctl")
                display_message_warning "iwctl Wi-Fi connect\n\n> #device list\n> #station wlan0 scan\n> #station wlan0 get-networks\n> #station wlan0 connect <wireless network name>\n> #exit"

        	    iwctl
				;;
            "terminal")
                #Unblock driver
                rfkill list
                rfkill unblock wifi

                #Iwd commands
                #iwctl device list
                #iwctl station list
                iwtcl device wlan0 set-property Powered on
                iwctl station wlan0 scan
                iwctl station wlan0 get-networks

		        read -p "Inform the Wi-Fi network name you want to connect: " QUESTION_WIFI_NAME
                iwctl station wlan0 connect $QUESTION_WIFI_NAME
				;;
			"skip") break ;;
			*) echo "Please answer question." ;;
		esac

		#Testing the network connection
	    ping -c 3 archlinux.org
	done
}

util_fonts_download(){
	local PATH_DIRECTORY_FONTS="$1"
	local PATH_DIRECTORY_TMP="/tmp/the_fonts"

	#Download the files
	#util_download_file https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip "$PATH_DIRECTORY_TMP"
	util_download_file "https://github.com/ryanoasis/nerd-fonts/releases/download/2.2.0-RC/FiraCode.zip" "$PATH_DIRECTORY_TMP"
	util_download_file "https://github.com/ryanoasis/nerd-fonts/releases/download/2.2.0-RC/LiberationMono.zip" "$PATH_DIRECTORY_TMP"
	util_download_file "https://github.com/ryanoasis/nerd-fonts/releases/download/2.2.0-RC/Hack.zip" "$PATH_DIRECTORY_TMP"
	util_download_file "https://github.com/ryanoasis/nerd-fonts/releases/download/2.2.0-RC/Meslo.zip" "$PATH_DIRECTORY_TMP"

	#Extract files
	util_extract_file_zip "$PATH_DIRECTORY_TMP/FiraCode.zip" "$PATH_DIRECTORY_FONTS/FiraCode"
	util_extract_file_zip "$PATH_DIRECTORY_TMP/LiberationMono.zip" "$PATH_DIRECTORY_FONTS/LiberationMono"
	util_extract_file_zip "$PATH_DIRECTORY_TMP/Hack.zip" "$PATH_DIRECTORY_FONTS/Hack"
	util_extract_file_zip "$PATH_DIRECTORY_TMP/Meslo.zip" "$PATH_DIRECTORY_FONTS/Meslo"

	#Remove temporary folder
	rf -fr $PATH_DIRECTORY_TMP/

	#Update the fonts cache
	util_fonts_cache_update
}

util_user_add_to_groups(){
	util_check_if_user_has_root_previledges
	
	#Add user to groups
	gpasswd -a $QUESTION_USERNAME audio || adduser $QUESTION_USERNAME audio
	gpasswd -a $QUESTION_USERNAME daemon || adduser $QUESTION_USERNAME daemon
	gpasswd -a $QUESTION_USERNAME dbus || adduser $QUESTION_USERNAME dbus
	gpasswd -a $QUESTION_USERNAME disk || adduser $QUESTION_USERNAME disk
	gpasswd -a $QUESTION_USERNAME games || adduser $QUESTION_USERNAME games
	gpasswd -a $QUESTION_USERNAME lp || adduser $QUESTION_USERNAME lp
	gpasswd -a $QUESTION_USERNAME network || adduser $QUESTION_USERNAME network
	gpasswd -a $QUESTION_USERNAME optical || adduser $QUESTION_USERNAME optical
	gpasswd -a $QUESTION_USERNAME power || adduser $QUESTION_USERNAME power
	gpasswd -a $QUESTION_USERNAME rfkill || adduser $QUESTION_USERNAME rfkill
	gpasswd -a $QUESTION_USERNAME scanner || adduser $QUESTION_USERNAME scanner
	gpasswd -a $QUESTION_USERNAME storage || adduser $QUESTION_USERNAME storage
	gpasswd -a $QUESTION_USERNAME users || adduser $QUESTION_USERNAME users
	gpasswd -a $QUESTION_USERNAME vboxsf || adduser $QUESTION_USERNAME vboxsf
	gpasswd -a $QUESTION_USERNAME video || adduser $QUESTION_USERNAME video
	gpasswd -a $QUESTION_USERNAME wheel || adduser $QUESTION_USERNAME wheel

	#VirtualBox shared folder
	#usermod -aG vboxsf $QUESTION_USERNAME
	#chown -R $QUESTION_USERNAME:$QUESTION_USERNAME /home/$QUESTION_USERNAME/shared/
	
	visudo
}

#label_must_be_tested
util_user_add_to_whell_group(){
	display_message_default "Setting the Vim as the default text editor and also edit the visudo file"

	#Uncomment the line: # %wheel ALL=(ALL) ALL
	string_replace_text_from_text_pattern "/etc/sudoers" "# %wheel ALL=(ALL) ALL" "%wheel ALL=(ALL) ALL"
	#echo "ermanno ALL=(ALL) ALL" >> /etc/sudoers.d/ermanno

	EDITOR=vim visudo
}

#label_must_be_tested
#label_must_be_improved
#label_must_be_edited
util_user_create(){
	utils_exit_if_user_does_not_have_root_previledges

	display_message_default "Create a new user account to be ready to log in after the installation setup is done"

	case $NAME in
		"Alpine") 
			#util_edit_file /etc/apk/repositories
			adduser -g "$QUESTION_FULL_NAME" $QUESTION_USERNAME
			passwd $QUESTION_USERNAME
		 ;;
		
		"Arch Linux") 
			useradd -mG wheel $QUESTION_USERNAME
			passwd $QUESTION_USERNAME
		;;

		"CentOS Linux" | "Fedora") display_message_empty ;;
		*) display_message_error "" ;;
	esac
	
	util_user_add_to_groups

	display_message_success "User $QUESTION_USERNAME has been created successfully"
}

#############################
#System package manager - Essentials
#############################

system_package_manager_essentials_aur() {
	system_package_manager_aur_software_install \
		davinci-resolve \
		google-chrome \
		ffmpeg-full \
		nerd-fonts-complete \
		ntfs3-dkms \
		nvm \
		proton \
		qt5-styleplugins \
		spotify-adblock \
		spotirec \
		timeshift \
		ttf-ms-fonts
}

system_package_manager_essentials_flatpak() {
	system_package_manager_any_flatpak_software_install flathub com.spotify.Client
	system_package_manager_any_flatpak_software_install flathub org.gnome.Extensions
	system_package_manager_any_flatpak_software_install flathub uk.co.powdertoy.tpt
	system_package_manager_any_flatpak_software_install flathub org.musicbrainz.Picard
	system_package_manager_any_flatpak_software_install flathub org.kde.gwenview
}

#############################
#System package manager - Platforms
#############################

#label_must_be_tested
#MUST BE IMPLEMENTED SED CUT FUNCTION
system_package_manager_platform_conection_ssh(){
	display_message_default "Installing SSH connect support"
		
	system_package_manager_pacman_software_install \
		openssh

	system_daemon_enable_now sshd.service

	util_edit_file /etc/ssh/sshd_config #Uncomment the port 22
	
	display_message_default "Change Root password"
	passwd root
	
	display_message_default "Get the ip address"
	ip addr
	
	display_message_default "Auxiliar machine\n	
	For rightly configuring the another PC with Linux, follow the steps below:
	
	$ sudo apt install openssh-client
	$ ssh -l <username> <ip_address>
	or $ ssh root@<ip_address>
	or $ ssh-keygen -f \"/home/your_user/.ssh/known_hosts\" -R \"192.168.1.221\""
}

system_package_manager_platform_container_ask(){
    util_check_if_user_has_root_previledges

	display_message_default "Install $CONTAINER_MANAGER $@ platform"

    while true; do
        read -p "Inform what you want: [docker | podman | skip] " QUESTION_CONTAINER_MANAGER

        #case $CONTAINER_MANAGER in
        case $QUESTION_CONTAINER_MANAGER in
            "docker")
                system_package_manager_platform_container_docker
                break
                ;;
            "podman")
                system_package_manager_platform_container_podman
                break
                ;;
            "skip") break ;;
            *) echo "Please answer file or partition." ;;
        esac
    done

	display_message_success "$CONTAINER_MANAGER $@ platform has been installed"
}

system_package_manager_platform_container_dockerCompose(){
    util_check_if_user_has_root_previledges
    
    case $NAME in
        "Alpine") display_message_empty ;;
        "Arch Linux")
            #Podman Docker-compose
            podman --version
            system_package_manager_pacman_software_install podman-docker docker-compose
            
            system_daemon_restart podman.socket
            system_daemon_status podman.socket

            curl -H "Content-Type: application/json" --unix-socket /var/run/docker.sock http://localhost/_ping
            ls -lah /var/run/dock*
            ;;
        "CentOS Linux" | "Fedora") display_message_empty ;;
        *) display_message_error "" ;;
    esac
}






#label_must_be_fixed
system_package_manager_platform_driver_audio(){
    util_check_if_user_has_root_previledges
    
	while true; do
		read -p "Inform what you want: [alsa | pipewire | pulseaudio | none] " QUESTION_DRIVER_AUDIO

		case $QUESTION_DRIVER_AUDIO in
			"alsa")
				system_pkg_default_software_install_platform_alsa
				break
				;;
			"pipewire")
				system_pkg_default_software_install_platform_pipewire
                break
				;;
			"pulseaudio")
				system_pkg_default_software_install_platform_pulseaudio
				break
				;;
			"none") break ;;
			*) echo "Please answer question." ;;
		esac
	done
}

system_package_manager_platform_driver_displayServer(){
    util_check_if_user_has_root_previledges
    
	display_message_default "Install display server"

	while true; do
		read -p "Inform what you want: [wayland | xorg | none] " QUESTION_DISPLAY_SERVER

		case $QUESTION_DISPLAY_SERVER in
			"wayland")
				system_pkg_default_software_install_platform_wayland
				break
				;;
			"xorg")
				system_pkg_default_software_install_platform_xorg
				break
				;;
			"none") break ;;
			*) echo "Please answer question." ;;
		esac
	done
}

#label_operating_system
system_package_manager_platform_driver_graphicVideo(){
    util_check_if_user_has_root_previledges
    
	#MUST CHECK IF IT IS A VM

	display_message_default "Install video driver"

    display_message_default "Install video driver for VirtualBox virtual machine video driver"
	system_pkg_default_software_install_platform_virtualbox

    display_message_default "Install video driver for VMWare virtual machine video driver"
	system_pkg_default_software_install_platform_vmware

    display_message_default "Install video driver for X Window System QXL driver including Xspice server for virtual machine"
	system_pkg_default_software_install_platform_qxl

	while true; do
        #Select the option according to your graphic video manufacturer.
        lspci | grep -e VGA -e 3D

		read -p "Inform what you want: [amd | intel | nvidia | none] " QUESTION_GRAPHIC_VIDEO

		case $QUESTION_GRAPHIC_VIDEO in
			"amd")
				system_pkg_default_software_install_platform_amd
				break
				;;
			"intel")
				system_pkg_default_software_install_platform_intel
				break
				;;
			"nvidia")
				system_pkg_default_software_install_platform_nvidia
				break
				;;
			"none") break ;;
			*) echo "Please answer question." ;;
		esac
	done
}

#ONLY ARCHLINUX IS SET SO FAR
#label_operating_system
system_package_manager_platform_desktopEnviroment_alternativeLockScreen(){
	display_message_default "Install lock screen"

	while true; do
		read -p "Inform what you want: [lightdm/ly/none] " QUESTION_LOCK_SCREEN

		case $QUESTION_LOCK_SCREEN in
			"lightdm")
                system_pkg_default_software_install_platform_lightdm
				break
				;;
            "ly")
                system_pkg_default_software_install_platform_ly
				break
				;;
			"none") break ;;
			*) echo "Please answer question." ;;
		esac
	done

	display_message_warning "$MESSAGE_RESTART"
}

#label_operating_system
system_package_manager_platform_desktopEnviroment_ask(){
	display_message_default "Install desktop environment"

	while true; do
		read -p "Inform what you want: [deepin/gnome/i3/kde/xfce/none] " QUESTION_DESKTOP_ENVIRONMENT

		case $QUESTION_DESKTOP_ENVIRONMENT in
			"deepin")
				system_package_manager_platform_desktopEnviroment_deepin
				break
				;;
            "gnome")
				system_package_manager_desktopEnviroment_gnome
				break
				;;
			"i3")
				system_package_manager_desktopEnviroment_i3
				break
				;;
			"kde")
				system_package_manager_desktopEnviroment_kde
				break
				;;
			"xfce")
				system_package_manager_desktopEnviroment_xfce
				break
				;;
			"none") break ;;
			*) echo "Please answer question." ;;
		esac
	done
}

#label_must_be_fixed
system_package_manager_platform_repository_pacmanEnable32Bits(){
	display_message_default "Enable 32 bits support"

	while true; do
		read -p "Do you want to enable 32 bits support? [Y/n] " QUESTION_PARTITION
		case $QUESTION_PARTITION in
			[Yy]*)
				local PATH_REPOSITORY="/etc/pacman.conf"

				#############################
				#Multilib module
				#############################

				#local CONTENT_LINE_STRING_CURRENT="#\[multilib]"
				local CONTENT_LINE_STRING_CURRENT="#\[testing]"
				local CONTENT_LINE_NUMBER_CURRENT=$(cat $PATH_REPOSITORY | grep -n "$CONTENT_LINE_STRING_CURRENT" | awk -F: '{print $1}')
				local CONTENT_LINE_NUMBER_BELOW=$(($CONTENT_LINE_NUMBER_CURRENT+1))

				#Uncomment the match+1 line
				display_message_warning "Editing module Multilib"
				string_replace_text_from_text_pattern "$PATH_REPOSITORY" "$CONTENT_LINE_STRING_CURRENT" "[multilib]"
				string_replace_text_from_number_line "$PATH_REPOSITORY" "$CONTENT_LINE_NUMBER_BELOW" "Include = \/etc\/pacman.d\/mirrorlist"

				unset $CONTENT_LINE_STRING_CURRENT
				unset $CONTENT_LINE_NUMBER_CURRENT
				unset $CONTENT_LINE_NUMBER_BELOW

				#############################
				#Multilib-testing module
				#############################

				local CONTENT_LINE_STRING_CURRENT="#\[multilib-testing]"
				local CONTENT_LINE_NUMBER_CURRENT=$(cat $PATH_REPOSITORY | grep -n "$CONTENT_LINE_STRING_CURRENT" | awk -F: '{print $1}')
				local CONTENT_LINE_NUMBER_BELOW=$(($CONTENT_LINE_NUMBER_CURRENT+1))

				#Uncomment the match+1 line
				display_message_warning "Editing module Multilib-Testing"
				string_replace_text_from_text_pattern "$PATH_REPOSITORY" "$CONTENT_LINE_STRING_CURRENT" "[multilib-testing]"
				string_replace_text_from_number_line "$PATH_REPOSITORY" "$CONTENT_LINE_NUMBER_BELOW" "Include = \/etc\/pacman.d\/mirrorlist"

				unset $CONTENT_LINE_STRING_CURRENT
				unset $CONTENT_LINE_NUMBER_CURRENT
				unset $CONTENT_LINE_NUMBER_BELOW

				#############################
				#Verify if file has been created correctly
				#############################

				util_edit_file $FILENAME
				break
				;;
			[Nn]*) break ;;
			*) echo "Please answer Y for yes or N for no." ;;
		esac
	done
}

system_package_manager_platform_virtualMachine_ask(){
    display_message_default "Install virtual machine platform"

    while true; do
    read -p "Inform what you want: [virt-manager | virtual-box | skip] " QUESTION_VIRTUAL_MACHINE

        case $QUESTION_VIRTUAL_MACHINE in
            "virt-manager")
                system_pkg_default_software_install_platform_virtmanager
                break
                ;;
            "virtual-box")
                system_pkg_default_software_install_platform_virtualbox
                break
                ;;
            "skip") break ;;
            *) echo "Please answer file or partition." ;;
        esac
    done

	display_message_success "Virtual machine platform has been installed"
}