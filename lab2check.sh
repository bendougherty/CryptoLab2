#!/bin/bash

filename=$1
while read line; do
fileone="${line}symkey.bin"
filetwo="${line}symkey1.bin.enc"
filethree="${line}symkey1.bin"
#decrypt the symmetric key using RSA private key
openssl rsautl -decrypt -inkey teacherrsakey.pem -in $filetwo -out $filethree
#compare symmetric key file to the one sent by student in lab 1
var1=`cmp -s $filethree ../lab1docs/$fileone`
#if the keys match, display "OK", otherwise display "Not OK"
if [[ $var1 -eq 0 ]]
then
   echo "${line}: OK"
else
   echo "${line}: Not OK"
fi
done < $filename
