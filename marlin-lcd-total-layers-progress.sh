#!/usr/bin/env bash

# If you are on OSX run `brew install gnu-sed --with-default-names` to install gnu sed to replace bsu sed.
# This script will replace the following line:
# '; layer 1, Z = 0.150'
# with 'M117 Layer 1 of 210'

# chmod +x marlin-lcd-total-layers-progress.sh
# ln -s ~/Documents/marlin-lcd-total-layers-progress.sh /usr/local/bin/marlin-lcd-total-layers-progress
# usage: marlin-lcd-total-layers-progress @[output_filepath]

GCODE_FILE=$1

if [ ! -f $GCODE_FILE ]; then
    echo "File not found!"
    say "file not found"
    exit;
fi

TOTAL_LAYERS=`cat $GCODE_FILE | awk '/; layer [0-9]+/ {print $0}' | tail -n1 | awk '/[0-9]+/ {gsub(",",""); print $3}' `

echo "Total layers are: $TOTAL_LAYERS"

/usr/local/bin/sed -i'' -r "s/^; layer ([0-9]+), Z\s?=\s?[0-9.]+/M117 Layer \1 of $TOTAL_LAYERS/" $GCODE_FILE

say $?
