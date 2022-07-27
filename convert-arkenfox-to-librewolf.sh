#!/usr/bin/env sh

# check if the location of user.js was provided by the user
if [ -z "$1" ]; then
    echo "Please call this script by providing the complete path to the arkenfox user.js!"
    exit
fi

OUTPUT_FILENAME="librewolf.overrides.cfg"
INPUT_FILENAME="$1"

# this is the default path for a working flatpak installation (it also needs correctly setup XDG_DATA_DIRS path)
DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_FLATPAK="$HOME/.var/app/io.gitlab.librewolf-community/.librewolf"

# this is the librewolf path without setup XDG directories, or when no flatpak is used or for macos (not tested)
DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_MACOS="$HOME/.librewolf"

# get path to the script
ABS_SCRIPT_PATH="$(dirname "$(realpath "$0")")"

echo "Converting $INPUT_FILENAME to $OUTPUT_FILENAME"

if [ -d "$DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_FLATPAK" ]; then
    echo "Saving $OUTPUT_FILENAME in $DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_FLATPAK"
    sed "s/user_pref/defaultPref/g" "$INPUT_FILENAME" >> "$DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_FLATPAK"/"$OUTPUT_FILENAME"

elif [ -d "$DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_MACOS" ]; then
    echo "Saving $OUTPUT_FILENAME in $DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_MACOS"
    sed "s/user_pref/defaultPref/g" "$INPUT_FILENAME" >> "$DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_MACOS"/"$OUTPUT_FILENAME"

else
    echo "Neither $DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_FLATPAK nor $DEFAULT_LIBREWOLF_OVERRIDE_CFG_PATH_MACOS exist, saving $OUTPUT_FILENAME in $ABS_SCRIPT_PATH"
    echo "Please make sure to find the location, in which the $OUTPUT_FILENAME should be put in on yourself! (here is a guide: https://librewolf.net/docs/settings/)"
    sed "s/user_pref/defaultPref/g" "$INPUT_FILENAME" >> "$ABS_SCRIPT_PATH"/"$OUTPUT_FILENAME"
fi
