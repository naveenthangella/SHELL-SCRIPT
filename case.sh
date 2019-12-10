#!bin/bash


read -p "enter two numbers" a b
echo -e "enter the operation:\n\t 1.ADD\n\t 2.Subtract \n\t 3.Multiply \n\t 4.Divide"
read action

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
Subtract)
    echo $(($a-$b))
    exit 0
    ;;
*)
    echo invalid input
    exit 1
    ;;
esac