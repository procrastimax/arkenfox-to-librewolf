# Arkenfox-to-Librewolf

This repo contains a script to update and convert the firefox user.js from [arkenfox](https://github.com/arkenfox/user.js) to a config file that can be read by librewolf called `librewolf.overrides.cfg` [here](https://librewolf.net/docs/settings/).

## Usage

Just call `sh download-and-convert.sh`, then the latest user.js from the arkenfox project is downloaded into the folder the script resides in, then the user.js is converted to the librewolf.overrides.cfg, which is then moved to the specific librewolf folder.
If the folder can not be found, the config file is just saved in the script folder and the user has to move it himself.
