#!/bin/sh
#

# Generate diff files
for i in `ls *template` ; do echo $i ; diff -u ${i}.orig $i >diffs/${i%.conf.template}.diff ; done

# Build container
docker build -t murkm/hub-nginx:4.8.3cattle0 .

