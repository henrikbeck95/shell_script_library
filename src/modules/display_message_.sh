#!/usr/bin/env bash

#shellcheck source=/dev/null
. "/usr/local/bin/shell-script-library" || exit

#############################
#Display message
#############################

#display_message_content_line_clear

display_message_position_align_center_complex "Shell Script Library"
display_message_position_align_center_simple "Shell Script Library"

display_message_separator_complex
display_message_separator_simple

#display_message_tabular_number_complex ""
#display_message_tabular_number_number ""

display_message_tabular_text_complex "Henrik:Beck:henrikbeck95@gmail.com\nSomebody:Surname:some_email_address@something.com"
#display_message_tabular_text_complex "$(head -4 /etc/passwd)"
display_message_tabular_text_simple "Henrik:Beck:henrikbeck95@gmail.com\nSomebody:Surname:some_email_address@something.com"
#display_message_tabular_text_simple "$(head -4 /etc/passwd)"

display_message_value_number_complex "123.456"
display_message_value_number_simple "123.456"

#display_message_value_status_empty_center

display_message_value_status_empty_complex
display_message_value_status_empty_simple
#display_message_value_status_error_center "Shell Script Library"
display_message_value_status_error_complex "Shell Script Library"
display_message_value_status_error_simple "Shell Script Library"
#display_message_value_status_success_center "Shell Script Library"
display_message_value_status_success_complex "Shell Script Library"
display_message_value_status_success_simple "Shell Script Library"
#display_message_value_status_warning_center "Shell Script Library"
display_message_value_status_warning_complex "Shell Script Library"
display_message_value_status_warning_simple "Shell Script Library"

#cat() some file.
#display_message_value_text_block_complex "Shell Script Library"
#display_message_value_text_block_simple "Shell Script Library"

display_message_value_text_default_complex "Shell Script Library"
display_message_value_text_default_simple "Shell Script Library"