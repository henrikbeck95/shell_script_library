#############################
#System package manager install default platform
#############################

#@annotation_must_be_created
system_pkg_default_software_install_platform_alsa() {
    display_message_value_status_warning_complex "Installing ALSA platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux") display_message_value_status_empty_complex ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") display_message_value_status_empty_complex ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "ALSA platform has been installed"
}

#@annotation_must_be_improved
system_pkg_default_software_install_platform_amd() {
    display_message_value_status_warning_complex "Installing AMD graphical card platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux") system_pkg_default_software_install_single "xf86-video-amdgpu" ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") display_message_value_status_empty_complex ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "AMD graphical card platform has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_platform_aur() {
    display_message_value_status_warning_complex "Installing Aur platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux") display_message_value_status_empty_complex ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") display_message_value_status_empty_complex ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "Aur platform has been installed"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_default_software_install_platform_bash() {
    display_message_value_status_warning_complex "Installing Bash shell platform"

    case $(utils_check_operating_system_name) in
    "alpine") system_pkg_default_software_install_single "bash" "bash-doc" "bash-completion" ;;
    "archlinux") system_pkg_default_software_install_single "bash-completion" ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") display_message_value_status_empty_complex ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    #display_message_value_status_success_complex "Installed by default"

    display_message_value_status_success_complex "Bash shell platform has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_platform_bluetooth() {
    display_message_value_status_warning_complex "Installing Bluetooth platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single \
            bluez \
            bluez-utils

        system_daemon_enable_now bluetooth
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

    display_message_value_status_success_complex "Bluetooth platform has been installed"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_default_software_install_platform_cockpit() {
    display_message_value_status_warning_complex "Installing Cockpit platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single
        cockpit \
            cockpit-machines \
            cockpit-pcp \
            cockpit-podman

        system_pkg_archlinux_aur_software_install \
            packagekit \
            pcp \
            virt-viewer

        #Enabling Systemd process
        system_daemon_enable_now cockpit.socket
        system_daemon_enable_now cockpit.pmcd
        system_daemon_enable_now pmlogger
        ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") display_message_value_status_empty_complex ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu")
        system_pkg_default_software_install_single \
            cockpit \
            cockpit-machines \
            cockpit-podman \
            virt-manager
        ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    cat /etc/systemd/system/cockpit.socker.d/listen.conf

    #Access Cockpit localhost from browser
    #xdg-open https://localhost:9090/

    display_message_value_status_success_complex "Cockpit platform has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_platform_codecs() {
    display_message_value_status_warning_complex "Installing Codecs platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux") display_message_value_status_empty_complex ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora")
        utils_check_if_user_has_root_previledges

        #Firefox
        dnf config-manager --set-enabled fedora-cisco-openh264

        system_pkg_default_software_install_single \
            gstreamer1-plugin-openh264 \
            mozilla-openh264 \
            openh264 \
            openh264-devel
        ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "Codecs platform has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_platform_cups() {
    display_message_value_status_warning_complex "Installing Cups platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single \
            cups
        #hplip

        system_daemon_enable_now cups.service
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

    display_message_value_status_success_complex "Cups platform has been installed"
}

#@annotation_must_be_improved
#@annotation_must_be_edited
system_pkg_default_software_install_platform_debtrap() {
    display_message_value_status_warning_complex "Installing Debtrap platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_archlinux_aur_software_install \
            debtap

        debtap -u
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

    display_message_value_status_success_complex "Debtrap platform has been installed"
}

