#! /bin/bash
#set +o noclobber
#
#   $1 = Scanner IP
#   $2 = Filename
#

srcfilename=/scantmp/$2
destfilename=/scans/$(date +%F | sed s/-//g)$(date +%T | sed s/://g).pdf

img2pdf $srcfilename --output $destfilename
