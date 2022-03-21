#############################
#Math - Angular conversion
#############################

math_degrees(){
    local VALUE_NUMBER_RADIANS=$1
    local VALUE_NUMBER_PI=$(math_pi)
    local VALUE_RESULT=$(math_calc "($VALUE_NUMBER_RADIANS * 180) / $VALUE_NUMBER_PI")

    echo $VALUE_RESULT
}

math_radians(){
    local VALUE_NUMBER_DEGREES=$1
    local VALUE_NUMBER_PI=$(math_pi)
    local VALUE_RESULT=$(math_calc "($VALUE_NUMBER_DEGREES * $VALUE_NUMBER_PI) / 180")
    
    echo $VALUE_RESULT
}