#############################
#Time formatted
#############################

time_get_formatted_date_hour_short_with_slash() {
    date '+%Y/%m/%d %H:%M:%S' #2022/03/20 08:06:38
}

time_get_formatted_date_hour_short_with_hiphen() {
    date '+%Y-%m-%d %H:%M:%S' #2022-03-20 08:06:38
}

time_get_formatted_hour_date_full_with_slash() {
    date '+%H:%M:%S %d/%m/%Y' #08:06:38 20/03/2022
}

time_get_formatted_hour_date_full_with_hiphen() {
    date '+%H:%M:%S %d-%m-%Y' #08:06:38 20-03-2022
}

time_get_formatted_hour_time_with_dots() {
    date '+%H:%M:%S' #08:06:38
    #date '+%X' #08:10:51 #locale’s time
    #date '+%r' #08:24:44 #Display locale’s 12-hour clock time
    #date '+%T' #08:23:3 #Display time only
}

time_get_formatted_hour_time_with_undescore() {
    date '+%H_%M_%S' #08_06_38
}

time_get_formatted_national_represention() {
    date '+%c' #dom, 20 de mar de 2022 09:22:03
}

time_get_formatted_today_full() {
    date #dom, 20 de mar de 2022 07:54:28
}

time_get_formatted_today_full_with_hiphen() {
    date +"%m-%d-%Y" #03-20-2022
}

time_get_formatted_today_full_with_slash() {
    date '+%x' #20/03/2022 #locale’s date full
    #date '+%d/%m/%Y' #20/03/2022
}

time_get_formatted_today_short_with_hiphen() {
    date '+%d-%m-%y' #20/03/22
}

time_get_formatted_today_short_with_slash() {
    date '+%D' #03/20/22 #locale’s date short
    #date '+%d/%m/%y' #20/03/22
}
