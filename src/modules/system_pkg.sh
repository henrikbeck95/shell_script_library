#############################
#System package manager
#############################

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_default_repository_add() {
    utils_exit_if_user_does_not_have_root_previledges

    display_message_value_status_warning_complex "Adding package manager $* repository"

    case $(utils_check_package_manager) in
    "apk") display_message_value_status_empty_complex ;;
    "apt") display_message_value_status_empty_complex ;;
    "aur") display_message_value_status_empty_complex ;;
    "dnf") display_message_value_status_empty_complex ;;
    "emerge") display_message_value_status_empty_complex ;;
    "pacman") display_message_value_status_empty_complex ;;
    "slackpkg") display_message_value_status_empty_complex ;;
    "yum") display_message_value_status_empty_complex ;;
    "zypper") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "Package manager has not been found." ;;
    esac

    display_message_value_status_success_complex "Package manager $* repository has been added"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_default_repository_remove() {
    utils_exit_if_user_does_not_have_root_previledges

    display_message_value_status_warning_complex "Removing package manager $* repository"

    case $(utils_check_package_manager) in
    "apk") display_message_value_status_empty_complex ;;
    "apt") display_message_value_status_empty_complex ;;
    "aur") display_message_value_status_empty_complex ;;
    "dnf") display_message_value_status_empty_complex ;;
    "emerge") display_message_value_status_empty_complex ;;
    "pacman") display_message_value_status_empty_complex ;;
    "slackpkg") display_message_value_status_empty_complex ;;
    "yum") display_message_value_status_empty_complex ;;
    "zypper") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "Package manager has not been found." ;;
    esac

    display_message_value_status_success_complex "Package manager $* repository has been added"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_default_repository_syncronize() {
    utils_exit_if_user_does_not_have_root_previledges

    #local DEBUG="$1"

    display_message_value_status_warning_complex "Syncronizing package manager repository"

    case $(utils_check_package_manager) in
    "apk")
        case "$DEBUG" in
        "false") apk update ;;
        "true") apk update -y ;;
        esac
        ;;
    "aur")
        case "$DEBUG" in
        #"false") yay -Syu ;;
        #"true") yay -Syu --noconfirm ;;
        "false") paru -Syu ;;
        "true") paru -Syu --noconfirm ;;
        esac
        ;;
    "apt")
        case "$DEBUG" in
        "false") apt-get update ;;
        "true") apt-get update -y ;;
        esac
        ;;
    "dnf")
        case "$DEBUG" in
        "false") dnf update ;;
        "true") dnf update -y ;;
        esac
        ;;
    "emerge") display_message_value_status_empty_complex ;;
    "pacman")
        case "$DEBUG" in
        "false") pacman -Syu ;;
        "true") pacman -Syu --noconfirm ;;
        esac
        ;;
    "slackpkg") display_message_value_status_empty_complex ;;
    "yum")
        case "$DEBUG" in
        "false") yum update ;;
        "true") yum update -y ;;
        esac
        ;;
    "zypper") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "Package manager has not been found." ;;
    esac

    display_message_value_status_success_complex "Package manager repository has been syncronized"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_default_cache_clean() {
    utils_exit_if_user_does_not_have_root_previledges

    display_message_value_status_warning_complex "Cleaning package manager $* cache"

    case $(utils_check_package_manager) in
    "apk") display_message_value_status_empty_complex ;;
    "apt") apt autoremove ;;
    "aur")
        case "$DEBUG" in
        "false") paru -Sc ;;
        "true") paru -Sc -y ;;
        esac
        ;;
    "dnf") display_message_value_status_empty_complex ;;
    "emerge") display_message_value_status_empty_complex ;;
    "pacman")
        case "$DEBUG" in
        "false") pacman -Sc ;;
        "true") pacman -Sc -y ;;
        esac
        ;;
    "slackpkg") display_message_value_status_empty_complex ;;
    "yum")
        case "$DEBUG" in
        "false") yum clean all ;;
        "true") yum clean all -y ;;
        esac
        ;;
    "zypper") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "Package manager has not been found." ;;
    esac

    display_message_value_status_success_complex "Package manager $* cache has been cleaned"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_default_cache_make() {
    utils_exit_if_user_does_not_have_root_previledges

    display_message_value_status_warning_complex "Making package manager $* cache"

    case $(utils_check_package_manager) in
    "apk") display_message_value_status_empty_complex ;;
    "apt") display_message_value_status_empty_complex ;;
    "aur") display_message_value_status_empty_complex ;;
    "dnf") dnf makecache ;;
    "emerge") display_message_value_status_empty_complex ;;
    "pacman") display_message_value_status_empty_complex ;;
    "slackpkg") display_message_value_status_empty_complex ;;
    "yum")
        case "$DEBUG" in
        "false") yum make cache ;;
        "true") yum make cache -y ;;
        esac
        ;;
    "zypper") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "Package manager has not been found." ;;
    esac

    system_pkg_default_repository_syncronize

    display_message_value_status_success_complex "Package manager $* cache has been made"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_default_software_install_group() {
    utils_exit_if_user_does_not_have_root_previledges

    display_message_value_status_warning_complex "Installing package manager (group) $* software(s)"

    case $(utils_check_package_manager) in
    "apk") display_message_value_status_empty_complex ;;
    "apt")
        case $DEBUG in
        "false") apt install --install-suggests "$@" ;;
        "true") apt install -y --install-suggests "$@" ;;
        esac
        ;;
    "aur")
        case "$DEBUG" in
        "false") paru -S --asdeps "$@" ;;
        "true") paru -S --asdeps -y "$@" ;;
        esac
        ;;
    "dnf")
        case $DEBUG in
        "false") dnf group install --with-optional "$@" ;;
        "true") dnf group install -y --with-optional "$@" ;;
        esac
        ;;
    "emerge") display_message_value_status_empty_complex ;;
    "pacman")
        case "$DEBUG" in
        "false") pacman -S --asdeps "$@" ;;
        "true") pacman -S --asdeps -y "$@" ;;
        esac
        ;;
    "slackpkg") display_message_value_status_empty_complex ;;
    "yum")
        case "$DEBUG" in
        "false") yum groupinstall ;;
        "true") yum groupinstall -y ;;
        esac
        ;;
    "zypper") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "Package manager has not been found." ;;
    esac

    display_message_value_status_success_complex "Package manager (group) $* software(s) has/have been installed"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_default_software_install_single() {
    utils_exit_if_user_does_not_have_root_previledges

    display_message_value_status_warning_complex "Installing package manager $* software"

    case $(utils_check_package_manager) in
    "apk")
        case $DEBUG in
        "false") apk add "$@" ;;
        "true") apk add -y "$@" ;;
        esac
        ;;
    "aur")
        case $DEBUG in
        "false") paru -S "$@" ;;
            #"false") paru -S "$@" --needed ;;
        "true") paru -S "$@" --noconfirm ;;
            #"true") paru -S "$@" --noconfirm --needed ;;
        esac
        ;;
    "apt")
        #apt install --fix-broken
        #apt install --fix-missing
        case $DEBUG in
        "false") apt-get install "$@" ;;
        "true") apt-get install -y "$@" ;;
        esac
        ;;
    "dnf")
        case $DEBUG in
        "false") dnf install "$@" ;;
        "true") dnf install -y "$@" ;;
        esac
        ;;
    "emerge") display_message_value_status_empty_complex ;;
    "pacman")
        case $DEBUG in
        "false") pacman -S "$@" ;;
        "true") pacman -S --noconfirm "$@" ;;
            #"true") pacman -S --noconfirm --needed "$@" ;;
        esac
        ;;
    "slackpkg") display_message_value_status_empty_complex ;;
    "yum")
        case "$DEBUG" in
        "false") yum install ;;
        "true") yum install -y ;;
        esac
        ;;
    "zypper") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "Package manager has not been found." ;;
    esac

    display_message_value_status_success_complex "Package manager $* software(s) has/have been installed"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_default_software_list() {
    display_message_value_status_warning_complex "Listing package manager softwares"

    case $(utils_check_package_manager) in
    "apk") apk list ;;
    "apt") apt list || dpkg -l ;; #apt list --upgradable
    "aur") pacman -Qm ;;
    "dnf") rpm -q || rpm -q "$@" ;;
    "emerge") display_message_value_status_empty_complex ;;
    "pacman") pacman -Qn ;;
    "slackpkg") display_message_value_status_empty_complex ;;
    "yum") yum list ;;
    "zypper") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "Package manager has not been found." ;;
    esac
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_default_software_uninstall_group() {
    utils_exit_if_user_does_not_have_root_previledges

    display_message_value_status_warning_complex "Uninstalling package manager $* software"

    case $(utils_check_package_manager) in
    "apk") display_message_value_status_empty_complex ;;
    "aur")
        case $DEBUG in
        #"false") yay -Rns "$@" ;;
        #"true") yay -Rns "$@" --noconfirm ;;
        "false") paru -Rns "$@" ;;
        "true") paru -Rns "$@" --noconfirm ;;
        esac
        ;;
    "apt") display_message_value_status_empty_complex ;;

    #"apt")
        #case $DEBUG in
        #"false") apt install --install-suggests "$@" ;;
        #"true") apt install -y --install-suggests "$@" ;;
        #esac
        #;;

    "dnf") display_message_value_status_empty_complex ;;
    "emerge") display_message_value_status_empty_complex ;;
    "pacman")
        case "$DEBUG" in
        "false") pacman -Rns "$@" ;;
        "true") pacman -Rns -y "$@" ;;
        esac
        ;;
    "slackpkg") display_message_value_status_empty_complex ;;
    "yum")
        case "$DEBUG" in
        "false") yum groupremove ;;
        "true") yum groupremove -y ;;
        esac
        ;;
    "zypper") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "Package manager has not been found." ;;
    esac

    display_message_value_status_success_complex "Package manager $* software(s) has/have been uninstalled"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_default_software_uninstall_single() {
    utils_exit_if_user_does_not_have_root_previledges

    display_message_value_status_warning_complex "Uninstalling package manager $* software"

    case $(utils_check_package_manager) in
    "apk")
        case $DEBUG in
        "false") apk remove "$@" ;;
        "true") apk remove -y "$@" ;;
        esac
        ;;
    "aur")
        case $DEBUG in
        #"false") yay -R "$@" ;;
        #"true") yay -R "$@" --noconfirm ;;
        "false") paru -Rns "$@" ;;
        "true") paru -Rns "$@" --noconfirm ;;
        esac
        ;;
    "apt")
        case $DEBUG in
        "false") apt-get remove "$@" ;;
        "true") apt-get remove -y "$@" ;;
        esac
        ;;
    "dnf")
        case $DEBUG in
        "false") dnf remove "$@" ;;
        "true") dnf remove -y "$@" ;;
        esac
        ;;
    "emerge") display_message_value_status_empty_complex ;;
    "pacman")
        case $DEBUG in
        "false") pacman -Rns "$@" ;;
        "true") pacman -Rns --noconfirm "$@" ;;
            #"true") pacman -R --noconfirm --needed "$@" ;;
        esac
        ;;
    "slackpkg") display_message_value_status_empty_complex ;;
    "yum")
        case "$DEBUG" in
        "false") yum remove ;;
        "true") yum remove -y ;;
        esac
        ;;
    "zypper") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "Package manager has not been found." ;;
    esac

    display_message_value_status_success_complex "Package manager $* software(s) has/have been uninstalled"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
