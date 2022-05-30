#############################
#System sound
#############################

system_sound_voice_speech_text_complex() {
    #system_sound_voice_speech_text_complex "Say something"

    local VALUE_SPEECH="$*"

    display_notification_normal "$VALUE_SPEECH"
    system_sound_voice_speech_text_simple "$VALUE_SPEECH"
}

system_sound_voice_speech_text_simple() {
    #system_sound_voice_speech_text_simple "Say something"

    local VALUE_SPEECH=$1

    case $(utils_check_if_software_is_installed "festival") in
    "false") display_message_value_status_error_simple "Festival is not installed" ;;
        #"true") festival <<< '(SayText "Say anything")' ;;
        #"true") festival <<< "(SayText \"$VALUE_SPEECH\")" ;;
    "true") echo "(SayText \"$VALUE_SPEECH\")" | festival ;;
    esac
}
