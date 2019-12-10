#!bin/bash


read -p "enter two numbers" a b
action=$1

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