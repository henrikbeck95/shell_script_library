#############################
#System audio
#############################

#WARNING!
#When display_message_debug_system_audio is uncommented many problems may occour. Be sure to comment it right after identify if the coreect values are set

#AUX_DBUS_DOMAIN="org.mpris.MediaPlayer2"
#AUX_DBUS_PATH="/org/mpris/MediaPlayer2"

system_audio_dbus_command_send(){
    local DBUS_OVERRIDE="$1"
    local DBUS_DOMAIN="$2"
    local DBUS_PATH="$3"
    local DBUS_PLAYER="$4"
    local DBUS_CMD="$5"

	#display_message_debug_system_audio "$DBUS_DOMAIN" "$DBUS_PATH" "$DBUS_PLAYER" "$DBUS_CMD"

	#system_audio_dbus_software_process "$DBUS_PLAYER"

    #Check if a media player is running on DBUS
    if [[ $(system_audio_dbus_player_running_current) != "none" ]]; then
        dbus-send --print-reply \
            --dest=${DBUS_DOMAIN}.${DBUS_PLAYER} \
            ${DBUS_PATH} \
            ${DBUS_CMD} || \
                display_message_value_status_error_simple "Any media player is running on DBUS now1"
    else
        #Check if command has permission to override this lock system
        case "$DBUS_OVERRIDE" in
            "true")
                dbus-send --print-reply \
                    --dest=${DBUS_DOMAIN}.${DBUS_PLAYER} \
                    ${DBUS_PATH} \
                    ${DBUS_CMD} || \
                        display_message_value_status_error_simple "Any media player is running on DBUS now2"
                ;;
            "false") display_message_value_status_error_simple "Any media player is running on DBUS" ;;
        esac
    fi
}

system_audio_dbus_player_control_action(){
    local DBUS_DOMAIN="$1"
    local DBUS_PATH="$2"
    local DBUS_PLAYER="$3"
	local DBUS_ACTION="$4"
    local DBUS_OVERRIDE="true"
	local DBUS_CMD

    case "$DBUS_ACTION" in
        "play" | "pause") DBUS_CMD="org.mpris.MediaPlayer2.Player.PlayPause" ;;
        "previous") DBUS_CMD="org.mpris.MediaPlayer2.Player.Previous" ;;
        "next") DBUS_CMD="org.mpris.MediaPlayer2.Player.Next" ;;
        "skip-backward") DBUS_CMD="org.mpris.MediaPlayer2.Player.Seek int64:-2000000" ;;
        "skip-forward") DBUS_CMD="org.mpris.MediaPlayer2.Player.Seek int64:2000000" ;;
        *) display_message_value_status_error_simple "Invalid option for DBUS command!"
    esac

    #display_message_debug_system_audio "$DBUS_DOMAIN" "$DBUS_PATH" "$DBUS_PLAYER" "$DBUS_CMD"

    system_audio_dbus_command_send "$DBUS_OVERRIDE" "$DBUS_DOMAIN" "$DBUS_PATH" "$DBUS_PLAYER" "$DBUS_CMD"
}

#MUST BE IMPROVED
system_audio_dbus_player_running_current(){
    local ARRAY_MEDIA_PLAYER=()
    local RESULT

    #QDbus method
    #MEDIA_PLAYER_LIST=$(qdbus | grep -E -i 'org.mpris.MediaPlayer2|plasma.browser_integration')

    #DBUS method
    MEDIA_PLAYER_LIST=$(dbus-send --session \
        --dest=org.freedesktop.DBus \
        --type=method_call \
        --print-reply=literal \
        /org/freedesktop/DBus \
        org.freedesktop.DBus.ListNames \
            | tr ' ' '\n' \
            | grep 'org.mpris.MediaPlayer2')

    #Attribute all the media players path to an array list
    for i in $MEDIA_PLAYER_LIST; do
        #if [[ $(qdbus "$i" /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus) == 'Playing' ]]; then

        #Ignoring if the browser player
        case "$i" in
            *"org.mpris.MediaPlayer2.firefox"*) 
                #:
                #echo -e "Skipping $i..."
                ;;
            *)
                #echo -e "Saving $i..."
                ARRAY_MEDIA_PLAYER+=( "$i" )
                ;;
        esac
		#fi
    done

    #Check if the media player list is empty
    case $(array_check_if_is_empty "${ARRAY_MEDIA_PLAYER[@]}") in
        "false") RESULT="${ARRAY_MEDIA_PLAYER[*]}" ;;
        #"false") RESULT="${ARRAY_MEDIA_PLAYER[0]}" ;;
        #"false") RESULT="${ARRAY_MEDIA_PLAYER[1]}" ;;
        "true") RESULT="none" ;;
    esac

    echo "$RESULT"
}

