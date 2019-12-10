#!bin/bash

Name=Naveen
echo -e "Hello Im \e[31m $Name\e[0m"
echo -e "\nToday is \e[32m $(date +%A)\e[0m"
echo -e "\nAnd the Date is\e[33m $(date +%B) $(date +%d) $(date +%Y)"
read number
echo $number