#############################
#System backup
#############################

#label_must_be_created_
system_backup_snaptshot_create(){
	util_check_if_user_has_root_previledges

	#display_message_default "Creating $BACKUP_TOOL $1 backup"
	#display_message_success "$BACKUP_TOOL backup $1 has been created"

	case $BACKUP_TOOL in
		"btrfk") display_message_empty ;;
		"snapper") snapper -c root create -c timeline --description "$1" ;; #Remove read only
		"timeshift")
			timeshift --btrfs #Change Timeshift engine
			timeshift --create --comments "$1" --tags D
			;;
		*) display_message_empty ;;
	esac
}

#label_must_be_created_
system_backup_snaptshot_delete(){
	util_check_if_user_has_root_previledges

	#display_message_default "Creating $BACKUP_TOOL $1 backup"
	#display_message_success "$BACKUP_TOOL backup $1 has been created"

	case $BACKUP_TOOL in
		"btrfk") display_message_empty ;;
		"snapper") : ;;
		"timeshift")
			timeshift --btrfs #Change Timeshift engine
			timeshift --create --comments "$1" --tags D
			;;
		*) display_message_empty ;;
	esac
}

#label_must_be_created_
system_backup_message_help(){
	util_check_if_user_has_root_previledges
	
	case $BACKUP_TOOL in
		"btrfk") display_message_empty ;;
		"snapper") display_message_empty ;;
		"timeshift") timeshift --help ;;
		*) display_message_empty ;;
	esac
}

#label_must_be_created_
system_backup_snapshot_list(){
	util_check_if_user_has_root_previledges
	
	case $BACKUP_TOOL in
		"btrfk") display_message_empty ;;
		#"snapper") snapper list ;;
		"snapper") snapper -c root list ;; #root == $USER ;;
		"timeshift") timeshift --list ;;
		*) display_message_empty ;;
	esac
}

#label_must_be_created_
system_backup_snapshot_restore(){
	util_check_if_user_has_root_previledges
	
	case $BACKUP_TOOL in
		"btrfk") display_message_empty ;;
		"snapper") snnapper rollback $1 ;; #19
		"timeshift") timeshift --restore --snapshot "$1" ;; #timeshift --restore --snapshot '2021-07-09_00-37-36'
		*) display_message_empty ;;
	esac
}