system_audio_dbus_player_volume_current(){
    local DBUS_DOMAIN="$1"
    local DBUS_PATH="$2"
    local DBUS_PLAYER="$3"
    local DBUS_OVERRIDE="true"
    local DBUS_CMD="org.freedesktop.DBus.Properties.Get string:${DBUS_DOMAIN}.Player string:Volume"
	local DBUS_META
    local DBUS_VOLUME_VALUE_CURRENT
	
    DBUS_META=$(system_audio_dbus_command_send "$DBUS_OVERRIDE" "$DBUS_DOMAIN" "$DBUS_PATH" "$DBUS_PLAYER" "$DBUS_CMD" )

	#Extract the value from:
	#method return time=1632021102.487198 sender=:1.14763 -> destination=:1.19271 serial=4581 reply_serial=2
	#variant       double 1
	DBUS_VOLUME_VALUE_CURRENT=$( \
		echo "$DBUS_META" \
        | sed -n '2 p' \
        | awk '{print $3}' \
        )
        
    #display_message_debug_system_audio "$DBUS_DOMAIN" "$DBUS_PATH" "$DBUS_PLAYER" "$DBUS_CMD"

    echo "$DBUS_VOLUME_VALUE_CURRENT"
}

system_audio_dbus_player_volume_action(){
    local DBUS_DOMAIN="$1"
    local DBUS_PATH="$2"
    local DBUS_PLAYER="$3"
	local DBUS_ACTION="$4"
    local DBUS_OVERRIDE="true"
    local DBUS_VOLUME_DIFF="0.1"
	local DBUS_CMD
    local DBUS_VOLUME_VALUE_CURRENT
    local DBUS_VOLUME_VALUE_NEWEST

    DBUS_VOLUME_VALUE_CURRENT=$(system_audio_dbus_player_volume_current "$DBUS_DOMAIN" "$DBUS_PATH" "$DBUS_PLAYER")

    case "$DBUS_ACTION" in
        "decrease") DBUS_VOLUME_VALUE_NEWEST=$(math_calculator "$DBUS_VOLUME_VALUE_CURRENT - $DBUS_VOLUME_DIFF") ;;
        "normal") DBUS_VOLUME_VALUE_NEWEST="1.0" ;;
        "increase") DBUS_VOLUME_VALUE_NEWEST=$(math_calculator "$DBUS_VOLUME_VALUE_CURRENT + $DBUS_VOLUME_DIFF") ;;
        *) display_message_value_status_error_simple "Invalid option for DBUS command!"
    esac

    DBUS_CMD="org.freedesktop.DBus.Properties.Set string:${DBUS_DOMAIN}.Player string:Volume variant:double:$DBUS_VOLUME_VALUE_NEWEST"
	
    #Debugging values
    #echo -e "Value before:\t$DBUS_VOLUME_VALUE_CURRENT"
    #echo -e "Value after:\t$DBUS_VOLUME_VALUE_NEWEST"

    #display_message_debug_system_audio "$DBUS_DOMAIN" "$DBUS_PATH" "$DBUS_PLAYER" "$DBUS_CMD"
   
    system_audio_dbus_command_send "$DBUS_OVERRIDE" "$DBUS_DOMAIN" "$DBUS_PATH" "$DBUS_PLAYER" "$DBUS_CMD"
}

system_audio_dbus_software_player(){
    local MEDIA_PLAYER_CURRENT_RUNNING_MPRIS
    local RESULT
    
    MEDIA_PLAYER_CURRENT_RUNNING_MPRIS=$(system_audio_dbus_player_running_current)

    #org.mpris.MediaPlayer2.vlc -> vlc or any other current player name
    #RESULT="${MEDIA_PLAYER_CURRENT_RUNNING_MPRIS##*.}"
    RESULT=$(string_remove_text_from_output "$MEDIA_PLAYER_CURRENT_RUNNING_MPRIS" "org.mpris.MediaPlayer2.")

    #Return possibilities 'none', 'audacious', 'org.gnome.Music', 'spotify', 'vlc', etc.
    echo "$RESULT"
}

system_audio_dbus_software_process(){
    local DBUS_PLAYER="$1"
    local PROCESS_RUNNING

    PROCESS_RUNNING=$(pgrep -x "$DBUS_PLAYER")

    #Check if the process is running
	if [[ ! $PROCESS_RUNNING ]]; then
		display_message_value_text_default_simple "-"
		exit
	fi
}

system_audio_dbus_status_all_json(){
    local DBUS_DOMAIN="$1"
    local DBUS_PATH="$2"
	local DBUS_CMD="org.freedesktop.DBus.Properties.Get string:${DBUS_DOMAIN}.Player string:Metadata"
    #local DBUS_OVERRIDE="false"
    local DBUS_OVERRIDE="true"
    local DBUS_PLAYER
	local DBUS_META
    local RESULT
    
    DBUS_PLAYER=$(system_audio_dbus_software_player)

    #display_message_debug_system_audio "$DBUS_DOMAIN" "$DBUS_PATH" "$DBUS_PLAYER" "$DBUS_CMD"

    RESULT=$(system_audio_dbus_command_send "$DBUS_OVERRIDE" "$DBUS_DOMAIN" "$DBUS_PATH" "$DBUS_PLAYER" "$DBUS_CMD")

	echo "$RESULT"
}

