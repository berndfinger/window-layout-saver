# window-layout-saver
Scripts for saving and restoring Linux window layouts

## Usage:
1 - Check and if necessary modify the number of monitors(=screens) in variable _NUM_SCREENS_DEFAULT
2 - Run this script via cron in an interval of your choice, e.g. 5 minutes:

`# */5 * * * * ~/bin/save-windows.sh`

If you switch off monitors or detach your docking station so that all windows are moved
to the remaining screen, you can later move and resize all windows to the last multiscreen
layout by executing:

`# restore-windows.sh`
