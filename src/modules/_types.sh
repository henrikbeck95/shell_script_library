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

##############################
#Declaring variables
##############################

##############################
#Try/catch
##############################

#alias 'try'='' #Open a subshell
#alias 'catch'=''
#alias 'throw'='echo'

#alias 'throwErrors'="if [[ $? -eq 0 ]]; then echo 'olaph: $?'; else echo 'elza: $?';fi"

try(){
    if [ -z $exception_has_been_thrown ]; then
        "$@" || exception_has_been_thrown=1
    fi
}

catch(){
    if [ ! -z $exception_has_been_thrown ]; then
        "$@"
        false   # If "sh -ex" then exit at this point
        unset exception_has_been_thrown
    fi
}

#try echo "Trying 1..."
#catch echo "Catching 1..."

#try echa "Trying 2..."
#catch echo "Catching 2..."

#try echo "Trying 3..."
#catch echo "Catching 3..."

#try echa "Trying 4..."
#catch echo "Catching 4..."

##############################
#Analisador sintático
##############################

#label_must_be_improved
string_get_containt_before_signal(){
    local VALUE_SIGNAL=$1
    local VALUE_VARIABLE=$2

    local VALUE_RESULT="${VALUE_VARIABLE%$VALUE_SIGNAL*}" #
    #local VALUE_RESULT="${VALUE_VARIABLE%%$VALUE_SIGNAL*}" #

    #echo "S1:\t$VALUE_SIGNAL"
    #echo "S2:\t$VALUE_VARIABLE"
    #echo "S3:\t$VALUE_RESULT"

    display_message_default_simple "$VALUE_RESULT"
}

string_get_containt_after_signal(){
    local VALUE_SIGNAL=$1
    local VALUE_VARIABLE=$2

    local VALUE_RESULT="${VALUE_VARIABLE#*$VALUE_SIGNAL}" #Since first value after match
    local VALUE_RESULT="${VALUE_VARIABLE##*$VALUE_SIGNAL}" #Only last value after match

    #echo "S1:\t$VALUE_SIGNAL"
    #cho "S2:\t$VALUE_VARIABLE"
    #echo "S3:\t$VALUE_RESULT"

    display_message_default_simple "$VALUE_RESULT"
}

function analisador_sintatico_name(){
    local VALUE=$1
    local VARIABLE_NAME=$(string_get_containt_before_signal '=' $VALUE)
    
    case $(utils_check_if_variable_is_integer $VARIABLE_VALUE) in
        "false") analisador_sintatico_validator "int" ;;
        "true") display_message_default_simple "$VARIABLE_VALUE" ;;
    esac
}

#working_on
function analisador_sintatico_validator(){
    local VALUE=$1

    set -e
    echo "'${VALUE}' contains invalid values for this primitive type."
    # false
    set +e
}

function analisador_sintatico_boolean(){
    local VALUE=$1

    VALUE=$(string_get_containt_before_signal '='  $VALUE)

    case $(utils_check_if_variable_is_boolean $VALUE) in
        "false") analisador_sintatico_validator "boolean" ;;
        "true") display_message_default_simple "$VALUE" ;;
    esac
}

function analisador_sintatico_char(){
    local VALUE=$1

    VALUE=$(string_get_containt_before_signal '='  $VALUE)

    case $(utils_check_if_variable_is_char $VALUE) in
        "false") analisador_sintatico_validator "char" ;;
        "true") display_message_default_simple "$VALUE" ;;
    esac
}

function analisador_sintatico_float(){
    local VALUE=$1

    VALUE=$(string_get_containt_before_signal '='  $VALUE)

    case $(utils_check_if_variable_is_number $VALUE) in
        "false") analisador_sintatico_validator "float" ;;
        "true") display_message_default_simple "$VALUE" ;;
    esac
}

function analisador_sintatico_int(){
    local VALUE=$1
    local VARIABLE_VALUE=$(string_get_containt_after_signal '=' $VALUE)

    case $(utils_check_if_variable_is_integer $VARIABLE_VALUE) in
        "false") analisador_sintatico_validator "int" ;;
        "true") display_message_default_simple "$VARIABLE_VALUE" ;;
    esac
}

function analisador_sintatico_object(){
    local VALUE=$1

    VALUE=$(string_get_containt_before_signal '='  $VALUE)

    case $(utils_check_if_variable_exists $VALUE) in
        "false") analisador_sintatico_validator "object" ;;
        "true") display_message_default_simple "$VALUE" ;;
    esac
}

function analisador_sintatico_string(){
    local VALUE=$1

    VALUE=$(string_get_containt_before_signal '='  $VALUE)

    case $(utils_check_if_variable_is_string $VALUE) in
        "false") analisador_sintatico_validator "string" ;;
        "true") display_message_default_simple "$VALUE" ;;
    esac
}

#analisador_sintatico_boolean "Henrik Beck"           #false
#analisador_sintatico_boolean "false"                 #true
#analisador_sintatico_boolean "true"                  #true
#analisador_sintatico_boolean "Lalala"                #false
#analisador_sintatico_boolean "1995"                 #false
#analisador_sintatico_boolean ""                     #false

