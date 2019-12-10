#!bin/bash

Name=Naveen
echo -e "Hello Im \e[31m $Name\e[0m"
echo -e "\nToday is \e[32m $(date +%A)\e[0m"
echo -e "\nAnd the Date is\e[33m $(date +%B) $(date +%d) $(date +%Y)\e[0m"
read -p "enter your phone number" number
echo -e"entered number is \e[46m$number"