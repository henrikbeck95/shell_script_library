#############################
#System package manager install any platform
#############################

#@annotation_must_be_updated
#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_any_software_install_platform_asdf() {
    display_message_value_status_warning_complex "Installing ASDF platform"

    local FILE_PATH="$1" #/etc/skel/.asdf or $HOME/.asdf

    #Install ASDF
    git clone https://github.com/asdf-vm/asdf.git "$FILE_PATH" --branch v0.9.0

    #BASH
    #string_write_exclusive_line_on_a_file "source $FILE_PATH/asdf.sh" "$HOME/.bashrc"
    #string_write_exclusive_line_on_a_file "source $FILE_PATH/completions/asdf.bash" "$HOME/.bashrc"

    #ZSH
    #string_write_exclusive_line_on_a_file "source $FILE_PATH/asdf.sh" "$HOME/.zshrc"
    #string_write_exclusive_line_on_a_file "source $FILE_PATH/completions/asdf.bash" "$HOME/.zshrc"

    #Uninstall ASDF
    #rm -rf $FILE_PATH/ $HOME/.tool-versions

    display_message_value_status_success_complex "ASDF platform has been installed"
}

#@annotation_must_be_improved
system_pkg_any_software_install_platform_distrobox() {
    display_message_value_status_warning_complex "Installing DistroBox setup"

    curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh

    display_message_value_status_success_complex "DistroBox setup has been installed"
}

system_pkg_any_software_install_platform_dropbox() {
    display_message_value_status_warning_complex "Installing Dropbox platform"

    case $(utils_check_architecture) in
    "32-bits")
        utils_download_file "https://www.dropbox.com/download?plat=lnx.x86" "$HOME/"
        utils_extract_file_tar "$HOME/'download?plat=lnx.x86'"
        utils_remove_file 'download?plat=lnx.x86'
        ;;
    "64-bits")
        utils_download_file "https://www.dropbox.com/download?plat=lnx.x86_64" "$HOME/"
        utils_extract_file_tar "$HOME/'download?plat=lnx.x86_64'"
        utils_remove_file 'download?plat=lnx.x86_64'
        ;;
    *) display_message_value_status_error_complex "???" ;;
    esac

    display_message_value_status_warning_complex "Execute daemon (this process is going to open a DropBox web site on user default browser to authenticate an existing account)"

    "$HOME/.dropbox-dist/dropboxd"

    display_message_value_status_warning_complex "Script for controlling DropBox from command line interface (CLI)."

    #Download the DropBox command line interface script
    utils_download_file "https://www.dropbox.com/download?dl=packages/dropbox.py" "$HOME/.dropbox-dist/"

    #display_message_value_status_warning_complex ""

    #if [[ ! -d $HOME/.dropbox-dist/ ]]; then
    #python3 $HOME/dropbox.py start -i
    #else
    #python3 $HOME/dropbox.py start
    #fi

    #Give executable permission to DropBox command line interface script
    system_permission_set_executable "$HOME/.dropbox-dist/dropbox.py"

    #Create symbolic link for DropBox command line interface script
    utils_path_directory_create "$HOME/bin/"

    utils_symbolic_link_create \
        "$HOME/.dropbox-dist/dropbox.py" \
        "$HOME/bin/dropbox-cli"

    #Useful commands
    #dropbox-cli status
    #dropbox-cli autostart y
    #dropbox-cli running
    #dropbox-cli start
    #dropbox-cli start -i
    #dropbox-cli status

    display_message_value_status_success_complex "Dropbox platform has been installed"
}

#flatpak

#@annotation_must_be_improved
system_pkg_any_software_install_platform_java() {
    display_message_value_status_warning_complex "Installing ??? platform"

    #Java
    asdf plugin-add java https://github.com/halcyon/asdf-java.git
    asdf list-all java
    asdf install java adoptopenjdk-8.0.181+13
    asdf install java openjdk-17
    asdf global java openjdk-17
    java --version

    display_message_value_status_success_complex "??? platform has been installed"
}

system_pkg_any_software_install_platform_joplin() {
    display_message_value_status_warning_complex "Installing Joplin platform"

    wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

    display_message_value_status_success_complex "Joplin platform has been installed"
}

