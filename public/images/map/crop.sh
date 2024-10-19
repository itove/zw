#!/bin/bash
#
# vim:ft=sh

############### Variables ###############

############### Functions ###############

############### Main Part ###############

convert map.png -crop 8x8@  +repage  +adjoin  %d.png
