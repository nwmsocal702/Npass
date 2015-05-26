#!/bin/bash
#Npass Version 1.0
#date:06-07-2014
#Dependencies GNU BASH Version 4.3. GNU Coreutils 8.21
#Npass is a utility to create pseudo-random generated passwords using /dev/urandom.

#####Variables####
re='^[0-9]+$'
n=0
sdir=`pwd`

#####Functions####

parse () {
	head /dev/urandom | tr -dc [:$chartype:] | cut -c-$charnumber
}

makepasswd () {
	while [[ $n -lt $passnumber ]];
	do
	parse	
		n=$((n+1))
	done
}

terminalbar () {
echo ""
sleep .01
echo -n "[#"
sleep .05
echo -n "##"
sleep .05
echo -n "###"
sleep .05
echo -n "####"
sleep .05
echo -n "#####"
sleep .05
echo -n "######"
sleep .05
echo -n "#######"
sleep .05 
echo -n "########"
sleep .05
echo -n "#########"
sleep .05
echo -n "##########"
sleep .05
echo -n "###########"
sleep .05 
echo -n "############]"
echo ""
sleep .2
}

#Start of script

echo -n "How many characters long would you like the password to be:"
read charnumber

if ! [[ $charnumber =~ $re ]]
then
	echo "Error:$charnumber is not a Number" >&2; exit 1
fi


echo -n "How many passwords do you need:" 
read passnumber

if ! [[ $passnumber =~ $re ]]
then
	echo "Error:$passnumber is not a Number" >&2; exit 1
fi


echo "-------------------------------Password Types-----------------------------------"
echo "All Letters and digits                    : (a)"
echo "All Letters                               : (b)"
echo "All Digits                                : (c)"
echo "All printable characters                  : (d)"
echo "All lower case letters                    : (e)"
echo "All hexadecimal digits                    : (f)"
echo "All printable characters including space  : (g)"
echo "All punctuation characters                : (h)"
echo "All upper case letters                    : (i)"
echo "--------------------------------------------------------------------------------"
echo -n "Press enter for default (d), or otherwise select letter:"
read   chartype

echo -e "\n"

#Sets $chartype for correct tr option
case $chartype in
	a)
	chartype=alnum
	echo "Creating Passwords with All Letters and Digits:"
	;;
        b)
	chartype=alpha
	echo "Creating Passwords with All Letters:"
	;;
        c)
	chartype=digit
	echo "Creating Passwords with All Digits:"
	;;
        d)
	chartype=graph
	echo "Creating Passwords with All printable characters:"
	;;
        e)
	chartype=lower
	echo "Creating Passwords with All Lower case letters:"
	;;
        f)
	chartype=xdigit
	echo "Creating Passwords with all Hexadecimal Digits:"
	;;
        g)
	chartype=print
	echo "Creating Passwords with all printable characters including space:"
	;;
        h)
	chartype=punct
	echo "Creating Passwords with all punctuation characters:"
	;;
        i)
	chartype=upper
	echo "Creating Passwords with All upper case letters:"
	;;
        *)
	chartype=graph
	echo "Creating Default Passwords with all Printable characters:"
	;;
	esac


#Function to create loading bar
terminalbar

echo
echo -n "Save Password List to File? Default is no (n/y):"
read listfile

if [ "$listfile" = "y" ]
then
echo "Npass Version 1.0                                `date`" >> $sdir/npass.txt	
echo -e "\n" >> $sdir/npass.txt

#Main Function executes loop and parse function
makepasswd >> $sdir/npass.txt
echo "Saved Password List to $sdir/npass.txt"
else
echo -e "------------------------------------Password List-------------------------------\n"
makepasswd
echo -e "\n"
fi
exit 0
