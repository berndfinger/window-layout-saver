# window-layout-saver
Scripts for saving and restoring Linux window layouts, using the wmctrl program

## Usage:
1. Prepare file `save-windows.sh`: Check and if necessary modify the number of monitors(=screens)
by modifying variable `_NUM_SCREENS_DEFAULT`.
2. Run this script via cron in an interval of your choice, e.g. every 5 minutes:

`*/5 * * * * ~/bin/save-windows.sh`

If you switch off monitors or detach your docking station so that all windows are moved
to the remaining screen, you can move and resize all windows to the last multiscreen
layout after turning on your monitors or attaching your docking station by executing:

`# restore-windows.sh`
