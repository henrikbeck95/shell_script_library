#############################
#Math calculator
#############################

math_calculate(){
	scale=4
	echo "scale=$scale; $1" | bc
}