system_pkg_any_software_install_platform_lf() {
    display_message_value_status_warning_complex "Installing LF platform"

    cd /tmp/ || exit
    utils_download_file "https://github.com/gokcehan/lf/releases/download/r26/lf-linux-amd64.tar.gz" "/tmp/"
    utils_extract_file_tar "/tmp/lf-linux-amd64.tar.gz"
    cd - || exit

    utils_move_file "/tmp/lf" "/usr/local/bin/lf"
    utils_remove_file "/tmp/lf-linux-amd64.tar.gz"

    display_message_value_status_success_complex "LF platform has been installed"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
#CHECK ASDF IS INSTALLED
system_pkg_any_software_install_platform_node() {
    display_message_value_status_warning_complex "Installing Node platform"

    #Install NodeJS plugin
    system_pkg_any_asdf_repository_add "nodejs" "https://github.com/asdf-vm/asdf-nodejs.git"

    #List all NodeJS plugins available
    system_pkg_any_asdf_software_list "all" "nodejs"

    #Install NodeJS versions
    #system_pkg_any_asdf_software_install "nodejs" "latest"
    system_pkg_any_asdf_software_install "nodejs" "lts"

    #Set NodeJS environment
    asdf global nodejs lts
    #asdf local nodejs latest #Your current working directory

    #Check if NodeJS version
    nodejs --version

    display_message_value_status_success_complex "Node platform has been installed"
}

#@annotation_must_be_tested
system_pkg_any_software_install_platform_oh_my_posh() {
    display_message_value_status_warning_complex "Installing Oh-My-Posh! platform with all themes"

    local PATH_DESTINY="$1"
    #local PATH_DESTINY="/etc/skel/.poshthemes"
    #local PATH_DESTINY="$HOME/.poshthemes"

    utils_download_file "https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64" "/usr/local/bin/oh-my-posh"
    system_permission_set_executable "/usr/local/bin/oh-my-posh"
    utils_path_directory_create "$PATH_DESTINY"
    utils_download_file "https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip" "$PATH_DESTINY/"
    utils_extract_file_zip "$PATH_DESTINY/themes.zip" "$PATH_DESTINY"
    utils_remove_file "$PATH_DESTINY/themes.zip"
    chmod u+rw "$PATH_DESTINY/*.json"

    display_message_value_status_success_complex "Oh-My-Posh! platform has been installed"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_any_software_install_platform_paru() {
    utils_exit_if_user_does_not_have_root_previledges

    display_message_value_status_warning_complex "Installing package manager setup"

    case $(system_pkg_check_package_manager) in
    "apk") display_message_value_status_empty_complex ;;
    "apt") display_message_value_status_empty_complex ;;
    "aur")
        #Installing Paru
        utils_path_directory_create "$HOME/compilation/"
        git clone https://aur.archlinux.org/paru.git "$HOME/compilation/paru"

        cd "$HOME/compilation/paru/" || exit
        makepkg -si
        cd - || exit
        ;;
    "dnf") display_message_value_status_empty_complex ;;
    "emerge") display_message_value_status_empty_complex ;;
    "pacman") display_message_value_status_empty_complex ;;
    "slackpkg") display_message_value_status_empty_complex ;;
    "yum") display_message_value_status_empty_complex ;;
    "zypper") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "Package manager has not been found." ;;
    esac

    display_message_value_status_success_complex "Package manager setup has been installed"
}

#@annotation_must_be_created
system_pkg_any_software_install_platform_python() {
    display_message_value_status_warning_complex "Installing ??? platform"

    display_message_value_status_success_complex "??? platform has been installed"
}

#@annotation_must_be_created
system_pkg_any_software_install_platform_rust() {
    display_message_value_status_warning_complex "Installing ??? platform"

    display_message_value_status_success_complex "??? platform has been installed"
}

#@annotation_must_be_created
system_pkg_any_software_install_platform_timeshift() {
    display_message_value_status_warning_complex "Installing Timeshift platform"

    #ArchLinux
    #util_download_file https://aur.andontie.net/x86_64/timeshift-21.09.1-3-x86_64.pkg.tar.zst "$HOME/"
    #pacman -U $HOME/timeshift-21.09.1-3-x86_64.pkg.tar.zst

    #Fedora
    #system_package_manager_dnf_software_install_single "timeshift"

    #Ubuntu
    #system_package_manager_ubuntu_apt_software_install "timeshift"

    display_message_value_status_success_complex "Timeshift platform has been installed"
}

#@annotation_must_be_tested
#@annotation_must_be_improved
system_pkg_any_software_install_platform_tpm() {
    local FILE_PATH="$1"

    display_message_value_status_warning_complex "Installing Tmux Plugin Manager (TPM) platform"

    utils_git_repository_clone "https://github.com/tmux-plugins/tpm" "$FILE_PATH/.tmux/plugins/tpm"

    display_message_value_status_success_complex "Tmux Plugin Manager (TPM) platform has been installed"
}

#@annotation_must_be_tested
system_pkg_any_software_install_platform_vundle() {
    local FILE_PATH="$1"

    display_message_value_status_warning_complex "Installing Vundle Vim platform"

    #Install Vundle-Vim
    utils_git_repository_clone "https://github.com/VundleVim/Vundle.vim.git" "$FILE_PATH/.vim/bundle/Vundle.vim"

    #Download custom Vimrc
    utils_download_file "https://raw.githubusercontent.com/henrikbeck95/dotfiles/development/compiled/.vimrc" "$FILE_PATH/"

    #Install Vim plugins
    vim +PluginInstall +qall

    display_message_value_status_success_complex "Vundle Vim platform has been installed"
}

