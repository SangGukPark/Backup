#!/bin/bash

cmdCnt=$#
temp=$1
path="/etc/default/grub"

str1="quiet splash"

if [ $cmdCnt -lt 1 ]; then
	echo "You have to input gui|text"
	exit
fi

if [ $temp = "gui" ]; then

	text=`grep [#]*GRUB_CMDLINE_LINUX_DEFAULT $path`

	if [ ${text:0:1} = '#'  ]; then
		length=${#text}
		sed -i "s/$text/${text:1:$length}/g" $path
	fi
	
	text=`egrep [#]*GRUB_CMDLINE_LINUX=+ $path`

	if [ ${text:0:1} != '#' ]; then
		sed -i "s/$text/#$text/g" $path
	fi
	
	text=`egrep [#]*GRUB_TERMINAL=+ $path`
	
	if [ ${text:0:1} != '#' ]; then
		sed -i "s/$text/#$text/g" $path
	fi

	update-grub	
	systemctl set-default graphical.target

elif [ $temp = "text" ]; then
	text=`grep [#]*GRUB_CMDLINE_LINUX_DEFAULT $path`

	if [ ${text:0:1} != '#'  ]; then
		sed -i "s/$text/#$text/g" $path
	fi
	
	text=`egrep [#]*GRUB_CMDLINE_LINUX=+ $path`

	if [ ${text:0:1} = '#' ]; then
		length=${#text}
		sed -i "s/$text/${text:1:$length}/g" $path
	fi

	text=`egrep [#]*GRUB_TERMINAL=+ $path`
	
	echo $text
	if [ ${text:0:1} = '#' ]; then
		length=${#text}
		sed -i "s/$text/${text:1:$length}/g" $path
	fi
	
	update-grub
	systemctl set-default multi-user.target
else
	echo "You have to input gui|text"
fi
