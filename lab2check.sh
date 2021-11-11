#!/bin/bash

#display help information
help()
{
echo "Synopsis:"
echo
echo "This script should be in the same directory as your students' namesymkey1.bin.enc files. In the parent directory there should be a directory called lab1docs which contains your students' namesymkey.bin files (submitted to you after Crypto Lab 1). This script takes one argument which should be a text file that contains the names your students are using (one per line). The script will iterate through the student names in the file decrypting their encrypted symmetric key and comparing it to the symmetric key file they submitted in Lab 1. If the keys match the script displays name: OK. Otherwise it displays name: Not OK."
echo
echo "Syntax: lab2check.sh [-t] namefile.txt"
echo
echo "options:"
echo
echo "h      Print this help page"
echo
}

#get options
while getopts ":h" option; do
   case $option in
      h) #display help
         help
         exit;;
     \?) #incorrect option
         echo "Error: Invalid option"
         exit;;
   esac
done

if [[ $# -eq 0 ]]
then
   echo "You must provide a file with a list of student names as an argument. Run the script with -h option for more information."
fi

filename=$1
while read line; do
fileone="${line}symkey.bin"
filetwo="${line}symkey1.bin.enc"
filethree="${line}symkey1.bin"
#decrypt the symmetric key using RSA private key
openssl rsautl -decrypt -inkey teacherrsakey.pem -in $filetwo -out $filethree
#compare symmetric key file to the one sent by student in lab 1
var1=`cmp $filethree ../lab1docs/$fileone`
#if the keys match, display "OK", otherwise display "Not OK"
if [[ -z "$var1" ]]
then
   echo "${line}: OK"
else
   echo "${line}: Not OK"
fi
done < $filename
