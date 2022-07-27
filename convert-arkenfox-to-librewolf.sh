#!/usr/bin/env sh

# TODO: check for valid input file
OUTPUT_FILENAME="librewolf.overrides.cfg"
INPUT_FILENAME="$1"

printf "Converting %s to %s" "$INPUT_FILENAME" "$OUTPUT_FILENAME"

sed "s/user_pref/defaultPref/g" "$INPUT_FILENAME" >> "$OUTPUT_FILENAME"

echo "Created $OUTPUT_FILENAME"
