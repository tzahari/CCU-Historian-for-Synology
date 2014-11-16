#!/bin/bash

VERSION=0.7.6hf1
URL=http://www.ccu-historian.de/uploads/CCU-Historian/ccu-historian-$VERSION-bin.zip
TMPFILE=tmp.zip
TMPFOLDER=tmp
DESTFOLDER=CCU-Historian
DESTFILE=$DESTFOLDER/package.tgz
PKGFILE=CCU-Historian-$VERSION.spk

export COPYFILE_DISABLE=true

# Download
curl -o $TMPFILE $URL 

# Extract
mkdir $TMPFOLDER
cd $TMPFOLDER
unzip ../$TMPFILE

#Copy Lizenz.txt
#cp -av Lizenz.txt ../$DESTFOLDER/LICENSE
iconv -f iso8859-1 -t utf-8 Lizenz.txt > ../$DESTFOLDER/LICENSE

# Compress
tar cvfz ../$DESTFILE *

# Cleanup
cd ..
rm -r $TMPFILE $TMPFOLDER

# Create Package
cd $DESTFOLDER

# Update INFO
sed -i.bak -e "s/version=.*/version=\"$VERSION\"/" ./INFO
rm INFO.bak

MD5=`md5 -q package.tgz`
sed -i.bak -e "s/checksum=.*/checksum=\"$MD5\"/" ./INFO
rm INFO.bak

tar cvfz ../$PKGFILE --exclude '.*' *

