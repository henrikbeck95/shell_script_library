#############################
#Math - Power and logarithmic functions
#############################

math_exp(){
    local VALUE_NUMBER=$1
    local VALUE_EULER=$(math_e)

    echo $(math_pow $VALUE_EULER $VALUE_NUMBER)
}

math_expm1(){
    local VALUE_NUMBER=$1
    local VALUE_EULER=$(math_e)
    local VALUE_RESULT=$(math_calc "($VALUE_EULER^$VALUE_NUMBER) - 1")

    echo "$VALUE_RESULT"
}

math_log(){
    local VALUE_NUMBER=$1
    local VALUE_BASE=$2

    if [[ $1 -lt 0 ]]; then
        local VALUE_RESULT=$(math_nan)
    elif [[ $1 -eq 0 ]]; then
        local VALUE_RESULT=$(math_inf_negative)
    #elif [[ !($1 -lt "POSITIVE_INFINITY") ]]; then
        #local VALUE_RESULT="$1"
    else
        #local VALUE_RESULT=$(math_calc "$VALUE_NUMBER^$VALUE_BASE")
        local VALUE_RESULT=$(math_calc "log($VALUE_NUMBER)/log($VALUE_BASE)")
    fi

    echo $VALUE_RESULT
}

math_log1p(){ #Logaritmos Neperianos
    local VALUE_NUMBER=$((1 + $1))
    local VALUE_EULER=$(math_e)
    local VALUE_RESULT=$(math_log $VALUE_NUMBER $VALUE_EULER)

    echo $VALUE_RESULT
}

math_log2(){
    local VALUE_NUMBER=$1
    local VALUE_RESULT=$(math_log $VALUE_NUMBER 2)

    echo $VALUE_RESULT
}

math_log10(){
    local VALUE_NUMBER=$1
    local VALUE_RESULT=$(math_log $VALUE_NUMBER 10)

    echo $VALUE_RESULT
}

math_pow(){
    local VALUE_NUMBER=$1
    local VALUE_EVALUATE=$2
    local VALUE_RESULT=$(math_calc "$VALUE_NUMBER^$VALUE_EVALUATE")

    echo "$VALUE_RESULT"
}

math_sqrt(){
    local VALUE_NUMBER=$1

    if [[ $2 == "" ]]; then
        local VALUE_ROOT=2
    else
        local VALUE_ROOT=$2

    fi

    local VALUE_RESULT=$(math_calc "$VALUE_NUMBER^(1/$VALUE_ROOT)")
    echo -e "$VALUE_RESULT"
}