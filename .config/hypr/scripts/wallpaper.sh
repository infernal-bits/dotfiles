#!/bin/bash
#  _      __     ____                      
# | | /| / /__ _/ / /__  ___ ____  ___ ____
# | |/ |/ / _ `/ / / _ \/ _ `/ _ \/ -_) __/
# |__/|__/\_,_/_/_/ .__/\_,_/ .__/\__/_/   
#                /_/       /_/             
# -----------------------------------------------------
# Check to use wallpaper cache
# -----------------------------------------------------

if [ -f ~/.config/ml4w/settings/wallpaper_cache ]; then
    use_cache=1
    echo ":: Using Wallpaper Cache"
else
    use_cache=0
    echo ":: Wallpaper Cache disabled"
fi

# -----------------------------------------------------
# Create cache folder
# -----------------------------------------------------
ml4w_cache_folder="$HOME/.cache/ml4w/hyprland-dotfiles"

if [ ! -d $ml4w_cache_folder ]; then
    mkdir -p $ml4w_cache_folder
fi

# -----------------------------------------------------
# Set defaults
# -----------------------------------------------------

force_generate=0
generatedversions="$ml4w_cache_folder/wallpaper-generated"
waypaperrunning=$ml4w_cache_folder/waypaper-running
cachefile="$ml4w_cache_folder/current_wallpaper"
blurredwallpaper="$ml4w_cache_folder/blurred_wallpaper.png"
squarewallpaper="$ml4w_cache_folder/square_wallpaper.png"
rasifile="$ml4w_cache_folder/current_wallpaper.rasi"
blurfile="$HOME/.config/ml4w/settings/blur.sh"
defaultwallpaper="$HOME/wallpaper/default.jpg"
wallpapereffect="$HOME/.config/ml4w/settings/wallpaper-effect.sh"
blur="50x30"
blur=$(cat $blurfile)

# Ensures that the script only run once if wallpaper effect enabled
if [ -f $waypaperrunning ]; then
    rm $waypaperrunning
    exit
fi

# Create folder with generated versions of wallpaper if not exists
if [ ! -d $generatedversions ]; then
    mkdir $generatedversions
fi

# -----------------------------------------------------
# Get selected wallpaper
# -----------------------------------------------------

if [ -z $1 ]; then
    if [ -f $cachefile ]; then
        wallpaper=$(cat $cachefile)
    else
        wallpaper=$defaultwallpaper
    fi
else
    wallpaper=$1
fi
used_wallpaper=$wallpaper
echo ":: Setting wallpaper with source image $wallpaper"
tmpwallpaper=$wallpaper

# -----------------------------------------------------
# Copy path of current wallpaper to cache file
# -----------------------------------------------------

if [ ! -f $cachefile ]; then
    touch $cachefile
fi
echo "$wallpaper" >$cachefile
echo ":: Path of current wallpaper copied to $cachefile"

# -----------------------------------------------------
# Get wallpaper filename
# -----------------------------------------------------
wallpaperfilename=$(basename $wallpaper)
echo ":: Wallpaper Filename: $wallpaperfilename"

# -----------------------------------------------------
# Wallpaper Effects
# -----------------------------------------------------

if [ -f $wallpapereffect ]; then
    effect=$(cat $wallpapereffect)
    if [ ! "$effect" == "off" ]; then
        used_wallpaper=$generatedversions/$effect-$wallpaperfilename
        if [ -f $generatedversions/$effect-$wallpaperfilename ] && [ "$force_generate" == "0" ] && [ "$use_cache" == "1" ]; then
            echo ":: Use cached wallpaper $effect-$wallpaperfilename"
        else
            echo ":: Generate new cached wallpaper $effect-$wallpaperfilename with effect $effect"
            notify-send --replace-id=1 "Using wallpaper effect $effect..." "with image $wallpaperfilename" -h int:value:33
            source $HOME/.config/hypr/effects/wallpaper/$effect
        fi
        echo ":: Loading wallpaper $generatedversions/$effect-$wallpaperfilename with effect $effect"
        echo ":: Setting wallpaper with $used_wallpaper"
        touch $waypaperrunning
        waypaper --wallpaper $used_wallpaper
    else
        echo ":: Wallpaper effect is set to off"
    fi
else
    effect="off"
fi

# -----------------------------------------------------
# Execute matugen
# -----------------------------------------------------

echo ":: Execute matugen with $used_wallpaper"
$HOME/.cargo/bin/matugen image $used_wallpaper -m "dark"

# -----------------------------------------------------
# Execute wallust
# -----------------------------------------------------

echo ":: Execute wallust with $used_wallpaper"
$HOME/.cargo/bin/wallust run $used_wallpaper

# -----------------------------------------------------
# Walcord (NOT SUPPORTED)
# -----------------------------------------------------

if type walcord >/dev/null 2>&1; then
    walcord
fi

# -----------------------------------------------------
# Reload Waybar
# -----------------------------------------------------

sleep 2
$HOME/.config/waybar/launch.sh
# killall -SIGUSR2 waybar

# -----------------------------------------------------
# Reload nwg-dock-hyprland
# -----------------------------------------------------

$HOME/.config/nwg-dock-hyprland/launch.sh &

# -----------------------------------------------------
# Update Pywalfox
# -----------------------------------------------------

if type pywalfox >/dev/null 2>&1; then
    pywalfox update
fi

# -----------------------------------------------------
# Update SwayNC
# -----------------------------------------------------
sleep 0.1
swaync-client -rs

# -----------------------------------------------------
# Created blurred wallpaper
# -----------------------------------------------------

if [ -f $generatedversions/blur-$blur-$effect-$wallpaperfilename.png ] && [ "$force_generate" == "0" ] && [ "$use_cache" == "1" ]; then
    echo ":: Use cached wallpaper blur-$blur-$effect-$wallpaperfilename"
else
    echo ":: Generate new cached wallpaper blur-$blur-$effect-$wallpaperfilename with blur $blur"
    # notify-send --replace-id=1 "Generate new blurred version" "with blur $blur" -h int:value:66
    magick $used_wallpaper -resize 75% $blurredwallpaper
    echo ":: Resized to 75%"
    if [ ! "$blur" == "0x0" ]; then
        magick $blurredwallpaper -blur $blur $blurredwallpaper
        cp $blurredwallpaper $generatedversions/blur-$blur-$effect-$wallpaperfilename.png
        echo ":: Blurred"
    fi
fi
cp $generatedversions/blur-$blur-$effect-$wallpaperfilename.png $blurredwallpaper

# -----------------------------------------------------
# Create rasi file
# -----------------------------------------------------

if [ ! -f $rasifile ]; then
    touch $rasifile
fi
echo "* { current-image: url(\"$blurredwallpaper\", height); }" >"$rasifile"

# -----------------------------------------------------
# Created square wallpaper
# -----------------------------------------------------

echo ":: Generate new cached wallpaper square-$wallpaperfilename"
magick $tmpwallpaper -gravity Center -extent 1:1 $squarewallpaper
cp $squarewallpaper $generatedversions/square-$wallpaperfilename.png
