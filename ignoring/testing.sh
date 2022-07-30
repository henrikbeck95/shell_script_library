#!/usr/bin/env sh

#clear && /E/henrik/home/shell_script_library/.ignoring/modules/_testing.sh

#PATH_SCRIPT="$(dirname "$(readlink -f "$0")")"
PATH_SCRIPT=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PATH_SCRIPT="${PATH_SCRIPT}/modules"

source $PATH_SCRIPT/_display_dialog.sh
source $PATH_SCRIPT/_math_hyperbolic.sh
source $PATH_SCRIPT/_math_number.sh
source $PATH_SCRIPT/_math_special.sh
source $PATH_SCRIPT/_math_trigonometric.sh
source $PATH_SCRIPT/_time_formatted.sh
source $PATH_SCRIPT/_time_operation.sh
source $PATH_SCRIPT/color.sh
source $PATH_SCRIPT/container.sh
source $PATH_SCRIPT/display_message.sh
source $PATH_SCRIPT/display_notification.sh
source $PATH_SCRIPT/math_angular.sh
source $PATH_SCRIPT/math_constants.sh
source $PATH_SCRIPT/math_power.sh
source $PATH_SCRIPT/string.sh
source $PATH_SCRIPT/system_backup.sh
source $PATH_SCRIPT/system_battery.sh
source $PATH_SCRIPT/system_daemon.sh
source $PATH_SCRIPT/system_disk.sh
source $PATH_SCRIPT/system_permission.sh
source $PATH_SCRIPT/system_power.sh
source $PATH_SCRIPT/time_current.sh
source $PATH_SCRIPT/util.sh

NUMBER_DIGITS_DECIMAL=20 #PRECISSION

check_if_tz_exists(){
    if [[ $(util_check_if_file_exists "/etc/localtime") ]] || [[ $(util_check_if_file_exists "/usr/share/zoneinfo/UTC") ]]; then
        echo "true"
    else
        echo "false"
    fi
}