#@annotation_must_be_created
system_pkg_any_software_install_platform_yarn() {
    display_message_value_status_warning_complex "Installing Node Yarn platform"

    display_message_value_status_empty_complex

    display_message_value_status_success_complex "Node Yarn platform has been installed"
}

#@annotation_must_be_improved
#@annotation_must_be_tested
system_pkg_any_software_install_platform_ytfzf() {
    utils_exit_if_user_does_not_have_root_previledges

    display_message_value_status_warning_complex "Installing YtFZF software setup"

    local pkgdir=""
    local pkgname="ytfzf"

    #Check the following GitHub repositories pages
    #utils_browser_open_url "https://github.com/pystardust/ytfzf"
    #utils_browser_open_url "https://github.com/seebye/ueberzug"
    #utils_browser_open_url "https://github.com/ytdl-org/youtube-dl"

    #Installing YouTube-DL
    curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
    chmod a+rx /usr/local/bin/youtube-dl

    #Installing others dependencies
    case $(system_pkg_check_package_manager) in
    "apk") display_message_value_status_empty_complex ;;
    "apt")
        system_pkg_default_software_install_single "curl git jq mpv fzf libxext-dev"
        utils_git_repository_clone "https://github.com/pystardust/ytfzf" "$HOME/.ytfzf"
        cd "$HOME/.ytfzf/" || exit
        sudo make install doc
        ;;
    "aur") display_message_value_status_empty_complex ;;
    "dnf") display_message_value_status_empty_complex ;;
    "emerge") display_message_value_status_empty_complex ;;
    "pacman") system_pkg_default_software_install_single "curl git jq mpv fzf ueberzug" ;;
    "slackpkg") display_message_value_status_empty_complex ;;
    "yum") display_message_value_status_empty_complex ;;
    "zypper") display_message_value_status_empty_complex ;;
    *) display_message_value_status_error_complex "Package manager has not been found." ;;
    esac

    #Installing YtFZF software setup
    #Original installation setup: sudo pacman -S fzf ueberzug && paru -S ytfzf
    #curl -L "https://raw.githubusercontent.com/pystardust/ytfzf/master/ytfzf" -o "/usr/bin/ytfzf"
    utils_download_file "https://raw.githubusercontent.com/pystardust/ytfzf/master/${pkgname}" "/usr/bin/${pkgname}"
    system_permission_set_executable "/usr/bin/${pkgname}"

    #Installing YtFZF documentation
    utils_download_file "https://raw.githubusercontent.com/pystardust/ytfzf/master/LICENSE" "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
    utils_download_file "https://raw.githubusercontent.com/pystardust/ytfzf/master/docs/man/ytfzf.1" "${pkgdir}/usr/share/man/man1/${pkgname}.1.gz"
    utils_download_file "https://raw.githubusercontent.com/pystardust/ytfzf/master/docs/man/ytfzf.5" "${pkgdir}/usr/share/man/man1/${pkgname}.5.gz"
    utils_download_file "https://raw.githubusercontent.com/pystardust/ytfzf/master/docs/conf.sh" "${pkgdir}/usr/share/doc/${pkgname}"

    #Creating alias for BASH
    tools_string_write_exclusive_line_on_a_file 'alias "youtube_audio_download"="ytfzf -d -l --pages=10 -m -t $*"' "$HOME/.bashrc"
    tools_string_write_exclusive_line_on_a_file 'alias "youtube_audio_play"="ytfzf -l --pages=10 -m -t $*"' "$HOME/.bashrc"
    tools_string_write_exclusive_line_on_a_file 'alias "youtube_video_download"="ytfzf -d -l --pages=10 -t $*"' "$HOME/.bashrc"
    tools_string_write_exclusive_line_on_a_file 'alias "youtube_video_play"="ytfzf -l --pages=10 -t $*"' "$HOME/.bashrc"

    #Creating alias for ZSH
    tools_string_write_exclusive_line_on_a_file 'alias "youtube_audio_download"="ytfzf -d -l --pages=10 -m -t $*"' "$HOME/.zshrc"
    tools_string_write_exclusive_line_on_a_file 'alias "youtube_audio_play"="ytfzf -l --pages=10 -m -t $*"' "$HOME/.zshrc"
    tools_string_write_exclusive_line_on_a_file 'alias "youtube_video_download"="ytfzf -d -l --pages=10 -t $*"' "$HOME/.zshrc"
    tools_string_write_exclusive_line_on_a_file 'alias "youtube_video_play"="ytfzf -l --pages=10 -t $*"' "$HOME/.zshrc"

    display_message_value_status_success_complex "YtFZF setup has been installed"
}
