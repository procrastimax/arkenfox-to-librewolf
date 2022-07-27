#!/usr/bin/env sh

# check if wget is installed
if ! command -v wget; then
    echo "wget could not be found, please make sure it is installed"
    exit
fi

wget -v https://raw.githubusercontent.com/arkenfox/user.js/master/user.js
