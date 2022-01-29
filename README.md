# pixelchanged

`pixelchanged` is a simple `bash` script to detect changes in a region of the
desktop and execute commands when the event happens.

`pixelchanged` works in linux (wayland and x11).

# Installation 


## Dependencies

- awk

### wayland

- grim 
- slurp

On debian based operating system, install with:
    
    sudo apt install slurp grim awk

### x11

- `import`
- `slop`

On debian based operating system, install with:
    
    sudo apt install imagemagick slop awk

## script
