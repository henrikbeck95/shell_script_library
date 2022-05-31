#############################
#System package manager install default combo
#############################

#@annotation_must_be_improved
system_pkg_default_software_install_combo_repository_free() {
    display_message_value_status_warning_complex "Installing combo free repositories"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux") display_message_value_status_empty_complex ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora")
        #Add RedHat Package Manager Fusion free repository
        system_pkg_default_software_install_single \
            "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
            "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

        #system_pkg_default_software_install_single \
        #"https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"

        #sudo dnf groupupdate core
        #sudo dnf groupupdate Multimedia
        ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    system_pkg_default_repository_syncronize

    display_message_value_status_success_complex "Combo free repositories has been installed"
}

#@annotation_must_be_improved
system_pkg_default_software_install_combo_repository_nonfree() {
    display_message_value_status_warning_complex "Installing combo non-free repositories"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux") display_message_value_status_empty_complex ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora")
        #Add RedHat Package Manager Fusion non-free repository
        system_pkg_default_software_install_single --nogpgcheck "http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

        #system_pkg_default_software_install_single \
        #https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    system_pkg_default_repository_syncronize

    display_message_value_status_success_complex "Combo non-free repositories has been installed"
}

#@annotation_must_be_improved
system_pkg_default_software_install_combo_battery() {
    display_message_value_status_warning_complex "Installing combo for battery performance improvement"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single "acpi" "acpi_call" "acpid" "tlp"
        system_daemon_enable_later "acpid"
        system_daemon_enable_later "tlp" #Improve battery life for laptop.
        ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") display_message_value_status_empty_complex ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "Combo for battery performance improvement has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_combo_essential() {
    display_message_value_status_warning_complex "Installing combo for essential softwares"

    case $(utils_check_operating_system_name) in
    "alpine")
        system_pkg_default_software_install_single \
            alpine-sdk \
            curl \
            htop \
            less \
            less-doc \
            libuser \
            man-db \
            man-pages \
            networkmanager \
            pcutils \
            util-linux \
            xf86-video-intel \
            xf86-input-mouse \
            xf86-input-keyboard \
            xf86-input-synaptics \
            kdb \
            setxkbmap \
            sudo \
            udisks2 \
            udisks2-dev \
            udisks2-doc \
            vim \
            wget
        ;;
    "archlinux")
        system_pkg_default_software_install_single \
            ffmpeg \
            git \
            htop \
            jq \
            linux-lts \
            lsb-release \
            netcat \
            ntfs-3g \
            numlockx \
            pv \
            subversion \
            tmux \
            tree \
            unrar \
            unzip \
            wget
        ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora")
        system_pkg_default_software_install_single \
            dnf-plugins-core -y \
            ffmpeg \
            git \
            htop \
            svn \
            tree \
            vim \
            unrar \
            unzip
        ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu")
        system_pkg_default_software_install_single \
            build-essential \
            curl \
            ffmpeg \
            git \
            gnupg2 \
            htop \
            jq \
            pciutils \
            subversion \
            unrar \
            util-linux \
            vim \
            wget
        ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "Combo for essential softwares has been installed"
}

#@annotation_must_be_created1
system_pkg_default_software_install_combo_games() {
    display_message_value_status_warning_complex "Installing combo for playing games"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux") display_message_value_status_empty_complex ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora")
        #Add Steam repository
        sudo dnf config-manager --set-enabled rpmfusion-nonfree-steam

        #Install Steam application
        system_pkg_default_software_install_single \
            dolphin-emulator \
            rpcs3 \
            steam

        #epic-games \
        #kinect \
        ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu")
        system_pkg_default_software_install_single \
            lutris
        ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "Combo for playing games has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_combo_security() {
    display_message_value_status_warning_complex "Installing combo for security softwares"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single \
            firejail \
            firewalld

        #gufw #Firewall

        system_daemon_enable_later firewalld
        ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora")
        system_pkg_default_software_install_single \
            firejail
        ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "Combo for security softwares has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_combo_useful() {
    display_message_value_status_warning_complex "Installing combo for useful softwares platform"

    case $(utils_check_operating_system_name) in
    "alpine")
        system_pkg_default_software_install_single \ 
        lolcat \
            neofetch

        #cmatrix \
        ;;
    "archlinux")
        system_pkg_default_software_install_single \
            alacritty \
            ark \
            gparted \
            lolcat \
            neofetch \
            redshift

        #arandr \
        #archlinux-wallpaper \
        #cheese \
        #cmatrix \
        #deepin-screenshot \
        #dolphin \
        #gestures \
        #go \
        #google-earth \
        #gthumb \
        #libreoffice-still-pt-br \
        #nautilus \
        #nmap \
        #rsync \
        #scrot \
        #simplescreenrecorder \
        #spectacle \
        #xorg-xrandr \

        #timeshift \
        ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora")
        system_pkg_default_software_install_single \
            alien \
            ark \
            gparted \
            lolcat \
            neofetch \
            redshift

        #cheese \
        #cmatrix \
        #dconf-editor \
        #deepin-screenshot \
        #ghostwriter \
        #google-earth \
        #chrome-gnome-shell \
        #kinect \
        #libreoffice-langpack-pt-BR \
        #multitail \
        #native-fier \
        #pdfmod \
        #simplescreenrecorder \
        #scrot \
        #shutter \

        #sudo dnf install https://staruml.io/download/releases-v4/StarUML-4.1.6.x86_64.rpm
        #sudo dnf remove staruml
        ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu")
        system_pkg_default_software_install_single \
            gparted \
            lolcat \
            neofetch \
            redshift \
            yad

        #cheese \
        #cmatrix \
        #cpu-checker \
        #spectacle \

        #alsa-base \
        #alsa-utils \
        #libsbigudrv2 \
        #libsbigudrv0 \
        #linux-sound-base \
        #linux-headers-`uname -r` \
        #pavucontrol \

        #timeshift \
        ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "Combo for useful softwares has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_combo_utility() {
    display_message_value_status_warning_complex "Installing combo for utility softwares"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single \
            avahi \
            dnsutils \
            gvfs \
            gvfs-smb \
            inetutils \
            ipset \
            net-tools \
            nfs-utils \
            nss-mdns \
            scrot

        #sof-firmware

        #net-tools \

        system_daemon_enable_later "avahi-daemon"
        ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora")
        system_pkg_default_software_install_single \
            ImageMagick \
            ImageMagick-devel \
            ImageMagick-perl \
            net-tools

        #Enable VirtualBox copy/cut and paste from the host to the KVM guest
        system_pkg_default_software_install_single "spice-vdagent"

        #native-fier \
        ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu")
        system_pkg_default_software_install_single \
            scrot

        #Enable VirtualBox copy/cut and paste from the host to the KVM guest
        system_pkg_default_software_install_single spice-vdagent

        ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "combo for utility softwares has been installed"
}
