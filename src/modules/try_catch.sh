#############################
#Try/catch
#############################

try() {
    if [ -z "$exception_has_been_thrown" ]; then
        "$@" || exception_has_been_thrown=1
    fi
}

catch() {
    if [ -n "$exception_has_been_thrown" ]; then
        "$@"
        false # If "sh -ex" then exit at this point
        unset exception_has_been_thrown
    fi
}

#alias 'try'='' #Open a subshell
#alias 'catch'=''
#alias 'throw'='echo'

#try echo "Trying 1..."
#catch echo "Catching 1..."

#try echa "Trying 2..."
#catch echo "Catching 2..."

#try echo "Trying 3..."
#catch echo "Catching 3..."

#try echa "Trying 4..."
#catch echo "Catching 4..."
