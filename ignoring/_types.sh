#!/usr/bin/env sh

##############################
#Import Shell Script Library
##############################

if [[ -f /usr/local/bin/shell-script-library ]]; then #For host applications
    PATH_SHELL_SCRIPT_LIBRARY_COMPILER="/home/henrikbeck95/eclipse-workspace/shell_script_library/src/compiler.sh"
    PATH_SHELL_SCRIPT_LIBRARY_DESTINY="/usr/local/bin/shell-script-library"
    PATH_SHELL_SCRIPT_LIBRARY_ORIGIN="/home/henrikbeck95/eclipse-workspace/shell_script_library/src/shell-script-library"
    PATH_SHELL_SCRIPT_LIBRARY_URL=""
elif [[ -f /run/host/usr/local/bin/shell-script-library ]]; then #For Flatpak applications
    PATH_SHELL_SCRIPT_LIBRARY_COMPILER="/run/host/home/henrikbeck95/eclipse-workspace/shell_script_library/src/compiler.sh"
    PATH_SHELL_SCRIPT_LIBRARY_DESTINY="/run/host/usr/local/bin/shell-script-library"
    PATH_SHELL_SCRIPT_LIBRARY_ORIGIN="/run/host/home/henrikbeck95/eclipse-workspace/shell_script_library/src/shell-script-library"
    PATH_SHELL_SCRIPT_LIBRARY_URL=""
fi

source $PATH_SHELL_SCRIPT_LIBRARY_DESTINY

#clear && /run/host/eclipse-workspace/shell_script_library/src/modules/_types.sh
#--filesystem=host
#flatpak-spawn --host
#/run/host/usr/local/bin/lf

##############################
#Declaring variables
##############################

##############################
#Analisador sintático
##############################

#syntactic_analyzer_set_variable_value_boolean "Henrik Beck"           #false
#syntactic_analyzer_set_variable_value_boolean "false"                 #true
#syntactic_analyzer_set_variable_value_boolean "true"                  #true
#syntactic_analyzer_set_variable_value_boolean "Lalala"                #false
#syntactic_analyzer_set_variable_value_boolean "1995"                 #false
#syntactic_analyzer_set_variable_value_boolean ""                     #false

#syntactic_analyzer_set_variable_value_char "Henrik Beck"              #false
#syntactic_analyzer_set_variable_value_char "henrikbeck95@gmail.com"   #false
#syntactic_analyzer_set_variable_value_char "1995"                     #false
#syntactic_analyzer_set_variable_value_char "1"                        #true
#syntactic_analyzer_set_variable_value_char ">"                        #true
#syntactic_analyzer_set_variable_value_char ""                         #false

#syntactic_analyzer_set_variable_value_float "Henrik Beck"             #false
#syntactic_analyzer_set_variable_value_float "3"                       #true
#syntactic_analyzer_set_variable_value_float "-3"                      #true
#syntactic_analyzer_set_variable_value_float "3.14"                    #true
#syntactic_analyzer_set_variable_value_float "-3.14"                   #true
#syntactic_analyzer_set_variable_value_float "3A14"                    #false
#syntactic_analyzer_set_variable_value_float ""                        #

#syntactic_analyzer_set_variable_value_int "Henrik Beck"               #false
#syntactic_analyzer_set_variable_value_int "3"                         #true
#syntactic_analyzer_set_variable_value_int "-3"                        #true
#syntactic_analyzer_set_variable_value_int "3.14"                      #false
#syntactic_analyzer_set_variable_value_int "-3.14"                     #false
#syntactic_analyzer_set_variable_value_int "3A14"                      #false
#syntactic_analyzer_set_variable_value_int ""                          #false

#syntactic_analyzer_set_variable_value_object "Henrik Beck"               #true
#syntactic_analyzer_set_variable_value_object "henrikbeck95@gmail.com"    #true
#syntactic_analyzer_set_variable_value_object "1995"                      #true
#syntactic_analyzer_set_variable_value_object "1"                         #true
#syntactic_analyzer_set_variable_value_object ">"                         #true
#syntactic_analyzer_set_variable_value_object ""                          #false
#syntactic_analyzer_set_variable_value_object "true"                      #true

#syntactic_analyzer_set_variable_value_string "Henrik Beck"               #true
#syntactic_analyzer_set_variable_value_string "henrikbeck95@gmail.com"    #true
#syntactic_analyzer_set_variable_value_string "1995"                      #false
#syntactic_analyzer_set_variable_value_string "1"                         #false
#syntactic_analyzer_set_variable_value_string ">"                         #true
#syntactic_analyzer_set_variable_value_string ""                          #false
#syntactic_analyzer_set_variable_value_string "true"                      #false

