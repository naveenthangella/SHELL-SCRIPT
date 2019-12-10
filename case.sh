#!bin/bash

action = $1
read -p "enter two numbers" a b

case $action in
ADD)
    echo $(($a+$b))
    exit 0
    ;;
Multiply)
    echo $(($a*$b))
    exit 0
    ;;
Divide)
    echo $(($a/$b))
    exit 0
    ;;
substract)
    echo $(($a*$b))
    exit 0
    ;;
*)
    echo invalid input
    exit 1
    ;;
esac