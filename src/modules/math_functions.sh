#############################
#Math - Angular conversion
#############################

#@annotation_must_be_tested
math_degrees() {
    local VALUE_NUMBER_RADIANS="$1"
    local VALUE_NUMBER_PI
    local VALUE_RESULT

    VALUE_NUMBER_PI=$(math_pi)
    VALUE_RESULT=$(math_calculator "($VALUE_NUMBER_RADIANS * 180) / $VALUE_NUMBER_PI")

    display_message_value_number_simple "$VALUE_RESULT"
}

#@annotation_must_be_tested
math_radians() {
    local VALUE_NUMBER_DEGREES="$1"
    local VALUE_NUMBER_PI
    local VALUE_RESULT

    VALUE_NUMBER_PI=$(math_pi)
    VALUE_RESULT=$(math_calculator "($VALUE_NUMBER_DEGREES * $VALUE_NUMBER_PI) / 180")

    display_message_value_number_simple "$VALUE_RESULT"
}

#############################
#Math - Hyperbolic functions
#############################

#math_acosh(){}
#math_asinh(){}
#math_atanh(){}
#math_cosh(){}
#math_sinh(){}
#math_tanh(){}

#############################
#Math - Number-theoretic and representation functions
#############################

#@annotation_must_be_tested
math_ceil() {
    local VALUE_NUMBER="$1"
    local VALUE_NUMBER_INTEGER
    local VALUE_NUMBER_DECIMAL

    VALUE_NUMBER_INTEGER=$(string_split_number_digits_integer "$VALUE_NUMBER")
    VALUE_NUMBER_DECIMAL=$(string_split_number_digits_decimal "$VALUE_NUMBER")

    local VALUE_RESULT

    if [[ "$VALUE_NUMBER_DECIMAL" -gt 0 ]]; then
        VALUE_RESULT=$((VALUE_NUMBER_INTEGER + 1))
    else
        VALUE_RESULT="$VALUE_NUMBER_INTEGER"
    fi

    display_message_value_number_simple "$VALUE_RESULT"
}

#@annotation_must_be_tested

#@annotation_must_be_tested
#math_comb(){}
#math_copysign(){}

#@annotation_must_be_tested
math_fabs() {
    local VALUE_NUMBER="$1"

    if [[ $VALUE_NUMBER -lt 0 ]]; then
        display_message_value_number_simple "$((-1 * VALUE_NUMBER))"
    else
        display_message_value_number_simple "$VALUE_NUMBER"
    fi
}

#@annotation_must_be_tested
math_factorial() {
    #math_factorial "6"
    #math_factorial "20"

    local VALUE_NUMBER="$1"
    local RESULT

    if [[ VALUE_NUMBER -lt 0 ]]; then
        RESULT=$(math_nan)
        display_message_value_number_simple "$RESULT"
    elif [[ VALUE_NUMBER -eq 0 ]]; then
        display_message_value_number_simple "1"
    elif [[ VALUE_NUMBER -lt 2 ]]; then
        display_message_value_number_simple "$VALUE_NUMBER"
    else
        RESULT=1

        while [[ VALUE_NUMBER -gt 1 ]]; do
            RESULT=$((RESULT * VALUE_NUMBER))
            VALUE_NUMBER=$((VALUE_NUMBER - 1))
        done

        display_message_value_number_simple "$RESULT"
    fi
}

math_factorial_recusively() {
    #math_factorial_recusively "6"
    #math_factorial_recusively "20"

    local VARIABLE_VALUE=$1

    if ((VARIABLE_VALUE <= 1)); then
        echo 1
    else
        n=$(math_factorial_recusively $((VARIABLE_VALUE - 1)))
        echo $((n * VARIABLE_VALUE))
    fi
}

#@annotation_must_be_tested
math_floor() {
    local VALUE_NUMBER="$1"
    local VALUE_NUMBER_INTEGER

    VALUE_NUMBER_INTEGER=$(string_split_number_digits_integer "$VALUE_NUMBER")

    display_message_value_number_simple "$VALUE_NUMBER_INTEGER"
}

#@annotation_must_be_tested

#@annotation_must_be_tested#math_fmod(){}

#@annotation_must_be_tested#math_frexp(){}

#@annotation_must_be_tested#math_fsum(){}

#@annotation_must_be_tested#math_gcd(){}

#@annotation_must_be_tested#math_isclose(){}

#@annotation_must_be_tested#math_isfinite(){}

#@annotation_must_be_tested#math_isinf(){}

#@annotation_must_be_tested#math_isnan(){}

#@annotation_must_be_tested#math_isqrt(){}

#@annotation_must_be_tested#math_lcm(){}

#@annotation_must_be_tested#math_lcm(){}
#math_ldexp(){}

#@annotation_must_be_tested
math_min() {
    local VALUE_NUMBER_ALL="$*"
    local VALUE_NUMBER_MIN

    VALUE_NUMBER_MIN=$(sort_list "$VALUE_NUMBER_ALL" | head -1)

    display_message_value_number_simple "$VALUE_NUMBER_MIN"
}

#@annotation_must_be_tested
math_max() {
    local VALUE_NUMBER_ALL="$*"
    local VALUE_NUMBER_MAX

    VALUE_NUMBER_MAX=$(sort_list "$VALUE_NUMBER_ALL" | tail -1)

    display_message_value_number_simple "$VALUE_NUMBER_MAX"
}

#@annotation_must_be_tested
#math_modf(){}

#@annotation_must_be_tested
#math_nextafter(){}

#@annotation_must_be_tested
#math_perm(){}

#@annotation_must_be_tested
#math_prod(){}

#@annotation_must_be_tested
#math_remainder(){}

