#############################
#System appearance
#############################

#@annotation_must_be_improved
system_appearance_desktop_environment_gnome() {
	#List all the Gnome settings commands
	#clear && gsettings list-recursively | grep "$1" | less
	#gsettings list-recursively | egrep "Alt|Shift|Super|Space|Win|Meta|Primary|Control|Ctrl|Tab" | grep org.gnome | awk '{print $1}' | sort -u
	#clear && gsettings list-recursively | grep col

	gsettings get org.gnome.shell favorite-apps

	gsettings reset org.gnome.desktop.app-folders folder-children #Removed all the folders
	gsettings reset org.gnome.desktop.sound allow-volume-above-100-percent

	gsettings set org.gnome.desktop.a11y always-show-universal-access-status true
	gsettings set org.gnome.desktop.background show-desktop-icons true
	gsettings set org.gnome.desktop.interface clock-show-date true
	gsettings set org.gnome.desktop.interface show-battery-percentage true
	gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
	#gsettings set org.gnome.desktop.wm.preferences button-layout ':close'
	gsettings set org.gnome.gedit.preferences.editor auto-indent true
	gsettings set org.gnome.gedit.preferences.editor bracket-matching true
	gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
	gsettings set org.gnome.gedit.preferences.editor highlight-current-line true
	gsettings set org.gnome.gedit.preferences.editor tabs-size 4
	gsettings set org.gnome.mutter center-new-windows true
	gsettings set org.gnome.mutter focus-change-on-pointer-rest true
	gsettings set org.gnome.nautilus.preferences show-hidden-files true
	#gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
	#gsettings set org.gnome.shell.extensions.dash-to-dock dock-position RIGHT
	#gsettings set org.gnome.shell.extensions.dash-to-dock show-favorites true
	#gsettings set org.gnome.shell.extensions.dash-to-dock show-windows-preview true
	gsettings set org.gnome.shell.extensions.desktop-icons show-home false
	gsettings set org.gnome.shell.extensions.desktop-icons show-trash false
}

system_appearance_theme_alacritty_midnightcity() {
	utils_path_directory_create "$HOME/.config/alacritty/"
	
	cd "$HOME/.config/alacritty/"
	
	utils_download_file "https://raw.githubusercontent.com/henrikbeck95/dotfiles/development/current/alacritty.yml"
	
	cd -
}

#@annotation_must_be_improved
system_appearance_theme_gedit_dracula() {
	utils_download_file "https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml"

	display_message_value_status_warning_complex "Must open Gedit application and set load this file manually"
}

#@annotation_must_be_improved
#@annotation_must_be_fixed
#@annotation_must_be_updated
system_appearance_theme_gtk_adwaita() {
	utils_path_directory_create "$HOME/.themes/"

	cd "$HOME/.themes/" || exit

	#Adwaita color generator
	utils_git_repository_clone "https://github.com/Gnostiphage/adwaita-color-gen.git"
	utils_symbolic_link_create "$HOME/.themes/adwaita-color-gen/generated/*" "$HOME/.themes/"

	#Orchis theme
	utils_git_repository_clone "https://github.com/vinceliuice/Orchis-theme.git"
	utils_symbolic_link_create "$HOME/.themes/Orchis-theme/release/*.tar.xz" "$HOME/.themes/"

	#Apply Adwaita theme
	gsettings set org.gnome.desktop.interface gtk-theme Adwaita
	#gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
}

#@annotation_must_be_improved
system_appearance_theme_gtk_dracula() {
	gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
	gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
}

system_appearance_theme_lf_dracula() {
	utils_path_directory_create "$HOME/.config/lf/"

	cd "$HOME/.config/lf/" || exit

	utils_download_file "https://raw.githubusercontent.com/henrikbeck95/dotfiles/development/current/lfrc"

	cd - || exit
}

#@annotation_must_be_improved
system_appearance_theme_libreoffice_dracula() {
	utils_git_repository_clone "https://github.com/dracula/libreoffice.git" "$HOME/Documents/libroffice"
	system_permission_set_executable "$HOME/Documents/dracula/libroffice/add_dracula_application_colors.sh"
	utils_edit_file "$HOME/Documents/dracula/libroffice/add_dracula_application_colors.sh"
	#$HOME/Documents/dracula/libroffice/add_dracula_application_colors.sh
}

#@annotation_must_be_chosen
#@annotation_must_be_improved
system_appearance_theme_shell_starship() {
	sh -c "$(curl -L https://starship.rs/install.sh)"
	echo 'eval "$(starship init bash)"' >>"$HOME/.bashrc"
	echo 'eval "$(starship init zsh)"' >>"$HOME/.zshrc"
}