check_if_number_is_integer(){
    local VALUE_NUMBER=$1
    local VALUE_NUMBER_DECIMAL=$(string_split_number_digits_decimal $VALUE_NUMBER)
    local VALUE_FILL_EMPTY_WITH_DECIMAL=$(string_repeat_character 20 "0")

    #if [[ $VALUE_NUMBER_DECIMAL -ne $VALUE_FILL_EMPTY_WITH_DECIMAL ]]; then
    #if [[ $VALUE_NUMBER == *"."* ]]; then
    #if [[ $VALUE_NUMBER == *"."* ]] && ! [[ $VALUE_NUMBER_DECIMAL -eq $VALUE_FILL_EMPTY_WITH_DECIMAL ]]; then
    
    #if [[ $VALUE_NUMBER == *"."* ]] && ! [[ ${VALUE_NUMBER_DECIMAL#0} -eq ${VALUE_FILL_EMPTY_WITH_DECIMAL#0} ]]; then
    if [[ $VALUE_NUMBER == *"."* ]] && ! [[ $((10#$VALUE_NUMBER_DECIMAL)) -eq $((10#$VALUE_FILL_EMPTY_WITH_DECIMAL)) ]]; then
		#There is decimal digits
        echo "false"
	else
		#There is not decimal digits
        echo "true"
	fi
}

math_calc(){
    #math_calc() { awk "BEGIN{print $*}"; }
    local EXPRESSION=$*
    local VALUE_RESULT=$(awk "BEGIN{printf \"%.${NUMBER_DIGITS_DECIMAL}f\", $EXPRESSION}")
    local IS_INTEGER=$(check_if_number_is_integer $VALUE_RESULT)
    
    #Debug
    #echo "${EXPRESSION#*.} = $VALUE_RESULT"
    #echo $IS_INTEGER

    #Check decimal places number
    case $IS_INTEGER in
        "false") echo "$VALUE_RESULT" ;;
        "true")
            local VALUE_NUMBER_DECIMAL=$(string_split_number_digits_integer $VALUE_RESULT)
            echo "$VALUE_NUMBER_DECIMAL"
            ;;
    esac
}

sort_list(){
    local VALUE_NUMBER_ALL=$@
    local VALUE_NUMBER_ALL_ORDENATED=($(echo "${VALUE_NUMBER_ALL[@]}" | sed 's/ /\n/g' | sort -n))

    printf "%s\n" "${VALUE_NUMBER_ALL_ORDENATED[@]}"
}

#############################
#Tested functions
#############################

#check_if_number_is_integer 2.00000000000000000000 #true
#check_if_number_is_integer 2                      #true
#check_if_number_is_integer 2.123                  #false
#check_if_number_is_integer 2.12345678901234567890 #false
#math_ceil 7.28                      #8
#math_ceil 7.00000000000000000001    #8
#math_ceil 7.00000000000000000000    #1
#math_degrees 30                    #1718.87338539246979962627
#math_degrees 33                    #1890.76072393171671137679
#math_degrees 45                    #2578.31007808870435837889
#math_degrees 60                    #3437.74677078493959925254
#math_degrees 90                    #5156.62015617740871675778
#math_degrees 180                   #10313.24031235481743351556
#math_degrees 360                   #20626.48062470963486703113
#math_exp 3                         #20.08553692318766437097
#math_exp $(math_e)                 #15.15426224147925893249
#math_expm1 30                      #10686474581523.44921875000000000000
#math_expm1 33                      #214643579785914.78125000000000000000
#math_expm1 45                      #34934271057485029376.00000000000000000000
#math_expm1 60                      #114200738981568165756010496.00000000000000000000
#math_expm1 90                      #1220403294317836300711070746669788168192.00000000000000000000
#math_expm1 180                     #1489384200781827806968010974099814978514152278929585748156404062726252417135120.29996752057526853794
#math_expm1 360                     #2218265297538524239604239458931747975267170016588429709754072109344798105636462675296944370152224745700662926223963878810507371513712386203777759229781229896.36570041883022107215
#math_fabs -1                        #1
#math_fabs 0                         #0
#math_fabs 4                         #4
#math_factorial -5                   #NaN
#math_factorial 0                    #1
#math_factorial 1                    #1
#math_factorial 2                    #2
#math_factorial 5                    #120
#math_max 3 4 2 6 0 74 49 32 47 488 7 -2 -6 18 4 8 #488
#math_min 3 4 2 6 0 74 49 32 47 488 7 -2 -6 18 4 8 #-6
#math_floor 7.28                    #7
#math_log 8 2.7182818284590452354   #2.07944154167983574766
#math_log -8 2                      #NaN
#math_log 0 10                      #-Infinity
#math_log 8 2                       #3
#math_log 64 2                      #6
#math_log 4096 16                   #3
#math_log1p 1                       #0.69314718055994528623
#math_log1p 1000                    #6.90875477931522041786
#math_log1p 10                      #2.39789527279837066942
#math_log1p 145                     #4.98360662170833634832
#math_log1p 72                      #4.29045944114839095107
#math_log2 100                      #6.64385618977472525160
#math_log10 100                     #2
#math_log10 1000                    #2.99999999999999955591
#math_pow 6 3                       # 216
#math_radians 30                    #0.5235987755982988
#math_radians 33                    #0.5759586531581288
#math_radians 45                    #0.7853981633974483
#math_radians 60                    #1.0471975511965976
#math_radians 90                    #1.5707963267948966
#math_radians 180                   #3.141592653589793
#math_radians 360                   #6.283185307179586
#math_round 7.28                    #7
#math_round 7.499                   #7
#math_round 7.501                   #8
#math_round 7.95                    #8
#math_sqrt 36                       #6
#math_sqrt 216 3                    #5.99999999999999911182
#math_sqrt 16 4                     #2
#math_sqrt 2                        #1.41421356237309514547
#math_sqrt 8                        #2.82842712474619029095
#math_sqrt 8 3                      #2

#util_check_if_user_exists "lalaa"           #false
#util_check_if_user_exists "henrikbeck95"    #true
#util_check_if_user_exists "henrikbeck1995"  #false
#util_check_if_user_exists "henrikbeck19957" #false
#util_check_if_user_exists "henrikbeck9551"  #false

#check_if_tz_exists

#Current testing

math_intersection(){
    local list1=( 10 15 3 21 95 )
    local list2=( 10 15 3 20 95 )
    #local list1=( 1 2 3 4 6 7 8 9 10 11 12 )
    #local list2=( 1 2 3 5 6 8 9 11 )

    l2=" ${list2[*]} " #Add framing blanks

    for item in ${list1[@]}; do
        if [[ $l2 =~ " $item " ]] ; then #Use $item as regexp
            result+=($item)
        fi
    done
    
    echo ${result[@]}
}

math_union(){
    local list1=( 10 15 3 21 95 )
    local list2=( 10 15 3 20 95 )

    #local list1=( 1 2 3 4 6 7 8 9 10 11 12 )
    #local list2=( 1 2 3 5 6 8 9 11 )
    
    #local list1=( newfoo 'new foo' oldfoo new )
    #local list2=( 'new foo' foo 'foo new' )

    combined=( "${list1[@]}" "${list2[@]}" )
    printf '%s\n' "${combined[@]}" | sort -u | sort -n
}

#math_intersection
#math_union

#math_sin 30     #-0.98803162409286182655
#math_sin -30    #0.98803162409286182655

echo $(math_degrees $(math_sin 30))
echo $(math_radians $(math_sin 30))

#display_dialog_ask_question_yes_or_no "Do you want to enable 32 bits support?"
#display_dialog_ask_question_number "What user ID do you want to set?"
#display_dialog_ask_question_text "What is the username you want to set?"
