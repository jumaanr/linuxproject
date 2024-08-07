#!/bin/bash
month_number=$1

# User case statement to simplify if , else process since we are expecting a certain inputs from user

if [ -z $month_number ]
then
    echo "No month number given. Please enter a month number as a command line argument."
    echo "eg: ./print-month-number 5"
    exit 1   
fi
case $month_number in
    1) echo January ;;
    2) echo February ;;
    3) echo March ;;
    4) echo April ;;
    5) echo May ;;
    6) echo June ;;
    7) echo July ;;
    8) echo August ;;
    9) echo September ;;
    10) echo October ;;
    11) echo November ;;
    12) echo December ;;
    *) echo "Invalid month number given. Please enter a valid number - 1 to 12 "
esac