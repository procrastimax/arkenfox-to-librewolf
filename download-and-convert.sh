#!/usr/bin/env sh

# This script bundles the funtionality of the download script and the converter script

# get path to the script
ABS_SCRIPT_PATH="$(dirname "$(realpath "$0")")"

cd "$ABS_SCRIPT_PATH" || exit 1

# check if wget is installed
if ! command -v wget; then
    echo "wget could not be found, please make sure it is installed"
    exit 1
fi

wget -v https://raw.githubusercontent.com/arkenfox/user.js/master/user.js || { echo "Could not download arkenfox user.js! Exitting..."; exit 1; }

OUTPUT_FILENAME="librewolf.overrides.cfg"
INPUT_FILENAME="user.js"

# this is the default path for a working flatpak installation (it also needs correctly setup XDG_DATA_DIRS path)
DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_FLATPAK="$HOME/.var/app/io.gitlab.librewolf-community/.librewolf"

# this is the librewolf path without setup XDG directories, or when no flatpak is used or for macos (not tested)
DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_MACOS="$HOME/.librewolf"

echo "Converting $INPUT_FILENAME to $OUTPUT_FILENAME"

if [ -d "$DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_FLATPAK" ]; then
    if [ -f "$DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_FLATPAK"/"$OUTPUT_FILENAME" ]; then
        echo "Creating backup of old .cfg file"
        cp -v "$DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_FLATPAK"/"$OUTPUT_FILENAME" "$DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_FLATPAK"/"$OUTPUT_FILENAME".bak
    fi

    echo "Saving $OUTPUT_FILENAME in $DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_FLATPAK"
    sed "s/user_pref/defaultPref/g" "$INPUT_FILENAME" > "$DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_FLATPAK"/"$OUTPUT_FILENAME"

elif [ -d "$DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_MACOS" ]; then
    if [ -f "$DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_MACOS"/"$OUTPUT_FILENAME" ]; then
        echo "Creating backup of old .cfg file"
        cp -v "$DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_MACOS"/"$OUTPUT_FILENAME" "$DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_MACOS"/"$OUTPUT_FILENAME".bak
    fi

    echo "Saving $OUTPUT_FILENAME in $DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_MACOS"
    sed "s/user_pref/defaultPref/g" "$INPUT_FILENAME" > "$DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_MACOS"/"$OUTPUT_FILENAME"

else
    if [ -f "$ABS_SCRIPT_PATH"/"$OUTPUT_FILENAME" ]; then
        echo "Creating backup of old .cfg file"
        cp -v "$ABS_SCRIPT_PATH"/"$OUTPUT_FILENAME" "$ABS_SCRIPT_PATH"/"$OUTPUT_FILENAME".bak
    fi

    echo "Neither $DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_FLATPAK nor $DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_MACOS exist, saving $OUTPUT_FILENAME in $ABS_SCRIPT_PATH"
    echo "Please make sure to find the location, in which the $OUTPUT_FILENAME should be put in on yourself! (here is a guide: https://librewolf.net/docs/settings/)"
    sed "s/user_pref/defaultPref/g" "$INPUT_FILENAME" > "$ABS_SCRIPT_PATH"/"$OUTPUT_FILENAME"
fi

echo "Deleting downloaded user.js"
rm "$INPUT_FILENAME"

echo "Parameters you may want to change the following properties:"
echo "- Letterboxing"
echo "- keyword enabled"