#@annotation_must_be_improved
system_pkg_default_software_install_platform_deepin() {
    display_message_value_status_warning_complex "Installing Deepin platform"

    system_pkg_default_software_install_platform_xorg
    system_pkg_default_software_install_platform_lightdm

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single \
            deepin \
            deepin-extra

        echo "greeter-session=lightdm-deepin-greeter" >>/etc/lightdm/lightdm.conf
        #echo "display-setup-script=xrandr --output virtual-1 --mode 1920x1080" >> /etc/lightdm/lightdm.conf

        system_daemon_enable_later "lightdm.service"

        display_message_value_status_warning_complex "$MESSAGE_RESTART"
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

    display_message_value_status_success_complex "Deepin platform has been installed"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_default_software_install_platform_dhcpcd() {
    display_message_value_status_warning_complex "Installing Dhcpcd network interface platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single "dhcpcd"
        system_daemon_enable_now "dhcpcd"
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

    display_message_value_status_success_complex "Dhcpcd network interface platform has been installed"
}

#@annotation_must_be_improved
system_pkg_default_software_install_platform_docker() {
    display_message_value_status_warning_complex "Installing Docker platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        #Installation
        system_pkg_default_software_install_single \
            docker \
            docker-compose

        #Enabling
        system_daemon_enable_now "docker"

        #Checking version
        docker --version

        #Removing sudo requirement
        #getent group docker && sudo gpasswd -a $(whoami) docker && echo -e "\n***Log out and then login to apply the changes or restart the operating system***\n"

        display_message_value_status_warning_complex "$MESSAGE_RESTART"

        #Verify that you can run docker commands without sudo
        #docker run hello-world
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

    display_message_value_status_success_complex "Docker platform has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_platform_drivers() {
    display_message_value_status_warning_complex "Installing Drivers platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux") display_message_value_status_empty_complex ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") display_message_value_status_empty_complex ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "Drivers platform has been installed"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_default_software_install_platform_flatpak() {
    display_message_value_status_warning_complex "Installing Flatpak platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux") system_pkg_default_software_install_single "flatpak" ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") display_message_value_status_success_complex "Installed by default" ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "Flatpak platform has been installed"
}

#@annotation_must_be_improved
system_pkg_default_software_install_platform_gnome() {
    display_message_value_status_warning_complex "Installing Gnome platform"

    system_pkg_default_software_install_platform_wayland

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single \
            gdm \
            gnome \
            gnome-center-control \
            gnome-extra \
            gnome-tweaks

        system_daemon_enable_later "gdm"

        display_message_value_status_warning_complex "$MESSAGE_RESTART"
        ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora")
        system_pkg_default_software_install_single \
            gnome-tweak-tool \
            gnome-tweaks
        ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "Gnome platform has been installed"
}

#@annotation_must_be_improved
system_pkg_default_software_install_platform_i3() {
    display_message_value_status_warning_complex "Installing i3 platform"

    system_pkg_default_software_install_platform_xorg

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single \
            i3 \
            dmenu \
            feh \
            lxappearance \
            nitrogen \
            polybar \
            rofi

        #cava - AUR
        ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") display_message_value_status_empty_complex ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu")
        system_pkg_default_software_install_single \
            i3 \
            i3-gaps \
            feh \
            lxappearance \
            polybar \
            rofi \
            cava \
            gnome-center-control \
            network-manager-gnome \
            ubiquity

        #Cava
        sudo add-apt-repository ppa:hsheth2/ppa
        system_pkg_default_software_install_single update
        system_pkg_default_software_install_single install cava
        ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    system_pkg_default_software_install_platform_i3lock
    #system_pkg_default_software_install_platform_ly

    display_message_value_status_success_complex "i3 platform has been installed"
}

#@annotation_must_be_improved
system_pkg_default_software_install_platform_i3lock() {
    display_message_value_status_warning_complex "Installing i3-Lock platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux") display_message_value_status_empty_complex ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") display_message_value_status_empty_complex ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") system_pkg_default_software_install_single i3-lock ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "i3-Lock platform has been installed"
}

#@annotation_must_be_improved
system_pkg_default_software_install_platform_intel() {
    display_message_value_status_warning_complex "Installing Intel graphical card platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux") system_pkg_default_software_install_single xf86-video-intel ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") display_message_value_status_empty_complex ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "Intel graphical card platform has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_platform_lightdm() {
    display_message_value_status_warning_complex "Installing LightDM platform"

    case $(utils_check_operating_system_name) in
    "alpine")
        system_pkg_default_software_install_single lightdm-gtk-greeter

        #rc-service lightdm start && rc-update add lightdm
        system_daemon_enable_now "lightdm"
        ;;
    "archlinux")
        system_pkg_default_software_install_single \
            gnome-disk-utility \
            lightdm \
            lightdm-gtk-greeter \
            lightdm-gtk-greeter-settings

        #system_daemon_enable_later lightdm.service -f
        system_daemon_enable_later lightdm.service
        systemctl set-default graphical.target
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

    display_message_value_status_success_complex "LightDM platform has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_platform_ly() {
    display_message_value_status_warning_complex "Installing Ly platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        git clone https://aur.archlinux.org/ly
        cd ./ly/ || exit
        makepkg -si

        system_daemon_enable_later ly.service
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

    display_message_value_status_success_complex "Ly platform has been installed"
}

