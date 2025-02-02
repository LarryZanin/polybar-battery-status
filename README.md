# Polybar-battery-status
A custom Polybar module that displays battery status on the bar.


## INSTALLATION:
-    Execute these commands sequentially.
####    1)Clone the repository:
        git clone https://github.com/yourusername/polybar-battery-status.git
####    2)Copy the scripts to the polybar-scripts directory and make them executable:
        mkdir -p ~/polybar-scripts
        cp polybar-battery-status/battery-status.sh ~/polybar-scripts/
        chmod +x ~/polybar-scripts/battery-status.sh
####    3)Add the module to your Polybar configuration file (yourwaytopolybar/polybar/config):
    [module/battery-combined-udev]
    type = custom/script
    exec = ~/polybar-scripts/battery-status.sh &
    intarval = 30

####    4)Add the module to your Polybar bar:
        [bar/yourbarname]
        modules-right = battery-status

####    5*)Restart Polybar if opened:
        polybar-msg cmd restart

## LICENSE:
    This project is licensed under the MIT License. See LICENSE for details.
