#!bin/bash
a=5
b=10
ADD(){
    echo $(($a+$b))
}
Multiplication(){
    echo $(($a*$b))
}
read -p "enter + for ADD or * for Multiplication" action 
if [ "$action" == "+" ]; then
ADD
exit 0
elif [ "$action" == "*" ]; then
Multiplication
exit 0
else
echo invalid input
exit 1
fi