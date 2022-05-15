#############################
#System package manager
#############################

#label_must_be_tested
#label_must_be_improved
system_pkg_check_package_manager(){
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

#label_must_be_tested
#label_must_be_improved
system_pkg_default_repository_add(){
    utils_check_if_user_has_root_previledges

    display_message_warning_complex "Adding package manager $@ repository"

    case $(system_pkg_check_package_manager) in
        "apk") display_message_empty_complex ;;
        "apt") display_message_empty_complex ;;
        "aur") display_message_empty_complex ;;
        "dnf") display_message_empty_complex ;;
        "emerge") display_message_empty_complex ;;
        "pacman") display_message_empty_complex ;;
        "slackpkg") display_message_empty_complex ;;
        "yum") display_message_empty_complex ;;
        "zypper") display_message_empty_complex ;;
        *) display_message_error_complex "Package manager has not been found." ;;
    esac

	display_message_success_complex "Package manager $@ repository has been added"
}

#label_must_be_tested
#label_must_be_improved
system_pkg_default_repository_remove(){
    utils_check_if_user_has_root_previledges

    display_message_warning_complex "Removing package manager $@ repository"

    case $(system_pkg_check_package_manager) in
        "apk") display_message_empty_complex ;;
        "apt") display_message_empty_complex ;;
        "aur") display_message_empty_complex ;;
        "dnf") display_message_empty_complex ;;
        "emerge") display_message_empty_complex ;;
        "pacman") display_message_empty_complex ;;
        "slackpkg") display_message_empty_complex ;;
        "yum") display_message_empty_complex ;;
        "zypper") display_message_empty_complex ;;
        *) display_message_error_complex "Package manager has not been found." ;;
    esac

	display_message_success_complex "Package manager $@ repository has been added"
}

#label_must_be_tested
#label_must_be_improved
system_pkg_default_repository_syncronize(){
    utils_check_if_user_has_root_previledges

	display_message_warning_complex "Syncronizing package manager $@ repository"

    case $(system_pkg_check_package_manager) in
        "apk")
            case $DEBUG in
                "false") apk update ;;
                "true") apk update -y ;;
            esac
            ;;
        "aur")
            case $DEBUG in
                #"false") yay -Syyuu ;;
                #"true") yay -Syyuu --noconfirm ;;
                "false") paru -Syyuu ;;
                "true") paru -Syyuu --noconfirm ;;
            esac
            ;;
        "apt")
            case $DEBUG in
                "false") apt update ;;
                "true") apt update -y ;;
            esac
            ;;
        "dnf")
            case $DEBUG in
                "false") dnf update ;;
                "true") dnf update -y ;;
            esac
            ;;
        "emerge") display_message_empty_complex ;;
        "pacman")
            case $DEBUG in
                "false") pacman -Syyuu ;;
                "true") pacman -Syyuu --noconfirm ;;
            esac
            ;;
        "slackpkg") display_message_empty_complex ;;
        "yum") display_message_empty_complex ;;
        "zypper") display_message_empty_complex ;;
        *) display_message_error_complex "Package manager has not been found." ;;
    esac

	display_message_success_complex "Package manager $@ repository has been syncronized"
}

#label_must_be_tested
#label_must_be_improved
system_pkg_default_cache_clean(){
    utils_check_if_user_has_root_previledges

    display_message_warning_complex "Cleaning package manager $@ cache"

    case $(system_pkg_check_package_manager) in
        "apk") display_message_empty_complex ;;
        "apt") apt autoremove ;;
        "aur") display_message_empty_complex ;;
        "dnf") display_message_empty_complex ;;
        "emerge") display_message_empty_complex ;;
        "pacman") display_message_empty_complex ;;
        "slackpkg") display_message_empty_complex ;;
        "yum") display_message_empty_complex ;;
        "zypper") display_message_empty_complex ;;
        *) display_message_error_complex "Package manager has not been found." ;;
    esac

	display_message_success_complex "Package manager $@ cache has been cleaned"
}

#label_must_be_tested
#label_must_be_improved
system_pkg_default_cache_make(){
    utils_check_if_user_has_root_previledges

	display_message_warning_complex "Making package manager $@ cache"

    case $(system_pkg_check_package_manager) in
        "apk") display_message_empty_complex ;;
        "apt") display_message_empty_complex ;;
        "aur") display_message_empty_complex ;;
        "dnf") dnf makecache ;;
        "emerge") display_message_empty_complex ;;
        "pacman") display_message_empty_complex ;;
        "slackpkg") display_message_empty_complex ;;
        "yum") display_message_empty_complex ;;
        "zypper") display_message_empty_complex ;;
        *) display_message_error_complex "Package manager has not been found." ;;
    esac
	
    display_message_success_complex "Package manager $@ cache has been made"
}

#label_must_be_tested
#label_must_be_improved
system_pkg_default_software_install_group(){
    utils_check_if_user_has_root_previledges

    display_message_warning_complex "Installing package manager (group) $@ software(s)"

    case $(system_pkg_check_package_manager) in
        "apk") display_message_empty_complex ;;
        "apt") display_message_empty_complex ;;
        "aur") display_message_empty_complex ;;
        "dnf")
            case $DEBUG in
                "false") dnf group install --with-optional $@ ;;
                "true") dnf group install -y --with-optional $@ ;;
            esac
            ;;
        "emerge") display_message_empty_complex ;;
        "pacman") display_message_empty_complex ;;
        "slackpkg") display_message_empty_complex ;;
        "yum") display_message_empty_complex ;;
        "zypper") display_message_empty_complex ;;
        *) display_message_error_complex "Package manager has not been found." ;;
    esac

	display_message_success_complex "Package manager (group) $@ software(s) has/have been installed"
}