function syntactic_analyzer_generate_command() {
    local VARIABLE_WITHOUT_SPACES=$(string_remove_empty_space_all $@)
    local VARIABLE_NAME="$(syntactic_analyzer_set_variable_name $VARIABLE_WITHOUT_SPACES)"
    local VARIABLE_VALUE="$(syntactic_analyzer_set_variable_value_int $VARIABLE_WITHOUT_SPACES)"
    local VARIABLE_LABEL="${VARIABLE_NAME}=${VARIABLE_VALUE}"

    #echo -e "\nTrying... ${VARIABLE_LABEL}\n"

    #display_message_value_text_default_simple "eval declare -i $VARIABLE_LABEL"

    # display_message_value_text_default_simple "local $VARIABLE_LABEL"
    # display_message_value_text_default_simple "declare -i $VARIABLE_LABEL"
    # display_message_value_text_default_simple "declare $VARIABLE_LABEL"
    echo "declare $VARIABLE_LABEL"
    # display_message_value_text_default_simple "$VARIABLE_LABEL"

    #eval declare -i "$VARIABLE_LABEL"
    # eval declare -ig "$VARIABLE_LABEL"
}

# alias dockereval='eval $(docker-machine env)'

# alias 'boolean'="syntactic_analyzer_set_variable_value_boolean $1"
# alias 'char'="syntactic_analyzer_set_variable_value_char $1"

# alias 'int'='eval $(syntactic_analyzer_generate_command ${VALUE_VARIABLE//[[:space:]]/})'
# alias 'int'='eval syntactic_analyzer_generate_command $@'
# alias 'int'='syntactic_analyzer_generate_command $@'
# alias 'int'='eval $(syntactic_analyzer_generate_command $@)'
# alias 'int'='eval declare -i syntactic_analyzer_generate_command $@'
# alias 'int'='eval declare -i $(syntactic_analyzer_generate_command $@)'
# eval alias 'int'='declare -i $(syntactic_analyzer_generate_command $@)'
# eval alias bar=\"echo $foo\"
# eval alias int=\"declare -i $(syntactic_analyzer_generate_command $@)\"
# eval alias int=\"declare -i syntactic_analyzer_generate_command $@\"

# eval alias int=\"syntactic_analyzer_generate_command $@\"
# eval alias int="\"syntactic_analyzer_generate_command $@\""

#eval $'alias int=syntactic_analyzer_generate_command $@'

# eval "$(syntactic_analyzer_generate_command 'testando = 0000')"
# echo "ESTE AQUI É O TESTANDO: $testando"

# alias 'int'='eval "$(syntactic_analyzer_generate_command $@)"'

#  alias int="eval \$(syntactic_analyzer_generate_command $@)"

# alias dockereval='eval $(docker-machine env)'
# alias int='eval $(syntactic_analyzer_generate_command $@)'

# eval alias bar="echo bar"
# eval alias bar=echo bar
# eval alias bar="\"echo foo\""
# bar

# ( syntactic_analyzer_generate_command $@ )
# alias 'int'='( eval syntactic_analyzer_generate_command $@ )'

#alias 'int'="syntactic_analyzer_set_variable_value_int $1"

#alias 'int'="eval declare syntactic_analyzer_set_variable_name syntactic_analyzer_set_variable_value_int $1"
#alias 'int'='eval echo "zzz $(syntactic_analyzer_generate_command $@)"'

# echo "vvv $(syntactic_analyzer_set_variable_name 'numero = 7777') www $(syntactic_analyzer_set_variable_value_int 'numero = 7777')"

# echo -e "vai... $(syntactic_analyzer_set_variable_name numero = 7777) indo $(syntactic_analyzer_set_variable_value_int numero = 7777) foi..."

# alias 'int'="$(syntactic_analyzer_generate_command ${@//[[:space:]]/})"

# alias 'int'='echo -e "vai... $(syntactic_analyzer_set_variable_name numero = 7777) indo $(syntactic_analyzer_set_variable_value_int numero = 7777) foi..."'
# alias 'int'='echo -e "$(syntactic_analyzer_set_variable_name numero = 7777) $(syntactic_analyzer_set_variable_value_int numero = 7777)"'

#alias 'int'='echo Antes $@'

# alias 'int'="eval echo zzz $(syntactic_analyzer_set_variable_name $@) yyy $(syntactic_analyzer_set_variable_value_int $@)"

#alias 'int'='eval echo -i syntactic_analyzer_generate_command $@'
# alias 'int'='eval declare $(syntactic_analyzer_generate_command $@) 2&> /dev/null'

#syntactic analyzer

# alias 'object'="syntactic_analyzer_set_variable_value_object $1"
# alias 'string'="syntactic_analyzer_set_variable_value_string $1"

# syntactic_analyzer_generate_command numeric=1000
# syntactic_analyzer_generate_command numeric = 2000

#export -f int

function my_function() {
    int numeric=2022
    int algumaCoisa = 4321
    # object anything="This is an object"
    # string text="This is a string"

    echo "Inside function: $numeric"
    echo "Before function: $algumaCoisa"
    # echo "Inside function: $anything"
    # echo "Inside function: $text"
}

# syntactic_analyzer_generate_command aaaa = 9999
# echo

# display_message_separator_complex

%
int numeric=1995
echo
int algumaCoisa = 1234
echo
# object anything="This is an generic"
# string text="This is a text"

echo "Before function: $numeric"
echo "Before function: $algumaCoisa"
echo "Before function: $errando"
%%

