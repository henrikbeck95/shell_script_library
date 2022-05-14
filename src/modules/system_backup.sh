#############################
#System backup
#############################

#label_must_be_created
system_backup_snaptshot_create(){
	utils_check_if_user_has_root_previledges

	display_message_default_complex "Creating $BACKUP_TOOL $1 backup"

	case $BACKUP_TOOL in
		"btrfk") display_message_empty_simple ;;
		"snapper") snapper -c root create -c timeline --description "$1" ;; #Remove read only
		"timeshift")
			#Change Timeshift engine
			timeshift --btrfs || timeshift --rsync
			
			#Create the backup with comments
			timeshift --create --comments "$1" --tags D
			;;
		*) display_message_empty_simple ;;
	esac

	display_message_success_complex "$BACKUP_TOOL backup $1 has been created"
}

#label_must_be_created
system_backup_snaptshot_delete(){
	utils_check_if_user_has_root_previledges

	display_message_default_complex "Creating $BACKUP_TOOL $1 backup"

	case $BACKUP_TOOL in
		"btrfk") display_message_empty_simple ;;
		"snapper") display_message_empty_simple ;;
		"timeshift")
			#Change Timeshift engine
			timeshift --btrfs || timeshift --rsync
			
			#Create the backup with comments
			timeshift --create --comments "$1" --tags D
			;;
		*) display_message_empty_simple ;;
	esac

	display_message_success_complex "$BACKUP_TOOL backup $1 has been created"
}

#label_must_be_created
system_backup_message_help(){
	utils_check_if_user_has_root_previledges
	
	case $BACKUP_TOOL in
		"btrfk") display_message_empty_simple ;;
		"snapper") display_message_empty_simple ;;
		"timeshift") timeshift --help ;;
		*) display_message_empty_simple ;;
	esac
}

#label_must_be_created
system_backup_snapshot_list(){
	utils_check_if_user_has_root_previledges
	
	case $BACKUP_TOOL in
		"btrfk") display_message_empty_simple ;;
		#"snapper") snapper list ;;
		"snapper") snapper -c root list ;; #root == $USER ;;
		"timeshift") timeshift --list ;;
		*) display_message_empty_simple ;;
	esac
}

#label_must_be_created
system_backup_snapshot_restore(){
	utils_check_if_user_has_root_previledges

	display_message_default_complex "Restoring $BACKUP_TOOL $1 backup"
	
	case $BACKUP_TOOL in
		"btrfk") display_message_empty_simple ;;
		"snapper") snnapper rollback $1 ;; #19
		"timeshift") timeshift --restore --snapshot "$1" ;; #timeshift --restore --snapshot '2021-07-09_00-37-36'
		*) display_message_empty_simple ;;
	esac

	display_message_success_complex "$BACKUP_TOOL backup $1 has been restored"
}