#!/bin/bash

# Mini-script to change the file date/time stamp of pics
# in the given directory.
#
# When downloading pics from a datasource, i. e. a cloud service often the real
# file date/time stamp gets lost. This script extrapolates the creation date/time
# from the EXIF data of the image and changes then the file properties.
#
# Tested on macOS 10.12
#
# (c) René Winkelmeyer / mail@winkelmeyer.com / muenzpraeger

PICS=/put/your/folder/here/*JPG

for F in $PICS
do
   EXIFDATETIME=$(mdls $F | grep ContentCreationDate | awk -F "=" '{print $2}')
   EXIFDATE=$(echo $EXIFDATETIME | awk '{split($1,dates,"-")} END {print dates[2]"/"dates[3]"/"dates[1]}')
   EXIFTIME=$(echo $EXIFDATETIME | awk '{print $2}')

   SetFile -d "$EXIFDATE $EXIFTIME" -m "$EXIFDATE $EXIFTIME" $F
done