system_audio_dbus_status_media_current_time(){
    local DBUS_DOMAIN="$1"
    local DBUS_PATH="$2"
    local DBUS_CMD
    local DBUS_OVERRIDE="true"
    local DBUS_PLAYER
    local AUX_REQUEST
    local AUX_FILTERED

    DBUS_PLAYER=$(system_audio_dbus_software_player)

    DBUS_CMD="org.freedesktop.DBus.Properties.Get string:${DBUS_DOMAIN}.Player string:Position"

    AUX_REQUEST=$(system_audio_dbus_command_send "$DBUS_OVERRIDE" "$DBUS_DOMAIN" "$DBUS_PATH" "$DBUS_PLAYER" "$DBUS_CMD")

    #Get the following values from request
    #method return time=1658815730.184013 sender=:1.251 -> destination=:1.575 serial=616 reply_serial=2
    #variant       int64 5613578

    AUX_FILTERED=$(echo "$AUX_REQUEST" | grep "int64" | awk '{print $3}')

    case $(utils_check_if_variable_is_null "$AUX_FILTERED") in
        "false") 
            #RESULT=$((AUX_FILTERED / 1000000))
            RESULT=$(math_converter_time_from_microseconds_to_seconds "$AUX_FILTERED")
            ;;
        "true") RESULT=-1 ;;
    esac

    display_message_value_number_simple "$RESULT"
}

system_audio_dbus_status_media_current_metadata(){
    #system_audio_dbus_status_media_current_metadata "album"
    #system_audio_dbus_status_media_current_metadata "artist"
    #system_audio_dbus_status_media_current_metadata "title"
    #system_audio_dbus_status_media_current_metadata "year"

	local TAG_NAME="$1"
    local PATH_FILE
    local RESULT

    case $(utils_check_if_variable_exists "$TAG_NAME") in
        "false") display_message_value_status_error_simple "There is no tag name parameter informed." ;;
        "true")
            PATH_FILE=$(system_audio_dbus_status_media_current_path)

            RESULT=$(utils_file_music_metadata_tag_value_read_single \
                "$PATH_FILE" \
                "$TAG_NAME")
            
            echo "$RESULT"
            ;;
    esac
}

#MUST BE IMPROVED
system_audio_dbus_status_playback(){
    local MEDIA_PLAYER
    local RESULT
    
    #MEDIA_PLAYER="org.mpris.MediaPlayer2.vlc"
    MEDIA_PLAYER=$(system_audio_dbus_player_running_current)

    #qdbus \
    #    org.mpris.MediaPlayer2.${MEDIA_PLAYER} \
    #    /org/mpris/MediaPlayer2 \
    #    org.mpris.MediaPlayer2.Player.PlaybackStatus
                #--dest=org.mpris.MediaPlayer2.vlc \
    
    RESULT=$(
        dbus-send --print-reply \
            --dest=${MEDIA_PLAYER} \
            /org/mpris/MediaPlayer2 \
            org.freedesktop.DBus.Properties.Get \
            string:'org.mpris.MediaPlayer2.Player' \
            string:'PlaybackStatus' \
                | grep -E -A 1 "string" \
                | cut -b 26- \
                | cut -d '"' -f 1 \
                | grep -E -v ^$
        )
    
    #Return status can be: Playing, Paused or Stopped
    echo "$RESULT"
}

system_audio_dbus_status_media_current_path(){
    local MEDIA_PLAYER_CURRENT_RUNNING_MPRIS
    local MEDIA_PLAYER_CURRENT_RUNNING_NAME
    local MEDIA_PLAYER_PROCESS_INFO_ALL
    local AUX
    local RESULT

    #MEDIA_PLAYER_CURRENT_RUNNING_MPRIS="org.mpris.MediaPlayer2.vlc"
    #MEDIA_PLAYER_CURRENT_RUNNING_MPRIS="org.mpris.MediaPlayer2.org.gnome.Music"
    MEDIA_PLAYER_CURRENT_RUNNING_MPRIS=$(system_audio_dbus_player_running_current)
    
    MEDIA_PLAYER_CURRENT_RUNNING_NAME=$(system_audio_dbus_software_player)

    MEDIA_PLAYER_PROCESS_INFO_ALL=$(lsof -wc "$MEDIA_PLAYER_CURRENT_RUNNING_NAME" | awk '$4~"[0-9]r" && $5=="REG"')

    AUX=$(echo "$MEDIA_PLAYER_PROCESS_INFO_ALL" | grep -o '/.*') #Full path
    #AUX=$(echo "$MEDIA_PLAYER_PROCESS_INFO_ALL" | grep -o '[^/]*$') #File name with extension

    #...string "file: /tmp/origin/Nine/Be_Italian.mp3"
    RESULT=$(echo "$AUX" | head -n 1)

    echo "$RESULT"
}