#@annotation_must_be_improved
system_pkg_default_software_install_platform_nvidia() {
    display_message_value_status_warning_complex "Installing Nvidia graphical card platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single \
            nvidia \
            nvidia-utils \
            nvidia-settings
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

    display_message_value_status_success_complex "Nvidia graphical card platform has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_platform_pipewire() {
    display_message_value_status_warning_complex "Installing Pipewire platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single \
            pipewire \
            pipewire-alsa \
            pipewire-pulse \
            pipewire-jack
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

    display_message_value_status_success_complex "Pipewire platform has been installed"
}

#@annotation_must_be_improved
system_pkg_default_software_install_platform_plasma() {
    display_message_value_status_warning_complex "Installing KDE Plasma platform"

    system_pkg_default_software_install_platform_xorg

    #system_pkg_default_software_install_platform_wayland
    #system_pkg_default_software_install_single "plasma-wayland-session"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single \
            sddm \
            plasma \
            materia-kde
        #kde-applications

        #For Wayland
        #system_pkg_default_software_install_single plasma-wayland-session

        system_daemon_enable_later "sddm"
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

    display_message_value_status_warning_complex "$MESSAGE_RESTART"

    display_message_value_status_success_complex "KDE Plasma platform has been installed"
}

#@annotation_must_be_improved
system_pkg_default_software_install_platform_podman() {
    display_message_value_status_warning_complex "Installing Podman platform"

    case $(utils_check_operating_system_name) in
    "alpine")
        system_pkg_default_software_install_single "podman" "fuse-overlayfs" "shadow" "slirp4netns"

        modprobe tun

        useradd -mG wheel "$QUESTION_USERNAME"
        passwd "$QUESTION_USERNAME"

        usermod --add-subuids 100000-165535 "$QUESTION_USERNAME"
        usermod --add-subgids 100000-165535 "$QUESTION_USERNAME"

        podman system migrate
        podman run --rm hello-world

        #buildah buildah-doc
        ;;
    "archlinux")
        utils_edit_file "/etc/default/grub"
        #Edit the line: GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet video=1920x1080 cgroup_no_v1 "all""

        grub-mkconfig -o /boot/grub/grub.cfg
        display_message_value_status_warning_complex "$MESSAGE_RESTART"

        system_pkg_default_software_install_single \
            "buildah" "catatonit" "crun" "podman"

        #cgroups

        system_daemon_enable_now podman.socket

        ##Check the value of the Podman previledges
        # case $(sysctl kernel.unprivileged_userns_clone) in
        # 	0)
        # 	1)
        # 	*) display_message_value_status_error_complex "" ;;
        # esac

        #Rootless
        touch /etc/{subuid,subgid}

        usermod --add-subuids 100000-165535 --add-subgids 100000-165535 "$QUESTION_USERNAME"
        grep "$QUESTION_USERNAME" /etc/subgid /etc/subuid

        #Testing - start
        echo -e "$QUESTION_USERNAME:100000:65536" >/etc/subuid
        echo -e "$QUESTION_USERNAME:100000:65536" >/etc/subgid

        echo -e "buildah:100000:65536" >>/etc/subuid
        echo -e "buildah:100000:65536" >>/etc/subgid
        #Testing - end

        #Check if everything is set up rightly
        utils_edit_file "/etc/subgid" "/etc/subuid"

        #Propagate changes to subuid and subgid
        podman system migrate

        #display_message_value_status_warning_complex "$MESSAGE_RESTART"

        #sudo dnf install -y podman-docker

        ##############################
        #Podman Ngnix example
        ##############################
        #
        #man podman
        #podman search nginx
        #podman pull docker.io/library/nginx
        #podman images
        #podman run -dt
        #sudo mkdir -p /web/
        #podman run -d -v /web/:/usr/share/nginx/html -p 8080:80/tcp nginx
        #podman ps
        #
        ##############################
        #Create a webpage, access it passthrought the firewall
        ##############################
        #
        #chown $QUESTION_USERNAME: /web/
        #echo -e "Hello world from the container" > /web/index.html
        #sudo firewall-cmd --add-port=8080/tcp
        #xgd-open http://localhost:8080
        #sudo firewall-cmd --add-port=8080/tcp --permanent
        #
        ##############################
        #Create a systemd instance for persistenting the container after reboot
        ##############################
        #
        #sudo loginctl enable-linger $QUESTION_USERNAME
        #loginctl user-status $QUESTION_USERNAME
        #mkdir -p $HOME/.config/systemd/user/
        #cd $HOME/.config/systemd/user/
        #podman generate systemd --name <container_name> --files
        #systemctl --user daemon-reload
        #systemctl --user enable <container_name>
        #display_message_value_status_warning_complex "$MESSAGE_RESTART"
        #
        ##############################
        #Disable a systemd instance
        ##############################
        #
        #podman ps
        #systemctl --user status <container_name>
        #systemctl --user disable --now <container_name>
        #podman ps
        #podman ps -a
        #
        ##############################
        ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") display_message_value_status_success_complex "Installed by default" ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "Podman platform has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_platform_pulseaudio() {
    display_message_value_status_warning_complex "Installing PulseAudio platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single \
            alsa-utils \
            pavucontrol \
            pulseaudio
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

    display_message_value_status_success_complex "PulseAudio platform has been installed"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
#MUST BE IMPLEMENTED SED CUT FUNCTION
system_pkg_default_software_install_platform_openssh() {
    display_message_value_status_warning_complex "Installing OpenSSH connection support platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single "openssh"
        system_daemon_enable_now sshd.service
        ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") system_pkg_default_software_install_single "openssh-server" ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") system_pkg_default_software_install_single "openssh-client" ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    utils_edit_file "/etc/ssh/sshd_config" #Uncomment the port 22

    #display_message_value_status_warning_complex "Change Root password"
    #passwd root

    #display_message_value_status_warning_complex "Get the ip address"
    #ip addr

    display_message_value_status_warning_complex "Auxiliar machine\n	
	For rightly configuring the another PC with Linux, follow the steps below:
	
	$ sudo apt install openssh-client
	$ ssh -l <username> <ip_address>
	or $ ssh root@<ip_address>
	or $ ssh-keygen -f \"/home/your_user/.ssh/known_hosts\" -R \"192.168.1.221\""

    display_message_value_status_success_complex "OpenSSH connection support platform has been installed"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
#@annotation_must_be_fixed
system_pkg_default_software_install_platform_snap() {
    display_message_value_status_warning_complex "Installing Snap platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single "snapd"

        #Enabling the Snap core on systemd
        system_daemon_enable_now "snapd.socket"

        #Create a symbolic link to root directory
        utils_check_if_user_has_root_previledges
        utils_symbolic_link_create "/var/lib/snapd/snap" "/snap"
        #sudo rm -f /snap

        display_message_value_status_warning_complex "$MESSAGE_RESTART"
        ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora")
        #Install Snap runtime
        system_pkg_default_software_install_single "snapd"

        #Create a symbolic link to root directory
        utils_check_if_user_has_root_previledges
        utils_symbolic_link_create "/var/lib/snapd/snap" "/snap"
        #sudo rm -f /snap
        ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "Snap platform has been installed"
}

#@annotation_must_be_improved
#@annotation_must_be_fixed
system_pkg_default_software_install_platform_virtmanager() {
    display_message_value_status_warning_complex "Installing Virt-Manager platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        #@annotation_must_be_fixed

        utils_check_if_virtualization_is_enabled

        #Virt-Manager
        #The Ebtables is an internet brigde software

        system_pkg_default_software_install_single \
            bridge-utils \
            dnsmasq \
            ebtables \
            libvirt \
            openbsd-netcat \
            qemu \
            virt-manager

        #iptables \
        #vde2 \
        #virt-viewer

        #system_pkg_archlinux_aur_software_install \
        #libguestfs

        #Setting specific permission
        echo -e 'unix_sock_group = "libvirt"' >/etc/libvirt/libvirtd.conf
        echo -e 'unix_sock_rw_perms = "0770"' >/etc/libvirt/libvirtd.conf
        #utils_edit_file /etc/libvirt/libvirtd.conf

        #Enabling Systemd process
        system_daemon_enable_now "libvirtd.service"
        system_daemon_enable_now "dnsmasq.service"

        #Add user to the following groups
        gpasswd -a "$QUESTION_USERNAME" libvirt
        usermod -G libvirt -a "$QUESTION_USERNAME"
        usermod -aG libvirt "$QUESTION_USERNAME"

        #Create a virtual machine
        #qemu-img convert -f vdi -O qcow2 Ubuntu\ 20.04.vdi /var/lib/libvirt/images/ubuntu-20-04.qcow2

        #virsh net-dumpxml default > br1.xml
        #utils_edit_file br1.xml

        display_message_value_status_warning_complex "$MESSAGE_RESTART"
        ;;
    "debian") display_message_value_status_empty_complex ;;
        #"centos") display_message_value_status_empty_complex ;;
        #"fedora")
    "centos" | "fedora")
        tools_display_message_value_status_warning_complex "Virtual machine"

        utils_check_if_virtualization_is_enabled

        system_pkg_default_software_install_single '@virtualization'

        #Alternatively, to install the mandatory, default, and optional packages, run:
        system_pkg_default_software_install_group "virtualization"

        #Enable Systemd service
        system_daemon_enable_now libvirtd

        #To verify that the KVM kernel modules are properly loaded:
        lsmod | grep kvm
        #If this command lists kvm_intel or kvm_amd, KVM is properly configured.
        #kvm_amd               114688  0
        #kvm                   831488  1 kvm_amd
        ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu")
        system_pkg_default_software_install_single \
            qemu-kvm \
            qemu \
            libvirt-bin \
            virt-manager \
            virt-viewer

        #Enable VirtualBox copy/cut mouse
        system_pkg_default_software_install_single "spice-vdagent"
        ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "Virt-Manager platform has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_platform_virtualbox() {
    display_message_value_status_warning_complex "Installing VirtualBox platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux") display_message_value_status_empty_complex ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") display_message_value_status_empty_complex ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "VirtualBox platform has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_platform_wayland() {
    display_message_value_status_warning_complex "Installing Wayland platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux") display_message_value_status_empty_complex ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") display_message_value_status_empty_complex ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "Wayland platform has been installed"
}