#analisador_sintatico_char "Henrik Beck"              #false
#analisador_sintatico_char "henrikbeck95@gmail.com"   #false
#analisador_sintatico_char "1995"                     #false
#analisador_sintatico_char "1"                        #true
#analisador_sintatico_char ">"                        #true
#analisador_sintatico_char ""                         #false

#analisador_sintatico_float "Henrik Beck"             #false
#analisador_sintatico_float "3"                       #true
#analisador_sintatico_float "-3"                      #true
#analisador_sintatico_float "3.14"                    #true
#analisador_sintatico_float "-3.14"                   #true
#analisador_sintatico_float "3A14"                    #false
#analisador_sintatico_float ""                        #

#analisador_sintatico_int "Henrik Beck"               #false
#analisador_sintatico_int "3"                         #true
#analisador_sintatico_int "-3"                        #true
#analisador_sintatico_int "3.14"                      #false
#analisador_sintatico_int "-3.14"                     #false
#analisador_sintatico_int "3A14"                      #false
#analisador_sintatico_int ""                          #false

#analisador_sintatico_object "Henrik Beck"               #true
#analisador_sintatico_object "henrikbeck95@gmail.com"    #true
#analisador_sintatico_object "1995"                      #true
#analisador_sintatico_object "1"                         #true
#analisador_sintatico_object ">"                         #true
#analisador_sintatico_object ""                          #false
#analisador_sintatico_object "true"                      #true

#analisador_sintatico_string "Henrik Beck"               #true
#analisador_sintatico_string "henrikbeck95@gmail.com"    #true
#analisador_sintatico_string "1995"                      #false
#analisador_sintatico_string "1"                         #false
#analisador_sintatico_string ">"                         #true
#analisador_sintatico_string ""                          #false
#analisador_sintatico_string "true"                      #false

##############################
#Primitive types
##############################

#NAME
#    declare - Set variable values and attributes.
#
#SYNOPSIS
#    declare [-aAfFgilnrtux] [-p] [name[=value] ...]
#
#DESCRIPTION
#    Set variable values and attributes.
#    
#    Declare variables and give them attributes.  If no NAMEs are given,
#    display the attributes and values of all variables.
#    
#    Options:
#      -f	restrict action or display to function names and definitions
#      -F	restrict display to function names only (plus line number and
#    		source file when debugging)
#      -g	create global variables when used in a shell function; otherwise
#    		ignored
#      -p	display the attributes and value of each NAME
#    
#    Options which set attributes:
#      -a	to make NAMEs indexed arrays (if supported)
#      -A	to make NAMEs associative arrays (if supported)
#      -i	to make NAMEs have the `integer' attribute
#      -l	to convert the value of each NAME to lower case on assignment
#      -n	make NAME a reference to the variable named by its value
#      -r	to make NAMEs readonly
#      -t	to make NAMEs have the `trace' attribute
#      -u	to convert the value of each NAME to upper case on assignment
#      -x	to make NAMEs export
#    
#    Using `+' instead of `-' turns off the given attribute.

#alias 'static ...'='declare -g' #create global variables when used in a shell function; otherwise ignored

alias 'array_boolean'=''
alias 'array_char'=''
#alias 'array_int'=''
alias 'array_object'=''
alias 'array_string'=''

alias 'final_array_boolean'=''
alias 'final_array_char'=''
#alias 'final_array_int'=''
alias 'final_array_object'=''
alias 'final_array_string'=''

alias 'final_boolean'=''
alias 'final_char'=''
#alias 'final_int'='declare -r -i'
alias 'final_object'=''
alias 'final_string'=''

alias 'boolean'="analisador_sintatico_boolean $1"
alias 'char'="analisador_sintatico_char $1"
#alias 'int'='declare -i'
#alias 'int'="analisador_sintatico_int $1"
alias 'int'="eval declare analisador_sintatico_name analisador_sintatico_int $1"
alias 'object'="analisador_sintatico_object $1"
alias 'string'="analisador_sintatico_string $1"

#export -f int

#alias 'function'=''
alias 'function'='declare -F'

#public
#private
#protected

#public_static_void
#public_void

#public_static_boolean
#public_boolean

#public_static_char
#public_char

#public_static_float
#public_float

#public_static_int
#public_int

#public_static_object
#public_object

#public_static_string
#public_string

function my_function(){
    # int numeric = 1995
    int numeric=1995
    int algumaCoisa=1234
    object anything="This is an object"
    string text="This is a string"

    echo "Inside function: $numeric"
    echo "Before function: $algumaCoisa"
    echo "Inside function: $anything"
    echo "Inside function: $text"
}







int numeric=2022
int algumaCoisa=1234
object anything="This is an generic"
string text="This is a text"

display_message_separator_complex

echo "Before function: $numeric"
echo "Before function: $algumaCoisa"
echo "Before function: $anything"
echo "Before function: $text"

display_message_separator_complex
my_function
display_message_separator_complex

echo "After function: $numeric"
echo "Before function: $algumaCoisa"
echo "After function: $anything"
echo "After function: $text"