#label_must_be_tested
#label_must_be_improved
system_pkg_default_software_install_single(){
    utils_check_if_user_has_root_previledges
    
	display_message_warning_complex "Installing package manager $@ software"

    case $(system_pkg_check_package_manager) in
        "apk")
            case $DEBUG in
                "false") apk add $@ ;;
                "true") apk add -y $@ ;;
            esac
            ;;
        "aur")
            case $DEBUG in
                "false") paru -S $@ ;;
                #"false") paru -S $@ --needed ;;
                "true") paru -S $@ --noconfirm ;;
                #"true") paru -S $@ --noconfirm --needed ;;
            esac
            ;;
        "apt")
            #apt install --fix-broken
	        #apt install --fix-missing
            case $DEBUG in
                "false") apt-get install $@ ;;
                "true") apt-get install -y $@ ;;
            esac
            ;;
        "dnf")
            case $DEBUG in
                "false") dnf install $@ ;;
                "true") dnf install -y $@ ;;
            esac
            ;;
        "emerge") display_message_empty_complex ;;
        "pacman")
            case $DEBUG in
                "false") pacman -S $@ ;;
                "true") pacman -S --noconfirm $@ ;;
                #"true") pacman -S --noconfirm --needed $@ ;;
            esac
            ;;
        "slackpkg") display_message_empty_complex ;;
        "yum") display_message_empty_complex ;;
        "zypper") display_message_empty_complex ;;
        *) display_message_error_complex "Package manager has not been found." ;;
    esac

	display_message_success_complex "Package manager $@ software(s) has/have been installed"
}

#label_must_be_tested
#label_must_be_improved
system_pkg_default_software_list(){
	display_message_warning_complex "Listing package manager softwares"

    case $(system_pkg_check_package_manager) in
        "apk") apl list ;;
        "apt") apt list ;; #apt list --upgradable
        "aur") pacman -Qm ;;
        "dnf") rpm -q || rpm -q $@ ;;
        "emerge") display_message_empty_complex ;;
        "pacman") pacman -Qn ;;
        "slackpkg") display_message_empty_complex ;;
        "yum") display_message_empty_complex ;;
        "zypper") display_message_empty_complex ;;
        *) display_message_error_complex "Package manager has not been found." ;;
    esac
}

#label_must_be_tested
#label_must_be_improved
system_pkg_default_software_setup(){
    utils_check_if_user_has_root_previledges

    display_message_warning_complex "Installing package manager setup"

    case $(system_pkg_check_package_manager) in
        "apk") display_message_empty_complex ;;
        "apt") display_message_empty_complex ;;
        "aur")
            #Installing Paru
            utils_path_directory_create "$HOME/compilation/"
            git clone https://aur.archlinux.org/paru.git $HOME/compilation/paru

            cd $HOME/compilation/paru/
            makepkg -si
            cd -
            ;;
        "dnf") display_message_empty_complex ;;
        "emerge") display_message_empty_complex ;;
        "pacman") display_message_empty_complex ;;
        "slackpkg") display_message_empty_complex ;;
        "yum") display_message_empty_complex ;;
        "zypper") display_message_empty_complex ;;
        *) display_message_error_complex "Package manager has not been found." ;;
    esac

	display_message_success_complex "Package manager setup has been installed"
}

#label_must_be_tested
#label_must_be_improved
system_pkg_default_software_uninstall_group(){
    utils_check_if_user_has_root_previledges

	display_message_warning_complex "Uninstalling package manager $@ software"

    case $(system_pkg_check_package_manager) in
        "apk") display_message_empty_complex ;;
        "aur") display_message_empty_complex ;;
        "apt") display_message_empty_complex ;;
        "dnf") display_message_empty_complex ;;
        "emerge") display_message_empty_complex ;;
        "pacman") display_message_empty_complex ;;
        "slackpkg") display_message_empty_complex ;;
        "yum") display_message_empty_complex ;;
        "zypper") display_message_empty_complex ;;
        *) display_message_error_complex "Package manager has not been found." ;;
    esac

	display_message_success_complex "Package manager $@ software(s) has/have been uninstalled"
}

#label_must_be_tested
#label_must_be_improved
system_pkg_default_software_uninstall_single(){
    utils_check_if_user_has_root_previledges

	display_message_warning_complex "Uninstalling package manager $@ software"

    case $(system_pkg_check_package_manager) in
        "apk")
            case $DEBUG in
                "false") apk remove $@ ;;
                "true") apk remove -y $@ ;;
            esac
            ;;
        "aur")
            case $DEBUG in
                #"false") yay -Rns $@ ;;
                #"true") yay -Rns $@ --noconfirm ;;
                "false") paru -Rns $@ ;;
                "true") paru -Rns $@ --noconfirm ;;
            esac
            ;;
        "apt")
            case $DEBUG in
                "false") apt remove $@ ;;
                "true") apt remove -y $@ ;;
            esac
            ;;
        "dnf")
            case $DEBUG in
                "false") dnf remove $@ ;;
                "true") dnf remove -y $@ ;;
            esac
            ;;
        "emerge") display_message_empty_complex ;;
        "pacman")
            case $DEBUG in
                "false") pacman -Rns $@ ;;
                "true") pacman -Rns --noconfirm $@ ;;
                #"true") pacman -Rns --noconfirm --needed $@ ;;
            esac
            ;;
        "slackpkg") display_message_empty_complex ;;
        "yum") display_message_empty_complex ;;
        "zypper") display_message_empty_complex ;;
        *) display_message_error_complex "Package manager has not been found." ;;
    esac

	display_message_success_complex "Package manager $@ software(s) has/have been uninstalled"
}