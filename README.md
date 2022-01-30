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

    ⤷ ./pixelchanged.sh
    Please select a region of the screen
    Selected region: 100x101+2346+397. Desktop type: x11

    📡 Starting monitoring for changes of the selected region each 10 seconds.


# Examples

## Desktop notification

## Play sound

# Customize



