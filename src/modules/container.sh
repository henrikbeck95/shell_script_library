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

container_manager_container_list_all(){
    $CONTAINER_MANAGER container ls -a
}

container_manager_container_list_running(){
    $CONTAINER_MANAGER ps -a
}

container_manager_container_network_create(){
    podman network create --driver bridge $@
}

container_manager_container_network_remove(){
    podman network rm -f $@
}

container_manager_container_remove(){
	#$CONTAINER_MANAGER --log-level=debug stop $@
    $CONTAINER_MANAGER container stop $@
    $CONTAINER_MANAGER container rm $@
    #$CONTAINER_MANAGER container rm -f $@
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

container_manager_kube_generate_yaml(){
    $CONTAINER_MANAGER generate kube $1 > $2
}

container_manager_kube_play_yaml(){
    $CONTAINER_MANAGER play kube $@
}

container_manager_pod_create(){
	$CONTAINER_MANAGER pod create "$@"
}

container_manager_pod_list_all(){
	$CONTAINER_MANAGER ps -a --pod
}

container_manager_pod_list_running(){
	#$CONTAINER_MANAGER pod list
	$CONTAINER_MANAGER ps --pod
}

container_manager_pod_network_create(){
    podman pod create --net $1 -n $2
}

container_manager_pod_network_remove(){
	podman pod rm -f $@
}

container_manager_pod_pause(){
	$CONTAINER_MANAGER pod pause $@
}

container_manager_pod_remove(){
	$CONTAINER_MANAGER pod stop $@
	$CONTAINER_MANAGER pod rm $@
}

container_manager_pod_run(){
	local NAME_POD=$1
	local NAME_CONTAINER=$2
	local ADDITIONAL_FLAGS=$3
	local REPOSITORY_IMAGE=$4

	echo -e "Connecting containers $2 into the pods $1..."
	#echo -e "S1:\t$1\nS2:\t$2\nS3:\t$3\nS4:\t$4"

    case $# in
        3) 
            $CONTAINER_MANAGER run -d \
                --pod $1 \
                --name $2 \
                $3
            ;;
        4) 
            $CONTAINER_MANAGER run -d \
                --pod $1 \
                --name $2 \
                $3 \
                $4
            ;;
        *) echo -e "ERROR!"
    esac
}

container_manager_pod_run_temporarily(){
	local NAME_POD=$1
	local NAME_CONTAINER=$2
	local ADDITIONAL_FLAGS=$3
	local REPOSITORY_IMAGE=$4

	echo -e "Connecting containers $2 into the pods $1..."
	#echo -e "S1:\t$1\nS2:\t$2\nS3:\t$3\nS4:\t$4"

    case $# in
        3) 
            $CONTAINER_MANAGER run --rm -t -i \
                --pod $1 \
                --name $2 \
                $3 \
				/bin/bash
            ;;
        4) 
            $CONTAINER_MANAGER run --rm -it \
                --pod $1 \
                --name $2 \
                $3 \
                $4 \
				/bin/bash
            ;;
        *) echo -e "ERROR!"
    esac
}

container_manager_pod_start(){
	$CONTAINER_MANAGER pod start $@
}

container_manager_pod_status(){
	#View the current status of the containers running in your pod:
	$CONTAINER_MANAGER pod stats $@
}

container_manager_pod_stop(){
	$CONTAINER_MANAGER pod stop $@
}

container_manager_pod_unpause(){
	$CONTAINER_MANAGER pod unpause $@
}

container_manager_software(){
	#Check if Podman is installed
	case $(util_check_if_software_is_installed "podman") in
		"false")
			#display_message_error "Podman is not installed!"

	        #Check if Docker is installed
			case $(util_check_if_software_is_installed "docker") in
				"false")
                    #display_message_error "Docker is not installed!"
                    :
                    ;;

				"true")
                    #display_message_success "Docker is installed!"
                    echo "docker"
                    ;;
			esac
		;;

		"true")
            #display_message_success "Podman is installed!"
            echo "podman"
            ;;
	esac

	#Organize Math Health setup according to current desktop enviroment
	case $(util_export_desktop_environment) in
		"gnome") : ;;
		"i3")
			:
			#Workspace 01: Visual Studio Code (Math Health - Backend)
			#Workspace 02: Web browser
			#Workspace 03: Visual Studio Code (Math Health - Frontend)
			#Workspace 04: LF || Nautilus || Dolphin || Thunar
			;;
		"plasma") : ;;
		"") : ;;
		*) : ;;
	esac
}