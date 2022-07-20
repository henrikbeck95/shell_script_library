#############################
#System menory
#############################

system_memory_clear_cache(){
    utils_exit_if_user_does_not_have_root_previledges
    
    local CLEANLINESS_LEVEL="$1"

    case "$CLEANLINESS_LEVEL" in
        "soft")
            #Clear PageCache only (recommended in production).
            sync;
	        echo 1 > /proc/sys/vm/drop_caches
            ;;
        "moderate")
            #Clear dentries and inodes.
            sync;
            echo 2 > /proc/sys/vm/drop_caches
            ;;
        "aggressive")
            #Clear PageCache, dentries and inodes (not recommended in production)
            sync;
	        echo 3 > /proc/sys/vm/drop_caches
            ;;
        *) display_message_value_status_empty_simple ;;
    esac

    #One single line on terminal
    #sudo sh -c 'echo 1 > /proc/sys/vm/drop_caches'
    #echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh
}

system_memory_clear_swap(){
    utils_exit_if_user_does_not_have_root_previledges

    swapoff -a && swapon -a
}

system_memory_generate_file_log_before(){
    local DATE_CURRENT=$(date)
    local FILE_MEMORY_LOG="/tmp/my_memory.log"

    display_message_value_status_success_complex "$DATE_CURRENT" >> "$FILE_MEMORY_LOG"
	free -h >> "$FILE_MEMORY_LOG"
}

system_memory_generate_file_log_after(){
    local FILE_MEMORY_LOG="/tmp/my_memory.log"

    free -h >> "$FILE_MEMORY_LOG"
}

#@annotation_must_be_improved
system_memory_schedule(){
    utils_exit_if_user_does_not_have_root_previledges

    local CLEANLINESS_LEVEL="$1"
    local DATE_CURRENT=$(date)
    local MESSAGE_CLEAR_MEMORY="Cache memory has been clered at $DATE_CURRENT."

    system_memory_generate_file_log_before
    
    system_memory_clear_cache "$CLEANLINESS_LEVEL"
    #system_memory_clear_swap

    system_memory_generate_file_log_after

    #Testing (troubleshoot)
    display_notification_normal "$MESSAGE_CLEAR_MEMORY" #|| display_message_value_status_success_complex "$MESSAGE_CLEAR_MEMORY"
}