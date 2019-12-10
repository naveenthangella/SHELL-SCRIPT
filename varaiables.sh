#!bin/bash
## variable Declaration
Name=Naveen 
## accessing the variable
echo -e "Hello Im \e[31m $Name\e[0m" 
## command substitution syntax: $(command)
echo -e "\nToday is \e[32m $(date +%A)\e[0m"
echo -e "\nAnd the Date is\e[33m $(date +%B) $(date +%d) $(date +%Y)\e[0m"
## taking input from terminal
read -p "enter your phone number" number
echo -e "entered number is \e[46m$number\e[0m"