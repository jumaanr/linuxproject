#!/bin/bash
while true
do
    # introduction
    echo " Menu-Driven Calculator "
    echo "1.Add"
    echo "2.Substract"
    echo "3.Multiply"
    echo "4.Devide"
    echo "5.Quit"

    read -p " Please enter the menu number of mathematical function to be performed : " choice

    if [ $choice -eq 1 ] 
    then
        read -p "Enter first number: " number_1
        read -p "Enter second number: " number_2
        echo "Result is : " $(( $number_1 + $number_2 )) 
    elif [ $choice -eq 2 ]
    then
        read -p "Enter first number:  " number_1
        read -p "Enter second number: " number_2
        echo "Result is : " $(( $number_1 - $number_2 ))         
    elif [ $choice -eq 3 ]   
    then
        read -p "Enter first number:  " number_1
        read -p "Enter second number: " number_2
        echo "Result is : " $(( $number_1 * $number_2 ))   
    elif [ $choice -eq 4 ]
    then
        read -p "Enter first number:  " number_1
        read -p "Enter second number: " number_2
        echo "Result is : " $(( $number_1 / $number_2 ))
    elif [ $choice -eq 5 ]
    then
        break
    fi
done