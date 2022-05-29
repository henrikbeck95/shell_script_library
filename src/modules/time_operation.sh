#############################
#Time operations
#############################

time_operation_convert_from_timestamp_to_date(){
    local VALUE_TIME_TIMESTAMP="$1"

    date +"%Y-%m-%d %H:%M:%S" -d @"${VALUE_TIME_TIMESTAMP}" -u
    #date -d @${VALUE_TIME_TIMESTAMP} -u
    #date +"%Y-%m-%d %H:%M:%S" -d @1646942739
    #date -d @1547092066 -u #qui, 10 de jan de 2019 03:47:46
}

time_operation_convert_from_utc_to_timestamp(){
    local VALUE_TIME_TIMESTAMP="$1"

    date +"%s" -d "${VALUE_TIME_TIMESTAMP}"
    #date +"%s" -d "2022-03-10 21:05:39"
}

#time_operation_convert_timezone_from_locale_to_utc(){}

#time_operation_convert_timezone_from_utc_to_locale(){
    #check_if_tz_exists
    #date -d '2014-06-26 23:00 UTC' #Thu 26 Jun 2014 07:00:00 PM EDT
    #date -d '23:00 UTC' #Sun 10 Oct 2021 07:00:00 PM EDT
#}

#You can also convert from other time zones. For example, this command converts from CEST (Central European Summer Time) to local time.
#$ date -d '2021-06-26 23:00 CEST'
#Sat 26 Jun 2021 05:00:00 PM EDT

#---

# transform a local time to UTC
#date -u -d @$(date -d '2019-09-17 19:29:45' +%s) #ter, 17 de set de 2019 22:29:45

#---

#- [ ] Diff date

#'Feb 12 UTC'
#'Feb 13 UTC'
#'Feb 12 UTC' +%s
#'Feb 13 UTC' +%s
#'Feb 12 UTC' +"%F %T"
#'Feb 13 UTC' +"%F %T"
time_operation_compare_(){
    local VALUE_TIME_DATE_FIRST="$1"
    local VALUE_TIME_DATE_SECOND="$2"

    if [[ $(date -d "$VALUE_TIME_DATE_FIRST") < $(date -d "$VALUE_TIME_DATE_SECOND") ]]; then
        echo "Second Date is more recent than first Date"
    elif [[ $(date -d "$VALUE_TIME_DATE_FIRST") == $(date -d "$VALUE_TIME_DATE_SECOND") ]]; then
        echo "Both dates are the same"
    elif [[ $(date -d "$VALUE_TIME_DATE_FIRST") > $(date -d "$VALUE_TIME_DATE_SECOND") ]]; then
        echo "First Date is more recent than second Date"
    else
        echo "Invalid operation! Check possible syntax error."
    fi
}

#time_operation_compare_(){
#    local VALUE_TIME_DATE_FIRST="$1"
#    local VALUE_TIME_DATE_SECOND="$2"
#}

#time_operation_compare_(){
#    local VALUE_TIME_DATE_FIRST="$1"
#    local VALUE_TIME_DATE_SECOND="$2"
#}

#"2020-09-01"
#@annotation_must_be_fixed
time_operation_list_sequence_generate(){
    local VALUE_TIME_DATE_BEGIN="$1"

    date_seq=($(for i in {1..7}; do echo $(date +"%Y/%m/%d" -d "${VALUE_TIME_DATE_BEGIN} +${i} day"); done))
    
    printf "%s\n" "${date_seq[@]}"
}

#'Feb 12 2020 UTC' +%s
#'Feb 13 2020 UTC' +%s
time_operation_calculate_diff(){
    local VALUE_TIME_DATE_FIRST="$1"
    local VALUE_TIME_DATE_SECOND="$2"
    local RESULT #Diff in hours
    
    RESULT=$(( (VALUE_TIME_DATE_SECOND - VALUE_TIME_DATE_FIRST) / 3600))
    
    display_message_value_number_simple "$RESULT"
}

#[me@linux ~]$ date -d "2020-01-01 $secondDate sec - $firstDate sec" +"%j days %H hours %M minutes and %S seconds"
#002 days 00 hours 00 minutes and 00 seconds
#time_operation_calculate_diff(){}


#time_operation_search_(){}

#time_operation_search_(){}

#Operations
#date -d 'last year' #sáb, 20 de mar de 2021 08:03:45
#date -d '90 days ago' #seg, 20 de dez de 2021 08:07:32
#date -d 'Feb 12 + 3 day' #ter, 15 de fev de 2022 00:00:00
#date -d 'Feb 12 + 13 minutes' #sáb, 12 de fev de 2022 00:13:00
#date -d 'date +%c' #dom, 20 de mar de 2022 08:09:19 #locale’s date time

#Not working
#date '+%p' #AM #locale’s equivalent of AM or PM
#date '+%P' #am #same as %p but in lower case
#date '+%Z' #PDT #Alphabetic time zone abbreviation