# echo "Before function: $anything"
# echo "Before function: $text"

# display_message_separator_complex

# my_function

# display_message_separator_complex

# echo "After function: $numeric"
# echo "Before function: $algumaCoisa"
# echo "After function: $anything"
# echo "After function: $text"

#echo -e "$(string_get_content_signal_before '=' 'testing=1234')"
#echo -e "$(string_get_content_signal_before '=' 'testing = 1234')"
#echo -e "$(string_get_content_signal_after '=' 'testing=1234')"
#echo -e "$(string_get_content_signal_after '=' 'testing = 1234')"

utils_effects_bar_progress_status_fill_using_characters() {
    local COUNTDOWN_START=1
    local COUNTDOWN_END=100

    utils_effects_bar_progress_aux() {
        local COUNTDOWN_START=1
        local COUNTDOWN_END=100

        #Process data
        let _progress=(${1} * 100 / ${2} * 100)/100
        let _done=(${_progress} * 4)/10
        let _left=40-$_done

        #Build progressbar string lengths
        local _fill=$(printf "%${_done}s")
        local _empty=$(printf "%${_left}s")

        #Build progressbar strings and print the bar_progress line
        printf "\rProgress : [${_fill// /#}${_empty// /-}] ${_progress}%%"
    }

    for i in $(seq ${COUNTDOWN_START} ${COUNTDOWN_END}); do
        sleep 0.01
        utils_effects_bar_progress_aux ${i} ${COUNTDOWN_END}
    done

    printf '\nFinished!\n'
}

utils_effects_bar_progress_status_fill_using_paint_complex() {
    local VALUE_TIME_DELAY=$1
    local VALUE_PERCENTAGE_LIMIT=100

    already_done() {
        for ((i = 0; i < $elapsed; i++)); do
            # printf "▇";

            if [[ $i -lt 25 ]]; then
                printf "${COLOR_RED_LIGHT}▇${COLOR_END}"
            elif [[ $i -lt 50 ]]; then
                printf "${COLOR_YELLOW}▇${COLOR_END}"
            elif [[ $i -lt 75 ]]; then
                printf "${COLOR_PURPLE_LIGHT}▇${COLOR_END}"
            elif [[ $i -lt 90 ]]; then
                printf "${COLOR_BLUE_LIGHT}▇${COLOR_END}"
            elif [[ $i -lt 100 ]]; then
                printf "${COLOR_CYAN_LIGHT}▇${COLOR_END}"
            elif [[ $i -eq 100 ]]; then
                printf "${COLOR_GREEN_LIGHT}▇${COLOR_END}"
            fi
        done
    }

    percentage() {
        printf "| %s%%" $(((($elapsed) * 100) / ($VALUE_PERCENTAGE_LIMIT) * 100 / 100))
    }

    remaining() {
        for ((remain = $elapsed; remain < $VALUE_PERCENTAGE_LIMIT; remain++)); do
            printf " "
        done
    }

    for ((elapsed = 1; elapsed <= $VALUE_PERCENTAGE_LIMIT; elapsed++)); do
        already_done
        remaining
        percentage
        sleep 0.01
        display_message_content_clear
    done

    display_message_content_clear
}

utils_effects_bar_progress_status_fill_using_paint_simple() {
    local VALUE_TIME_DELAY=$1
    local VALUE_PERCENTAGE_LIMIT=100

    already_done() {
        for ((done = 0; done < $elapsed; done++)); do
            printf "▇"
        done
    }

    percentage() {
        printf "| %s%%" $(((($elapsed) * 100) / ($VALUE_PERCENTAGE_LIMIT) * 100 / 100))
    }

    remaining() {
        for ((remain = $elapsed; remain < $VALUE_PERCENTAGE_LIMIT; remain++)); do
            printf " "
        done
    }

    for ((elapsed = 1; elapsed <= $VALUE_PERCENTAGE_LIMIT; elapsed++)); do
        already_done
        remaining
        percentage
        sleep 0.01
        display_message_content_clear
    done

    display_message_content_clear
}

%
utils_effects_bar_progress_status_fill_using_characters
echo
utils_effects_bar_progress_status_fill_using_paint_complex "0.01"
echo
utils_effects_bar_progress_status_fill_using_paint_simple "0.01"
echo
%%

#  Extract content between the first " and the last " double quotes
# s='Test "checkin_resumestorevisit \"- "Online_V2.mt" Run'; s=${s#*'"'}; s=${s%'"'*}; echo "$s"

#  Display disk partition sizes
# lsblk --json | jq -c '.blockdevices[]|[.name,.size]'

#  Display disk partition sizes
# lsblk -o name,size

#  Display disk partition sizes
# lsblk | grep -v part | awk '{print $1 "\t" $4}'

#  Get line number 12 (or n) from a file
# sed -n '12p;13q' file

#  Get a range on line with sed (first two)
# sed -n '1,2p;3q' file

#  display information about the CPU
# lscpu | egrep 'Model name|Socket|Thread|NUMA|CPU\(s\)'
