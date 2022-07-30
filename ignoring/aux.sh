#!/usr/bin/env bash

#fedora
sudo dnf install xorg-x11-drv-amdgpu

#List all files inside a path directory to an external file
ls | grep ".mp3" > ./best_of_november_2020.m3u

#Restore Firefox to an older version
DRI_PRIME=1 firefox

softwareInstall(){
	pip3 install lyrics-in-terminal

	paru -S visual-studio-code-bin
	flatpak install flathub org.libreoffice.LibreOffice -y

	flatpak kill org.kde.juk
}

dotfilesCustom(){
	#MPV
	mkdir -p ~/.config/mpv/
	echo -e "loop-playlist=inf\nloop-file-inf" >  ~/.config/mpv/mpv.conf
}

gitRepositoryClone(){
	git clone https://github.com/henrikbeck95/nova_vision.git
	git clone https://github.com/henrikbeck95/shell_script_library.git
	git clone https://github.com/henrikbeck95/silverarch.git
	git clone https://github.com/henrikbeck95/unicsul.git
	git clone https://github.com/henrikbeck95/numeric_base_converter
}

mappingStorageDisk(){
	ln -sf /run/media/henrikbeck95/Seagate\ Expansion\ Drive/Henrik/music/ $HOME/Music
	ln -sf /run/media/henrikbeck95/Seagate\ Expansion\ Drive/Henrik/videos/ $HOME/Videos
}

#Incomplete
serverLocal(){
	podman pull docker pull vbatts/slackware:14.2
	podman pull docker pull docker.io/vbatts/slackware:14.2
	podman pull docker.io/vbatts/slackware:14.2
	podman run -it --name my_slackware docker.io/vbatts/slackware:14.2
	podman run -it -p 8022:8022 --name my_ssh_server ubuntu:latest bash

	vim ~/.local/share/keyrings/user.keystore
	vim ~/.local/share/keyrings/login.keyring
}

#Incomplete
projectVAL(){
	locale -a
	export LC_ALL=C.UTF-8

	pip list | grep "pyaudio"
	conda list | grep "pyaudio"
	python3 --version
	export LC_ALL=C.UTF-8 && asdf install python 3.6-dev
	asdf list-all python
	python3 ./get-pip.py
	pip list
}