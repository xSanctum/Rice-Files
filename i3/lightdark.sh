#!/bin/bash

#i3 config swap
#rename current inactive in 'dark' to active
mv ~/.config/i3/dark/configinactive ~/.config/i3/dark/config

#rename current active to inactive
mv ~/.config/i3/config ~/.config/i3/configinactive

#move active (after rename) to 'dark'
mv ~/.config/i3/configinactive ~/.config/i3/dark/


#move old inactive into active
mv ~/.config/i3/dark/config ~/.config/i3/config



#.Xresources swap

#rename current inactive in 'darkX' to active
mv ~/darkX/.Xresourcesdark ~/darkX/.Xresources

#rename current active to inactive
mv ~/.Xresources ~/.Xresourcesdark

#move old active (after rename) to 'darkX'
mv ~/.Xresourcesdark ~/darkX/

#move old inactive into active
mv ~/darkX/.Xresources ~/.Xresources

xrdb ~/.Xresources

