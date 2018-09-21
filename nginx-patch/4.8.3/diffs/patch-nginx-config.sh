#!/bin/bash
#
# Blackduck by SYNOPSYS 2018 (c)
#

LOCATION=$(dirname $0)
FOLDER=$(basename $LOCATION)
if [ "$FOLDER" != "diffs" ]
then
  echo "Should be invoked outside of diffs folder"
  exit 1
fi

cd $(dirname $LOCATION)

for i in `ls *template` ; do
   if [ -f ${i}.orig ] ; then
      echo "Original file ${i}.orig is present. Not patching"
   else
      echo backing up original file
      cp $i ${i}.orig
      echo patching $i with ${i%.conf.template}.diff
      patch $i diffs/${i%.conf.template}.diff
   fi
done
