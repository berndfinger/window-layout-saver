#!/bin/bash
# shellcheck disable=SC2012,SC2059,SC2086
# Reason for disabling SC2012: ls -1tr is used for sorting the files in chronological order,
#                              so find is not a replacement.
# Reason for disabling SC2059: Directory and file names do not contain spaces.
# Reason for disabling SC2086: Directory and file names do not contain spaces.
#
# Purpose: Restore the geometry of all currently open windows from a file
# Note: In some cases, all windows are moved 29 pixels down if the stored window positions
# are used. So the vertical position needs to be specified 29 pixels up.
#
# Bernd Finger, Red Hat
# Tue Sep 27 11:04:57 CEST 2022

_VERTICAL_OFFSET=29

_GEOMETRY_DIR=~/.window-geometries
_LAST_GEOMETRY_FILE=${_GEOMETRY_DIR}/$(ls -1tr ${_GEOMETRY_DIR} | tail -1)

if [[ ! -f ${_LAST_GEOMETRY_FILE} ]]; then
   echo "Could not find geometry file in ${_GEOMETRY_DIR}. Exit."
fi

printf "Restoring window geometries from file ${_LAST_GEOMETRY_FILE}... "
awk '{system ("wmctrl -i -r "$1" -e "$3","$4","$5-'${_VERTICAL_OFFSET}'","$6","$7)}' ${_LAST_GEOMETRY_FILE}
_RC=$?
if [[ ${_RC} -eq 0 ]]; then
   echo "done."
fi
