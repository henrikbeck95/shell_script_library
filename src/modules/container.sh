#############################
#Container
#############################

container_distrobox_image_download() {
	local DISTRO_NICKNAME="$1"
	local DISTRO_NAME_OFFICIAL="$2"

	#distrobox-create --name debian10-distrobox --image debian:10
	distrobox-create --name "$DISTRO_NICKNAME" --image "$DISTRO_NAME_OFFICIAL"
}

container_distrobox_image_enter() {
	local DISTRO_NICKNAME="$1"

	#distrobox-enter --name debian10-distrobox
	distrobox-enter --name "$DISTRO_NICKNAME"
}

container_manager_container_list_all() {
	"$CONTAINER_MANAGER" container ls -a
}

container_manager_container_list_running() {
	"$CONTAINER_MANAGER" ps -a
}

container_manager_container_network_create() {
	"$CONTAINER_MANAGER" network create --driver bridge "$@"
}

container_manager_container_network_remove() {
	"$CONTAINER_MANAGER" network rm -f "$@"
}

container_manager_container_remove() {
	#"$CONTAINER_MANAGER" --log-level=debug stop "$@"
	"$CONTAINER_MANAGER" container stop "$@"
	"$CONTAINER_MANAGER" container rm "$@"
	#"$CONTAINER_MANAGER" container rm -f "$@"
}

container_manager_image_backup() {
	#"$CONTAINER_MANAGER" save -o "$HOME/Desktop/centos.tgz" "centos:latest"
	"$CONTAINER_MANAGER" save -o "$HOME/Desktop/$*.tgz" "$@"
}

container_manager_image_download() {
	"$CONTAINER_MANAGER" pull "$@"
}

container_manager_image_execute() {
	"$CONTAINER_MANAGER" run -it "$@"
}

container_manager_image_list() {
	"$CONTAINER_MANAGER" image ls
}

container_manager_image_remove() {
	"$CONTAINER_MANAGER" image rm "$@"
}

container_manager_kube_generate_yaml() {
	"$CONTAINER_MANAGER" generate kube "$1" >"$2"
}

container_manager_kube_play_yaml() {
	"$CONTAINER_MANAGER" play kube "$@"
}

container_manager_pod_create() {
	"$CONTAINER_MANAGER" pod create "$@"
}

container_manager_pod_list_all() {
	"$CONTAINER_MANAGER" ps -a --pod
}

container_manager_pod_list_running() {
	#"$CONTAINER_MANAGER" pod list
	"$CONTAINER_MANAGER" ps --pod
}

container_manager_pod_network_create() {
	"$CONTAINER_MANAGER" pod create --net "$1" -n "$2"
}

container_manager_pod_network_remove() {
	"$CONTAINER_MANAGER" pod rm -f "$@"
}

container_manager_pod_pause() {
	"$CONTAINER_MANAGER" pod pause "$@"
}

container_manager_pod_remove() {
	"$CONTAINER_MANAGER" pod stop "$@"
	"$CONTAINER_MANAGER" pod rm "$@"
}

container_manager_pod_run() {
	local NAME_POD="$1"
	local NAME_CONTAINER="$2"
	local ADDITIONAL_FLAGS="$3"
	local REPOSITORY_IMAGE="$4"

	display_message_value_status_warning_complex "Connecting containers $2 into the pods $1..."

	case $# in
	3)
		"$CONTAINER_MANAGER" run -d \
			--pod "$NAME_POD" \
			--name "$NAME_CONTAINER" \
			"$ADDITIONAL_FLAGS"
		;;
	4)
		"$CONTAINER_MANAGER" run -d \
			--pod "$NAME_POD" \
			--name "$NAME_CONTAINER" \
			"$ADDITIONAL_FLAGS" \
			"$REPOSITORY_IMAGE"
		;;
	*) display_message_value_status_error_simple "Connection not established" ;;
	esac
}

#@annotation_must_be_improved
container_manager_pod_run_temporarily() {
	local NAME_POD="$1"
	local NAME_CONTAINER="$2"
	local ADDITIONAL_FLAGS="$3"
	local REPOSITORY_IMAGE="$4"

	display_message_value_status_warning_complex "Connecting containers $2 into the pods $1..."

	case $# in
	3)
		"$CONTAINER_MANAGER" run --rm -t -i \
			--pod "$NAME_POD" \
			--name "$NAME_CONTAINER" \
			"$ADDITIONAL_FLAGS" \
			/bin/bash
		;;
	4)
		"$CONTAINER_MANAGER" run --rm -it \
			--pod "$NAME_POD" \
			--name "$NAME_CONTAINER" \
			"$ADDITIONAL_FLAGS" \
			"$REPOSITORY_IMAGE" \
			/bin/bash
		;;
	*) display_message_value_status_error_simple "Connection not established" ;;
	esac
}

container_manager_pod_start() {
	"$CONTAINER_MANAGER" pod start "$@"
}

container_manager_pod_status() {
	#View the current status of the containers running in your pod:
	"$CONTAINER_MANAGER" pod stats "$@"
}

container_manager_pod_stop() {
	"$CONTAINER_MANAGER" pod stop "$@"
}

container_manager_pod_unpause() {
	"$CONTAINER_MANAGER" pod unpause "$@"
}

container_manager_software() {
	case $(util_check_if_software_is_installed "podman") in
	"false")
		case $(util_check_if_software_is_installed "docker") in
		"false") display_message_value_text_default_simple "none" ;;
		"true") display_message_value_text_default_simple "docker" ;;
		esac
		;;

	"true") display_message_value_text_default_simple "podman" ;;
	esac
}
