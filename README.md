# pixelchanged

`pixelchanged` is a simple `bash` script to detect changes in a region of your
screen and execute commands when the change happens.

`pixelchanged` works in linux (wayland and x11).

# Installation 

## Dependencies

Install the dependencies:

### Wayland

On debian based operating systems, install with:
    
    sudo apt install slurp grim awk

### X11

On debian based operating system, install with:
    
    sudo apt install imagemagick slop awk

## Install script

    curl -LO https://raw.githubusercontent.com/revelaction/pixelchanged/master/pixelchanged.sh 
    # make executable
    chmod +x pixelchanged.sh
    # copy scrypt to your path
    cp pixelchanged.sh ~/bin

# Usage

    ⤷ pixelchanged.sh
    Please select a region of the screen
    Selected region: 100x101+2346+397. Desktop type: x11

    📡 Starting monitoring for changes of the selected region each 10 seconds.


# Examples

## Desktop notification

Per default, the script creates a desktop notification when it detects a change
in the selected region.

    change_handler()
    {
        # put commands here that are executed when a change in the pixel happens
        notify_desktop
        # play_sound
    }

## Play sound

To play a sound when the selected region changes just substitute the path to a
music file in the `play_sound` function. 

    play_sound()
    {
        check_command "cvlc"
        cvlc --play-and-exit <your-path-to-a-sound-file>.opus
    }

and uncomment the call to the function in `change_handler`

    change_handler()
    {
        # put commands here that are executed when a change in the pixel happens
        # notify_desktop
        play_sound
    }

# Customize

Modify the script to run arbitrary commands by first creating a bash function:

    my_commands()
    {
        # my commands
    }

Add the function call to the `change_handler` function

    change_handler()
    {
        # put your commands function here 
        my_commands

        # notify_desktop
        # play_sound
    }




