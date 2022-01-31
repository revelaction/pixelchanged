#!/bin/bash
set -eu
set -o pipefail

readonly TEMP_SCREENSHOT=/tmp/pixelchanged.png
readonly TEMP_SCREENSHOT_LAST=/tmp/pixelchanged_last.png
# period for checking changes in seconds.
readonly period_sleep=5

last_hash=""

check_command() {
    local cmd="${1:-}"

    if ! hash "${cmd}" 2>/dev/null; then
        echo -e "pixelchanged: Could not find command '${cmd}'. Please install it."
        exit 1
    fi
}

# determine if current desktop is wayland or x11
determine_desktop_type()
{
    for session_id in $(loginctl list-sessions --no-legend | awk '{ print $1 }'); do
        local is_active=$(loginctl show-session -p Active --value $session_id)
        if [ $is_active == "yes" ];then
            desktop_type=$(loginctl show-session -p Type --value $session_id)
            echo "${desktop_type}"
            return 0
        fi
    done

    # todo notfound
}

check_commands()
{
    check_command "awk"

    if [ ${desktop_type} == "wayland" ];then
        check_command "grim"
        check_command "slurp"
        return 0
    fi

    # x11
    check_command "import"
    check_command "slop"
}

take_screenshot()
{
    if [ $desktop_type == "wayland" ];then
        grim -g "${pixel_area}" ${TEMP_SCREENSHOT}
        return 0
    fi

    # x11
    read -r G < <(echo $pixel_area)
    import -window root -crop $G ${TEMP_SCREENSHOT}
}

# select a region of the screen for monitoring changes
select_pixel_area()
{
    # wayland
    if [ $desktop_type == "wayland" ];then
        echo "$(slurp)"
        return 0
    fi

    # x11
    echo $(slop -of "%g")
}


# example function to play a sound
play_sound()
{
    check_command "cvlc"
    cvlc --play-and-exit ./Whistling.mp3
}

# example function to desktop notification
notify_desktop()
{
    notify-send --urgency=low -t 3000 "pixelchanged" "The was a pixel change!"
}

change_handler()
{
    echo "Playing sound"
    # put commands here that are executed when a change in the pixel happens
    #notify_desktop
    play_sound
}

readonly desktop_type=$(determine_desktop_type)

check_commands


echo "Please select a region of the screen"
readonly pixel_area=$(select_pixel_area)
echo "Selected region: ${pixel_area}. Desktop type: ${desktop_type}"
echo
echo "📡 Starting monitoring for changes of the selected region each ${period_sleep} seconds."

while :
do
    take_screenshot
    h="$(sha256sum ${TEMP_SCREENSHOT})"
    if [ -z "$last_hash" ]; then
        last_hash="$h"
        mv ${TEMP_SCREENSHOT} ${TEMP_SCREENSHOT_LAST} 
        sleep ${period_sleep}
        continue
    fi

    # pixel changes
    if [ "$h" != "$last_hash" ]; then
        change_handler
    fi

    last_hash="$h"
    mv ${TEMP_SCREENSHOT} ${TEMP_SCREENSHOT_LAST} 
    sleep ${period_sleep}
done
