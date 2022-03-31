#############################
#Math - Trigonometric functions
#############################

#math_acos(){}
#math_asin(){}
#math_atan(){}
#math_atan2(){}
#math_dist(){}
#math_hypot(){}

math_sin(){
    local VALUE_NUMBER=$1

    #awk 'BEGIN{print "sin(-30 degree)="sin(-30*atan2(0,-1)/180)}'
    math_calc "sin($VALUE_NUMBER degree)"
}

#math_tan(){}