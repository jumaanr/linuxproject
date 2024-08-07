#!/bin/bash
while true
do
    echo " Menu-Driven Calculator "
    echo "1.Add"
    echo "2.Substract"
    echo "3.Multiply"
    echo "4.Devide"
    echo "5.Average"
    echo "6.Quit"

    read -p " Please enter the menu number of mathematical function to be performed : " choice

    case $choice in
        1)
            read -p "Enter first number: " number_1
            read -p "Enter second number: " number_2
            echo "Result is : " $(( $number_1 + $number_2 ))
            ;;
        2)         
            read -p "Enter first number:  " number_1
            read -p "Enter second number: " number_2
            echo "Result is : " $(( $number_1 - $number_2 ))
            ;;
        3)         
            read -p "Enter first number:  " number_1
            read -p "Enter second number: " number_2
            echo "Result is : " $(( $number_1 * $number_2 ))
            ;;
        4)         
            read -p "Enter first number:  " number_1
            read -p "Enter second number: " number_2
            echo "Result is : " $(( $number_1 / $number_2 ))
            ;;
        5) 
            read -p "Enter first number:  " number_1
            read -p "Enter second number: " number_2
            average=$(echo $(( $number_1 + $number_2 )) / 2 | bc -l)
            echo "Result is : " $average
            ;;
        6) break
            ;;
    esac

done