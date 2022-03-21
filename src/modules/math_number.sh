#############################
#Math - Number-theoretic and representation functions
#############################

math_ceil(){
    local VALUE_NUMBER=$1
    local VALUE_NUMBER_INTEGER=$(string_split_number_digits_integer $VALUE_NUMBER)
    local VALUE_NUMBER_DECIMAL=$(string_split_number_digits_decimal $VALUE_NUMBER)

    if [[ $VALUE_NUMBER_DECIMAL -gt 0 ]]; then
        local VALUE_RESULT=$(($VALUE_NUMBER_INTEGER+1))
    else
        local VALUE_RESULT=$VALUE_NUMBER_INTEGER
    fi

    echo $VALUE_RESULT
}

#math_comb(){}
#math_copysign(){}

math_fabs(){
    local VALUE_NUMBER=$1

    if [[ $VALUE_NUMBER -lt 0 ]]; then
        echo "$((-1 * $VALUE_NUMBER))"
    else
        echo "$VALUE_NUMBER"
    fi
}

math_factorial(){
    local VALUE_NUMBER=$1

    if [[ VALUE_NUMBER -lt 0 ]]; then
        local RESULT=$(math_nan)
        echo "$RESULT"
    elif [[ VALUE_NUMBER -eq 0 ]]; then
        echo "1"
    elif [[ VALUE_NUMBER -lt 2 ]]; then
        echo "$VALUE_NUMBER"
    else
        RESULT=1

        while [[ VALUE_NUMBER -gt 1 ]]; do
            RESULT=$((RESULT * $VALUE_NUMBER))
            VALUE_NUMBER=$(($VALUE_NUMBER - 1))
        done

        echo $RESULT
    fi
}

math_floor(){
    local VALUE_NUMBER=$1
    local VALUE_NUMBER_INTEGER=$(string_split_number_digits_integer $VALUE_NUMBER)

    echo $VALUE_NUMBER_INTEGER
}

#math_fmod(){}
#math_frexp(){}
#math_fsum(){}
#math_gcd(){}
#math_isclose(){}
#math_isfinite(){}
#math_isinf(){}
#math_isnan(){}
#math_isqrt(){}
#math_lcm(){}
#math_lcm(){}
#math_ldexp(){}

math_min(){
    local VALUE_NUMBER_ALL=$@
    local VALUE_NUMBER_MIN=$(sort_list $VALUE_NUMBER_ALL | head -1)

    echo "$VALUE_NUMBER_MIN"
}

math_max(){
    local VALUE_NUMBER_ALL=$@
    local VALUE_NUMBER_MAX=$(sort_list $VALUE_NUMBER_ALL | tail -1)

    echo "$VALUE_NUMBER_MAX"
}

#math_modf(){}
#math_nextafter(){}
#math_perm(){}
#math_prod(){}
#math_remainder(){}

math_round(){
    local VALUE_NUMBER=$1
    local VALUE_NUMBER_INTEGER=$(string_split_number_digits_integer $VALUE_NUMBER)
    local VALUE_NUMBER_DECIMAL=$(string_split_number_digits_decimal $VALUE_NUMBER)

    local VALUE_DECIMAL_FIRST_NUMBER=${VALUE_NUMBER_DECIMAL:0:1}

    if [[ $VALUE_DECIMAL_FIRST_NUMBER -lt 5 ]]; then
        local VALUE_RESULT=$VALUE_NUMBER_INTEGER
    else
        local VALUE_RESULT=$(($VALUE_NUMBER_INTEGER+1))
    fi

    echo "$VALUE_RESULT"
}

#math_trunc(){}
#math_ulp(){}