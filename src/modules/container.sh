#############################
#Container
#############################

container_distrobox_image_download(){
	#distrobox-create --name debian10-distrobox --image debian:10
	distrobox-create --name $1 --image $2
}

container_distrobox_image_enter(){
	#distrobox-enter --name debian10-distrobox
	distrobox-enter --name $@
}

container_manager_image_backup(){
	#$CONTAINER_MANAGER save -o $HOME/Desktop/centos.tgz centos:latest
	$CONTAINER_MANAGER save -o $HOME/Desktop/$@.tgz $@
}

container_manager_image_download(){
	$CONTAINER_MANAGER pull $@
}

container_manager_image_execute(){
	$CONTAINER_MANAGER run -it $@
}

container_manager_image_list(){
    $CONTAINER_MANAGER image ls
}

container_manager_image_remove(){
    $CONTAINER_MANAGER image rm $@
}