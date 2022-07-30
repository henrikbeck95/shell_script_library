#############################
#Math calculator
#############################

math_calculator() {
	#math_calculator "22 / 7"
	#math_calculator "10/3"
	#math_calculator "3/10"
	#math_calculator "10^2"
	#math_calculator "100^(1/2)"
	#math_calculator "27^(1/3)"

	#math_calculator "10/3" "4"
	#math_calculator "3/10" "4"
	#math_calculator "10^2" "4"
	#math_calculator "100^(1/2)" "4"
	#math_calculator "27^(1/3)" "4"

	local MATH_EXPRESSION="$1"
	local FLOAT_POINT_VALUE

	case $(utils_check_if_variable_is_null "$2") in
	"false") FLOAT_POINT_VALUE="$2" ;;
	"true") FLOAT_POINT_VALUE="10" ;;
	esac

	#awk "BEGIN{printf \"%d\n\", $MATH_EXPRESSION}"
	#awk "BEGIN{printf \"%.${FLOAT_POINT_VALUE}f\n\", $MATH_EXPRESSION}"
	#awk "BEGIN{printf \"%g\n\", $MATH_EXPRESSION}"
	#awk "BEGIN{printf \"%.${FLOAT_POINT_VALUE}e\n\", $MATH_EXPRESSION}"
	awk "BEGIN{printf \"%.${FLOAT_POINT_VALUE}g\n\", $MATH_EXPRESSION}"

	#bc<<<"$MATH_EXPRESSION"
}
