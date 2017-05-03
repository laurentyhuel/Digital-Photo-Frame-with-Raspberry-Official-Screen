# Digital Photo Frame (slideshow) with Raspberry + Official screen

## Description
Create a digital photo frame with Raspberry with official touch screen

## Features 

* Full screen photo
* touch screen to quit slideshow
* Random image

### feh
feh is an image viewer with slideshow and fullscreen options.

### Xbindkeys
Xbindkeys is a program that allows to bind commands to certain keys or key combinations on the keyboard. Xbindkeys works with multimedia keys and is independent of the window manager and desktop environment. 

We use it to catch touch on screen and convert it to quit slideshow.

## Setup
This tutorial is done for debian or ubuntu distrib.

### Disable sleep mode
Force the screen to stay on

```bash
sudo nano /etc/lightdm/lightdm.conf
```

Add the following lines to the [SeatDefaults] section:

```bash
# don't sleep the screen
xserver-command=X -s 0 dpms
```
### Install feh + Xbindkeys
feh is an image viewer with slideshow and fullscreen options

to install it:
```bash
sudo apt-get install feh xbindkeys
```

## Create slideshow script
Create a bash script file in your home and edit with nano:
```bash
nano /home/pi/SlideShow.sh
```
Paste and customize this script:
```bash
#!/bin/sh
feh --recursive --randomize --auto-zoom --fullscreen --borderless --hide-pointer --cycle-once --slideshow-delay 5 --image-bg black /media/pi/ToshibaExt/Images/ & # run feh in background with appropriate options
echo '"pkill -n feh; pkill -n xbindkeys"'>xbindkeys.temp # create file with commands to kill feh and xbindkeys
echo "b:1">>xbindkeys.temp # when button 1 is pressed
xbindkeys -n -f xbindkeys.temp # execute xbindkeys using created file and not a daemon
rm xbindkeys.temp # dump the file
```
### Customize feh
* Replace /media/pi/ToshibaExt/Images/ folder with root folder of your images
* --recursize : Use images in folder and in sub-folders
* --randomize : When viewing multiple files in a slideshow, randomize the file list before displaying
* --auto-zoom : Zoom pictures to screen size in fullscreen / fixed geometry mode.
* --fullscreen : Make the window fullscreen. Note that in this mode, large images will always be scaled down to fit the screen
* --borderless : Create borderless windows.
* --hide-pointer : Hide mouse pointer
* --cycle-once : Exit feh after one loop through the slideshow.
* --slideshow-delay 5 : For slideshow mode, wait x seconds between automatically changing slides
* --image-bg black : Use style as background for transparent image parts and the like. Accepted values: checks, white, black. The default for windowed mode is checks, while fullscreen defaults to black.

## Add new shortcut in menu:
Create shorcut file and edit wit with nano:
```bash
nano /home/pi/.local/share/applications/fehslideshow.desktop
```

Paste this content to file:
```
[Desktop Entry]
Comment=
Terminal=false
Name=SlideShow
Exec=/home/pi/SlideShow.sh
Type=Application
Icon=gpicview
```

