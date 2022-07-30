# Examples

## Math

<!--
- foo.sh
```bash
import math
result = math.pow 8 2 #Return 64
display.message.warning result
```
-->

## String manipulation

- Original base example from `/etc/pacman.conf` file
    ```conf
    #...
    #Line: 88

    #[multilib-testing]
    #Include = /etc/pacman.d/mirrorlist

    #[multilib]
    #Include = /etc/pacman.d/mirrorlist

    #Line: 96
    #...
    ```

1. By replacing the lines 90 and 91 from this file.
    - Traditional solution is:
        ```bash
        sed -i "90 c\\[multilib]" /etc/pacman.conf
        sed -i "91 c\\Include = /etc/pacman.d/mirrorlist" /etc/pacman.conf
        ```

    - Shell Script Library solution:
        ```bash
        source /usr/local/bin/shell-script-library

        tools_string_replace_number "/etc/pacman.conf" "90" "[multilib]"
        tools_string_replace_number "/etc/pacman.conf" "91" "Include = /etc/pacman.d/mirrorlist"
        ```
    
    - Result in both cases:
        ```conf
        #...
        #Line: 88

        [multilib-testing]
        Include = /etc/pacman.d/mirrorlist

        #[multilib]
        #Include = /etc/pacman.d/mirrorlist

        #Line: 96
        #...
        ```

1. By replacing all the text those matches from this file. In this case, let us uncomment all the lines.
    - Traditional solution is:
        ```bash
        sed -i "s/#//g" /etc/pacman.conf
        ```

    - Shell Script Library solution:
        ```bash
        source /usr/local/bin/shell-script-library

        tools_string_replace_text "/etc/pacman.conf" "#" ""
        ```
    
    - Result in both cases:
        ```conf
        #...
        #Line: 88

        [multilib-testing]
        Include = /etc/pacman.d/mirrorlist

        [multilib]
        Include = /etc/pacman.d/mirrorlist

        #Line: 96
        #...
        ```

1. Replacing all the `/` characters by `\`.
    - Traditional solution is:
        ```bash
        echo "/etc/pacman.conf" | sed 's/\//\\\//g'
        ```

    - Shell Script Library solution
        ```bash
        source /usr/local/bin/shell-script-library

        tools_string_replace_forward_slash_to_backslash_cancelled "/etc/pacman.conf"
        ```
    
    - Result in both cases
        ```conf
        #...
        #Line: 88

        #[multilib-testing]
        #Include = \etc\pacman.d\mirrorlist

        #[multilib]
        #Include = \etc\pacman.d\mirrorlist

        #Line: 96
        #...
        ```

## System utilities

1. Battery notifier
    - Traditional solution is:
        ```bash
        #!/usr/bin/env sh

        _battery(){
            _BATTERY_PERCENTAGE=$(acpi -b | grep -E -o '[0-9][0-9]?%')
            _BATTERY_REMAINING=$(acpi -b | grep -E -o '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]?')
            _LEVEL=$(cat /sys/class/power_supply/BAT1/capacity)
            _STATUS=$(cat /sys/class/power_supply/BAT1/status)

            _BATTERY_CHARGED_LOW="Low battery. Connect the charger $_LEVEL%"
            _BATTERY_CHARGED_FULL="Full charged. Remove the charger $_LEVEL%"

            if [[ "$_STATUS" != "Charging" && $_LEVEL -lt 30 ]] ; then
                notify-send -u low -t 1500 --urgency=critical --icon=battery-caution "$_BATTERY_CHARGED_LOW" "Remaining: $_BATTERY_REMAINING"
            elif [[ "$_STATUS" == "Charging" && $_LEVEL -eq 100 ]] ; then
                notify-send --urgency=critical --icon=battery-caution "$_BATTERY_CHARGED_FULL"
            fi
        }

        while :
        do
            _battery
            sleep 10
        done
        ```

    - Shell Script Library solution:
        ```bash
        #!/usr/bin/env sh

        source /usr/local/bin/shell-script-library

        while true; do
            local VALUE_MESSAGE=$(system_battery_warning)
            local VALUE_TIME_SECONDS=10

            display_notification_warning "$VALUE_MESSAGE" "battery-caution"
            sleep $VALUE_TIME_SECONDS
        done
        ```
    
    - Result in both cases
        <!--Take a screenshot-->
        <!--![]()-->