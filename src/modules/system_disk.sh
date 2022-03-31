#############################
#System disk
#############################

system_disk_partition_format_fat32(){
	mkfs.fat -F32 $1
	#mkfs.fat -F32 -n ESP $1
	#mkfs.fat -F32 -n BOOT $1
}

system_disk_partition_format_btrfs(){
	mkfs.btrfs -f $1
	#mkfs.btrfs -f -L ROOT $PARTITION_ROOT
	#mkfs.btrfs -L data /dev/sdb1
	#mkfs.btrfs -L mylabel /dev/partition
	#mkfs.btrfs -L mylabel -n 32k /dev/partition
}

system_disk_partition_format_ext4(){
	mkfs.ext4 -f $1
	#mkfs.ext4 -f -L FILES $1
}

system_disk_partition_list_all(){
	lsblk
}

#system_disk_partition_mount(){}

#label_must_be_fixed
system_disk_partition_mount_btrfs(){
	local PARTITION_DISK_BOOT=$1
	local PARTITION_DISK_ROOT=$2

	display_message_default "Mount the partitions"

	#Mounting the root partition
	mount $PARTITION_DISK_ROOT /mnt/

	#Creating subvolumes for BTRFS
	btrfs su cr /mnt/@/

	btrfs su cr /mnt/@home/ #Testing
	btrfs su cr /mnt/@var/ #Testing
	btrfs su cr /mnt/@snapshots/ #Testing

	#Mounting root subvolume
	umount /mnt/
	#mount -o compress=lzo,subvol=@ $PARTITION_DISK_ROOT /mnt/
	mount -o noatime,compress=lzo,space_cache,subvol=@ $PARTITION_DISK_ROOT /mnt/
	
	system_disk_partition_list_all

	#Mounting boot
	case $IS_BIOS_UEFI in
		"legacy") 
			#label_must_be_fixed
			#mkdir -p /mnt/boot/
			#mount $PARTITION_DISK_BOOT /mnt/boot/

			display_message_error "
			Sorry but I do not how to install GRUB on BIOS legacy machine
			If you know how, please inform the developer the procedure for implementing it.
			For now, the commands must be implemented manually
			Do not worry, this is the last step to be done."

			exit 0
			;;
		"uefi") 
			#mkdir -p /mnt/boot/efi/
			mkdir -p /mnt/{boot,home,var,.snapshots}/
			
			#Tesitng
			mount -o noatime,compress=lzo,space_cache,subvol=@home $PARTITION_DISK_ROOT /mnt/home/
			mount -o noatime,compress=lzo,space_cache,subvol=@var $PARTITION_DISK_ROOT /mnt/var/
			mount -o noatime,compress=lzo,space_cache,subvol=@snapshots $PARTITION_DISK_ROOT /mnt/.snapshots/
			
			#mount $PARTITION_DISK_BOOT /mnt/boot/efi/
			mount $PARTITION_DISK_BOOT /mnt/boot/
			;;
		*)
			display_message_error "The BIOS could not be identified!"
			exit 0
			;;
	esac

	system_disk_partition_list_all
}

system_disk_partition_management(){
	display_message_default "Make the partitions"

	#Creating the partitions
	while true; do
		cfdisk $1

		read -p "Do you want to procedure? [Y/n] " QUESTION_PARTITION
		case $QUESTION_PARTITION in
			[Yy]*) break ;;
			[Nn]*) : ;;
			*) display_message_default "Please answer Y for yes or N for no." ;;
		esac
	done
}

system_disk_swap_ask(){
	display_message_default "Create the SWAP"

	while true; do
		read -p "Inform what you want: [file/partition/skip] " QUESTION_SWAP

		case $QUESTION_SWAP in
			"file") system_disk_swap_file ;;
			"partition") system_disk_swap_partition ;;
			"skip") break ;;
			*) display_message_default "Please answer file or partition." ;;
		esac
	done
}

#label_must_be_fixed
#Create a Swap file implementation to BTRFS
system_disk_swap_file(){
	util_check_if_user_has_root_previledges

	display_message_default "Creating the SWAP file"

	truncate -s 0 /swap/swapfile
	chattr +C /swap/swapfile
	btrfs property set /swap/swapfile compression none

	#Set 4 GB size to Swap file
	dd if=/dev/zero of=/swap/swapfile bs=4G count=2 status=progress
	
	#Give the right permissions to the swap file
	chmod 600 /swap/swapfile
	mkswap /swap/swapfile
	swapon /swap/swapfile

	#Enable the Swap file on boot
	display_message_default "\n#Swapfile\n/swap/swapfile none swap defaults 0 0" >> /etc/fstab
	
	#Check /etc/fstab file
	util_edit_file /etc/fstab #text

	display_message_success "SWAP file has been created"
}

system_disk_swap_partition(){
	util_check_if_user_has_root_previledges

	display_message_default "Creating the SWAP partition"

	mkswap -f $PARTITION_SWAP
	swapon $PARTITION_SWAP

	display_message_success "SWAP partition has been created"
}