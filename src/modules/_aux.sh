#!/usr/bin/env bash

. /usr/local/bin/shell-script-library || exit

#echo -e "parentPid:\t\t$(top_level_parent_pid)"
#echo -e "isReturn:\t\t$(utils_check_if_output_is_return)"
#echo -e "isStdout:\t\t$(utils_check_if_o7utput_is_stdout)"

declare pi
pi=$(math_pi)

top_level_parent_pid    #Stdout
math_pi                 #Return

echo -e "Top level:\t\t$(top_level_parent_pid)\n"
echo -e "PI variable:\t\t$pi\t\tSHOULD BE: RETURN\n"
echo -e "PI function:\t\t$(math_pi)\t\tSHOULD BE: STDOUT"