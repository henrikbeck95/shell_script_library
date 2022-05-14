#############################
#Math
#############################

#math_calc(){}

#############################
#Math - Angular conversion
#############################

math_degrees(){
    local VALUE_NUMBER_RADIANS=$1
    local VALUE_NUMBER_PI=$(math_pi)
    local VALUE_RESULT=$(math_calc "($VALUE_NUMBER_RADIANS * 180) / $VALUE_NUMBER_PI")

    display_message_default_simple "$VALUE_RESULT"
}

math_radians(){
    local VALUE_NUMBER_DEGREES=$1
    local VALUE_NUMBER_PI=$(math_pi)
    local VALUE_RESULT=$(math_calc "($VALUE_NUMBER_DEGREES * $VALUE_NUMBER_PI) / 180")
    
    display_message_default_simple "$VALUE_RESULT"
}

#############################
#Math - Constants
#############################

math_pi(){
    display_message_default_simple "3.14159265358979323846"
}

math_e(){
    display_message_default_simple "2.7182818284590452354"
}

math_phi(){
    display_message_default_simple "1.61803398874989484820"
}

math_tau(){
    display_message_default_simple "6.283185307179586"
}

math_inf_negative(){
    display_message_default_simple "-Infinity"
}

math_inf_positive(){
    display_message_default_simple "Infinity"
}

math_nan(){
    display_message_default_simple "NaN"
}

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

    display_message_default_simple "$VALUE_RESULT"
}

#math_comb(){}
#math_copysign(){}

math_fabs(){
    local VALUE_NUMBER=$1

    if [[ $VALUE_NUMBER -lt 0 ]]; then
        display_message_default_simple "$((-1 * $VALUE_NUMBER))"
    else
        display_message_default_simple "$VALUE_NUMBER"
    fi
}

math_factorial(){
    local VALUE_NUMBER=$1

    if [[ VALUE_NUMBER -lt 0 ]]; then
        local RESULT=$(math_nan)
        display_message_default_simple "$RESULT"
    elif [[ VALUE_NUMBER -eq 0 ]]; then
        display_message_default_simple "1"
    elif [[ VALUE_NUMBER -lt 2 ]]; then
        display_message_default_simple "$VALUE_NUMBER"
    else
        local RESULT=1

        while [[ VALUE_NUMBER -gt 1 ]]; do
            RESULT=$((RESULT * $VALUE_NUMBER))
            VALUE_NUMBER=$(($VALUE_NUMBER - 1))
        done

        display_message_default_simple "$RESULT"
    fi
}

math_floor(){
    local VALUE_NUMBER=$1
    local VALUE_NUMBER_INTEGER=$(string_split_number_digits_integer $VALUE_NUMBER)

    display_message_default_simple "$VALUE_NUMBER_INTEGER"
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

    display_message_default_simple "$VALUE_NUMBER_MIN"
}

math_max(){
    local VALUE_NUMBER_ALL=$@
    local VALUE_NUMBER_MAX=$(sort_list $VALUE_NUMBER_ALL | tail -1)

    display_message_default_simple "$VALUE_NUMBER_MAX"
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

    display_message_default_simple "$VALUE_RESULT"
}

#math_trunc(){}
#math_ulp(){}

#############################
#Math - Power and logarithmic functions
#############################

math_exp(){
    local VALUE_NUMBER=$1
    local VALUE_EULER=$(math_e)
	local VALUE_RESULT=$(math_pow $VALUE_EULER $VALUE_NUMBER)

    display_message_default_simple "$VALUE_RESULT"
}

math_expm1(){
    local VALUE_NUMBER=$1
    local VALUE_EULER=$(math_e)
    local VALUE_RESULT=$(math_calc "($VALUE_EULER^$VALUE_NUMBER) - 1")

    display_message_default_simple "$VALUE_RESULT"
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

    display_message_default_simple "$VALUE_RESULT"
}

math_log1p(){ #Logaritmos Neperianos
    local VALUE_NUMBER=$((1 + $1))
    local VALUE_EULER=$(math_e)
    local VALUE_RESULT=$(math_log $VALUE_NUMBER $VALUE_EULER)

    display_message_default_simple "$VALUE_RESULT"
}

math_log2(){
    local VALUE_NUMBER=$1
    local VALUE_RESULT=$(math_log $VALUE_NUMBER 2)

    display_message_default_simple "$VALUE_RESULT"
}

math_log10(){
    local VALUE_NUMBER=$1
    local VALUE_RESULT=$(math_log $VALUE_NUMBER 10)

    display_message_default_simple "$VALUE_RESULT"
}

math_pow(){
    local VALUE_NUMBER=$1
    local VALUE_EVALUATE=$2
    local VALUE_RESULT=$(math_calc "$VALUE_NUMBER^$VALUE_EVALUATE")

    display_message_default_simple "$VALUE_RESULT"
}

math_sqrt(){
    local VALUE_NUMBER=$1

    if [[ $2 == "" ]]; then
        local VALUE_ROOT=2
    else
        local VALUE_ROOT=$2

    fi

    local VALUE_RESULT=$(math_calc "$VALUE_NUMBER^(1/$VALUE_ROOT)")

	display_message_default_simple "$VALUE_RESULT"
}

#############################
#Math - Trigonometric functions
#############################

#math_acos(){}
#math_asin(){}
#math_atan(){}
#math_atan2(){}
#math_dist(){}
#math_hypot(){}

#label_must_be_tested
#label_must_be_fixed
math_sin(){
    local VALUE_NUMBER=$1

    #awk 'BEGIN{print "sin(-30 degree)="sin(-30*atan2(0,-1)/180)}'
    math_calc "sin($VALUE_NUMBER degree)"
}

#math_tan(){}