#@annotation_must_be_fixed
system_pkg_default_distro_upgrade(){
    utils_exit_if_user_does_not_have_root_previledges

    display_message_value_status_warning_complex "Upgrading distro version"

    case $(utils_check_package_manager) in
    "apk") display_message_value_status_empty_complex ;;
    "apt") display_message_value_status_empty_complex ;;
    "aur")
        case "$DEBUG" in
        #"false") yay -Syyuu ;;
        #"true") yay -Syyuu --noconfirm ;;
        "false") paru -Syyuu ;;
        "true") paru -Syyuu --noconfirm ;;
        esac
        ;;
    "dnf")
        #Replace repository database
        sudo dnf upgrade
        system_pkg_default_repository_syncronize
        sudo dnf --refresh upgrade
        system_pkg_default_software_install_single dnf-plugin-system-upgrade --best
        
        #Upgrade distro version - Fedora
        #sudo dnf system-upgrade download --refresh --releasever=35
        #sudo dnf system-upgrade download --refresh --releasever=$(rpm -E %fedora) #MUST ADD +1
        sudo dnf system-upgrade download --refresh --releasever=$(($(rpm -E %fedora)+1)) #MUST ADD +1
        ;;
    "emerge") display_message_value_status_empty_complex ;;
    "pacman")
        case "$DEBUG" in
        "false") pacman -Syyuu ;;
        "true") pacman -Syyuu --noconfirm ;;
        esac
        ;;
    "slackpkg") display_message_value_status_empty_complex ;;
    "yum") display_message_value_status_empty_complex ;;
    "zypper") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "Package manager has not been found." ;;
    esac

    display_message_value_status_success_complex "Distro version has been upgraded"
}