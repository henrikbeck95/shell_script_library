
##############################
#Annotations
##############################

# function @Override(){
#     echo 'this'
# }

# @Override

function_name() {
    echo 'String 01'
    echo 'String 02'
}

#@Deprecated
function Deprecated() {
    local FUNCTION_NAME=$1

    display_message_value_text_default_complex "The $FUNCNAME function is going to be Deprecated soon"

    eval $FUNCTION_NAME
}

# Deprecated "function_name"

# alias '@'='echo "String from @ alias"'
# @