#@annotation_must_be_improved
system_pkg_default_software_install_platform_xdg() {
    display_message_value_status_warning_complex "Installing XDG platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux")
        system_pkg_default_software_install_single \
            xdg-user-dirs \
            xdg-utils
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

    display_message_value_status_success_complex "XDG platform has been installed"
}

#@annotation_must_be_improved
system_pkg_default_software_install_platform_xfce() {
    display_message_value_status_warning_complex "Installing XFCE platform"

    system_pkg_default_software_install_platform_xorg
    system_pkg_default_software_install_platform_lightdm

    case $(utils_check_operating_system_name) in
    "alpine")
        system_pkg_default_software_install_single \
            xfce4 \
            xfce4-terminal \
            xfce4-screensaver
        #lightdm-gtk-greeter

        #rc-service dbus start && rc-update add dbus
        system_daemon_enable_now "dbus"

        #startx
        ;;
    "archlinux")
        system_pkg_default_software_install_single \
            xfce4 \
            xfce4-goodies

        system_daemon_enable_later "lightdm"

        display_message_value_status_warning_complex "$MESSAGE_RESTART"
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

    display_message_value_status_success_complex "XFCE platform has been installed"
}

#@annotation_must_be_created
system_pkg_default_software_install_platform_xorg() {
    display_message_value_status_warning_complex "Installing X.org platform"

    case $(utils_check_operating_system_name) in
    "alpine") display_message_value_status_empty_complex ;;
    "archlinux") system_pkg_default_software_install_single xorg ;;
    "debian") display_message_value_status_empty_complex ;;
    "centos") display_message_value_status_empty_complex ;;
    "fedora") display_message_value_status_empty_complex ;;
    "gentoo") display_message_value_status_empty_complex ;;
    "opensuse") display_message_value_status_empty_complex ;;
    "slackware") display_message_value_status_empty_complex ;;
    "ubuntu") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_success_complex "X.org platform has been installed"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_default_software_install_platform_zsh() {
    display_message_value_status_warning_complex "Installing ZSH shell platform"

    case $(utils_check_operating_system_name) in
    "alpine")
        system_pkg_default_software_install_single "zsh" "zsh-doc"

        #Find username and change the default shell from /bin/ash to /bin/zsh
        utils_edit_file /etc/passwd
        echo "$SHELL"

        #Check the responsible files whose managing the shells
        utils_edit_file "/etc/login.defs" "/etc/default/useradd"
        ;;
    "archlinux")
        system_pkg_default_software_install_single "zsh" "zsh-autosuggestions" "zsh-syntax-highlighting" "zsh-completions"

        #Set ZSH as default shell
        echo -e "$SHELL"
        cat /etc/shells
        chsh -s /usr/bin/zsh
        display_message_value_status_warning_complex "$MESSAGE_RESTART"
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

    #display_message_value_status_success_complex "Installed by default"

    display_message_value_status_success_complex "ZSH shell platform has been installed"
}
