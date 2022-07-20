#############################
#System backup
#############################

#@annotation_must_be_created
system_backup_snaptshot_create() {
	utils_exit_if_user_does_not_have_root_previledges

	local MESSAGE_DESCRIPTION="$1"

	display_message_value_text_default_complex "Creating $BACKUP_TOOL $1 backup"

	case $BACKUP_TOOL in
	"btrfk") display_message_value_status_empty_simple ;;
	"snapper") snapper -c root create -c timeline --description "$MESSAGE_DESCRIPTION" ;; #Remove read only
	"timeshift")
		#Change Timeshift engine
		timeshift --btrfs || timeshift --rsync

		#Create the backup with comments
		timeshift --create --comments "$MESSAGE_DESCRIPTION" --tags D
		;;
	*) display_message_value_status_empty_simple ;;
	esac

	display_message_value_status_success_complex "$BACKUP_TOOL backup $1 has been created"
}

#@annotation_must_be_created
system_backup_snaptshot_delete() {
	utils_exit_if_user_does_not_have_root_previledges

	display_message_value_text_default_complex "Creating $BACKUP_TOOL $1 backup"

	case $BACKUP_TOOL in
	"btrfk") display_message_value_status_empty_simple ;;
	"snapper") display_message_value_status_empty_simple ;;
	"timeshift")
		#Change Timeshift engine
		timeshift --btrfs || timeshift --rsync

		#Create the backup with comments
		timeshift --create --comments "$1" --tags D
		;;
	*) display_message_value_status_empty_simple ;;
	esac

	display_message_value_status_success_complex "$BACKUP_TOOL backup $1 has been created"
}

#@annotation_must_be_created
system_backup_message_help() {
	utils_exit_if_user_does_not_have_root_previledges

	case $BACKUP_TOOL in
	"btrfk") display_message_value_status_empty_simple ;;
	"snapper") display_message_value_status_empty_simple ;;
	"timeshift") timeshift --help ;;
	*) display_message_value_status_empty_simple ;;
	esac
}

#@annotation_must_be_created
system_backup_snapshot_list() {
	utils_exit_if_user_does_not_have_root_previledges

	case $BACKUP_TOOL in
	"btrfk") display_message_value_status_empty_simple ;;
		#"snapper") snapper list ;;
	"snapper") snapper -c root list ;; #root == $USER ;;
	"timeshift") timeshift --list ;;
	*) display_message_value_status_empty_simple ;;
	esac
}

#@annotation_must_be_created
system_backup_snapshot_restore() {
	utils_exit_if_user_does_not_have_root_previledges

	display_message_value_text_default_complex "Restoring $BACKUP_TOOL $1 backup"

	case $BACKUP_TOOL in
	"btrfk") display_message_value_status_empty_simple ;;
	"snapper")
		snapper rollback "$1" #19
		#mount $PARTITION_ROOT /mnt/
		#$EDITOR /mnt/@snapshots/*/info.xml

		#rm -fr /mnt/@/

		#Restoring
		#btrfs subvol snapshots /mnt/@snapshots/2/snapshot /mnt/@/
		#reboot

		#Check
		#btrfs property list -ts /.snapshots/3/snapshot/
		#Set
		#btrfs property set -ts /.snapshots/3/snapshot/ ro false

		#reboot
		;;
	"timeshift") timeshift --restore --snapshot "$1" ;; #timeshift --restore --snapshot '2021-07-09_00-37-36'
	*) display_message_value_status_empty_simple ;;
	esac

	display_message_value_status_success_complex "$BACKUP_TOOL backup $1 has been restored"
}
