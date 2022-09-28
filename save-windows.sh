#!/bin/bash
# shellcheck disable=SC2012,SC2086
# Reason for disabling SC2012: ls -1tr is used for sorting the files in chronological order,
#                              so find is not a replacement.
# Reason for disabling SC2086: Directory and file names do not contain spaces.
#
# Purpose: Save the geometry of all currently open windows to a file
# How to use:
# 1 - Check and if necessary modify the number of monitors(=screens) in variable _NUM_SCREENS_DEFAULT
# 2 - Run this script via cron in an interval of your choice, e.g. 5 minutes:
# */5 * * * * ~/bin/save-windows.sh
#
# Bernd Finger, Red Hat
# Tue Sep 27 11:04:57 CEST 2022

_NUM_SCREENS_DEFAULT=3

_DATE=$(date +%Y%m%d%H%M%S)
_GEOMETRY_DIR=~/.window-geometries
_GEOMETRY_FILE=${_GEOMETRY_DIR}/geometry-${_DATE}.txt

export DISPLAY=:0.0
xhost +localhost >/dev/null 2>&1

mkdir ${_GEOMETRY_DIR} 2>/dev/null

# Count the number of screens:
_NUM_SCREENS=$(wmctrl -lpG | awk '$2==-1 && $(NF-2) == "Desktop" && $NF == "Plasma"{a++}END{print a}')

# Save the window geometries only if the number of screens is as expected:
if [[ ${_NUM_SCREENS} -eq ${_NUM_SCREENS_DEFAULT} ]]; then
   wmctrl -lpG | awk '$2!=-1{print}' > ${_GEOMETRY_FILE}
fi

_NUM_GEOMETRY_FILES=$(ls ${_GEOMETRY_DIR}/geometry-*.txt | wc -l)

# Leave only the last 20 files in place:
if [[ ${_NUM_GEOMETRY_FILES} -gt 20 ]]; then
   (( _NUM_FILES_TO_DELETE = _NUM_GEOMETRY_FILES - 20 ))
   ls -1tr ${_GEOMETRY_DIR}/geometry-*.txt | head -${_NUM_FILES_TO_DELETE} | xargs rm
fi
