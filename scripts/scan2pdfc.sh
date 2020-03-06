#! /bin/bash
#set +o noclobber
#
#   $1 = Scanner IP
#   $2 = Filename
#

srcfilename=/scantmp/$2
tmpfilename=/scantmp/$(date +%F | sed s/-//g)$(date +%T | sed s/://g).pdf
destfilename=/scans/$(date +%F | sed s/-//g)$(date +%T | sed s/://g)_ocr.pdf

img2pdf $srcfilename --output $tmpfilename
ocrmypdf $tmpfilename $destfilename
