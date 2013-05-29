#!/bin/sh
# Download EiSamay in pdf format
# Author: Shuvankar Sarkar
# Date: 29 May 2013

#Find systemdate. e.g. 2952013. To discard 0 from month -m is used.
currdate=$(date +"%d%-m%Y")

echo 'Creating directory...'
#Creating directory. Downloaded files will be stored here.
mkdir $currdate

count=1
str=''

echo 'Downlod starting...'
while [ $count -lt 14 ]
do
	# -c is used to resume(continue) downloding if network failed. -P is for saving the files to particular destination.
	wget -c http://www.epaper.eisamay.com/epaperpdf/$currdate/$currdate-md-em-$count.pdf -P ./$currdate

	#BUG:fixed. Collect the file name. It is used to pass parameter while joining pdf. I used wild char *pdf which joined the pages alphabetically (e.g. page1 then page10)
	 str=$str' '$currdate-md-em-$count.pdf

   count=`expr $count + 1`	 
done

#Join the pdf files. Download pdftk(http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/) to make it work.
echo 'Joining the pdf files....'
pdftk $str cat output ./$currdate/$currdate.pdf

echo 'Joining Completed...Enjoy eisamay'
echo 'Script Developed by Shuvankar Sarkar. Thank you for using it.'