#@annotation_must_be_tested
math_round() {
    local VALUE_NUMBER="$1"
    local VALUE_NUMBER_INTEGER
    local VALUE_NUMBER_DECIMAL
    local VALUE_DECIMAL_FIRST_NUMBER
    local VALUE_RESULT

    VALUE_NUMBER_INTEGER=$(string_split_number_digits_integer "$VALUE_NUMBER")
    VALUE_NUMBER_DECIMAL=$(string_split_number_digits_decimal "$VALUE_NUMBER")

    VALUE_DECIMAL_FIRST_NUMBER=${VALUE_NUMBER_DECIMAL:0:1}

    if [[ $VALUE_DECIMAL_FIRST_NUMBER -lt 5 ]]; then
        VALUE_RESULT=$VALUE_NUMBER_INTEGER
    else
        VALUE_RESULT=$((VALUE_NUMBER_INTEGER + 1))
    fi

    display_message_value_number_simple "$VALUE_RESULT"
}

#@annotation_must_be_tested
#math_trunc(){}

#@annotation_must_be_tested
#math_ulp(){}

#############################
#Math - Power and logarithmic functions
#############################

#@annotation_must_be_tested
math_exp() {
    local VALUE_NUMBER="$1"
    local VALUE_EULER
    local VALUE_RESULT

    VALUE_EULER=$(math_e)
    VALUE_RESULT=$(math_pow "$VALUE_EULER" "$VALUE_NUMBER")

    display_message_value_number_simple "$VALUE_RESULT"
}

#@annotation_must_be_tested
math_expm1() {
    local VALUE_NUMBER="$1"
    local VALUE_EULER
    local VALUE_RESULT

    VALUE_EULER=$(math_e)
    VALUE_RESULT=$(math_calculator "($VALUE_EULER^$VALUE_NUMBER) - 1")

    display_message_value_number_simple "$VALUE_RESULT"
}

#@annotation_must_be_tested
math_log() {
    local VALUE_NUMBER="$1"
    local VALUE_BASE="$2"
    local VALUE_RESULT

    if [[ $1 -lt 0 ]]; then
        VALUE_RESULT=$(math_nan)
    elif [[ $1 -eq 0 ]]; then
        VALUE_RESULT=$(math_inf_negative)
        #elif [[ !($1 -lt "POSITIVE_INFINITY") ]]; then
        #VALUE_RESULT="$1"
    else
        #VALUE_RESULT=$(math_calculator "$VALUE_NUMBER^$VALUE_BASE")
        VALUE_RESULT=$(math_calculator "log($VALUE_NUMBER)/log($VALUE_BASE)")
    fi

    display_message_value_number_simple "$VALUE_RESULT"
}

#@annotation_must_be_tested
math_log1p() { #Logaritmos Neperianos
    local VALUE_NUMBER=$((1 + $1))
    local VALUE_EULER
    local VALUE_RESULT

    VALUE_EULER=$(math_e)
    VALUE_RESULT=$(math_log "$VALUE_NUMBER" "$VALUE_EULER")

    display_message_value_number_simple "$VALUE_RESULT"
}

#@annotation_must_be_tested
math_log2() {
    local VALUE_NUMBER="$1"
    local VALUE_RESULT

    VALUE_RESULT=$(math_log "$VALUE_NUMBER" 2)

    display_message_value_number_simple "$VALUE_RESULT"
}

#@annotation_must_be_tested
math_log10() {
    local VALUE_NUMBER="$1"
    local VALUE_RESULT

    VALUE_RESULT=$(math_log "$VALUE_NUMBER" 10)

    display_message_value_number_simple "$VALUE_RESULT"
}

#@annotation_must_be_tested
math_pow() {
    #math_pow "3"
    #math_pow "3" "4"

    local VALUE_NUMBER="$1"
    local VALUE_EVALUATE
    local VALUE_RESULT

    case $(utils_check_if_variable_is_null "$2") in
    "false") VALUE_EVALUATE="$2" ;;
    "true") VALUE_EVALUATE="2" ;;
    esac

    VALUE_RESULT=$(math_calculator "$VALUE_NUMBER^$VALUE_EVALUATE")

    display_message_value_number_simple "$VALUE_RESULT"
}

#@annotation_must_be_tested
math_sqrt() {
    #math_sqrt "81"
    #math_sqrt "27" "3"

    local VALUE_NUMBER="$1"
    local VALUE_ROOT
    local VALUE_RESULT

    case $(utils_check_if_variable_is_null "$2") in
    "false") VALUE_ROOT="$2" ;;
    "true") VALUE_ROOT="2" ;;
    esac

    VALUE_RESULT=$(math_calculator "$VALUE_NUMBER^(1/$VALUE_ROOT)")

    display_message_value_number_simple "$VALUE_RESULT"
}

#############################
#Math - Special function
#############################

#math_erf(){}
#math_erfc(){}
#math_gamma(){}
#math_lgamma(){}

#############################
#Math - Trigonometric functions
#############################

#@annotation_must_be_tested

#@annotation_must_be_tested#math_acos(){}

#@annotation_must_be_tested#math_asin(){}

#@annotation_must_be_tested#math_atan(){}

#@annotation_must_be_tested#math_atan2(){}

#@annotation_must_be_tested#math_dist(){}
#math_hypot(){}

#@annotation_must_be_tested

#@annotation_must_be_tested#@annotation_must_be_fixed
math_sin() {
    local VALUE_NUMBER="$1"
    local VALUE_RESULT

    #awk 'BEGIN{print "sin(-30 degree)="sin(-30*atan2(0,-1)/180)}'
    VALUE_RESULT=$(math_calculator "sin($VALUE_NUMBER degree)")

    display_message_value_number_simple "$VALUE_RESULT"
}

#@annotation_must_be_tested
#math_tan(){}
