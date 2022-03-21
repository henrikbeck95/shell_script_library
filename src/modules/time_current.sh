#############################
#Time current
#############################

time_get_current_name_month_full(){
    date '+%B' #março
}

time_get_current_name_month_short(){
    date '+%b' #mar
}

time_get_current_name_day_of_week(){
    date '+%A' #domingo
}

time_get_current_value_day_of_month(){
    date '+%d' #20
}

time_get_current_value_day_of_week(){
    date '+%u' #7
}

time_get_current_value_day_of_year(){
    date '+%j' #079
}

time_get_current_value_minutes(){
    date '+%M' #17
}

time_get_current_value_month(){
    date '+%m' #03
}

time_get_current_value_nanoseconds(){
    date '+%N' #818551900
}

time_get_current_value_year_full(){
    date '+%Y' #2022
}

time_get_current_value_year_short(){
    date '+%y' #22
}

time_get_current_value_hour_clock_12(){
    date '+%I' #08
}

time_get_current_value_hour_clock_24(){
    date '+%H' #08
}

time_get_current_value_now_full(){
    date '+%Y_%m_%d-%H_%M_%S' #2022_03_20-08_06_38
}

time_get_current_value_now_short(){
    date '+%H_%M_%S' #08_06_38
}

time_get_current_value_now_timestamp(){
    time_get_current_value_seconds_utc
}

time_get_current_value_seconds_clock(){
    date '+%S' #43
}

time_get_current_value_seconds_utc(){
    date '+%s' #1647774171
}

time_get_current_value_week_of_year_first_day_as_monday(){
    date '+%V' #11
}

time_get_current_value_week_of_year_first_day_as_sunday(){
    date '+%U' #12
}