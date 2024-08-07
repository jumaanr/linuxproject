#!/bin/bash

# Ref : https://github.com/kodekloudhub/shell-scripting-for-beginners-course.git

# Running a shell script--------------------------------------------------------------------
bash create-and-launch-rocket.sh  # shell scripts executes line by line
sh create-and-launch-rocket.sh

# Defining shell script as a command

$ create-and-launch-rocket # how do we do this ?
# Note: Include this script to $PATH variable  by appending the script to the variable. And also remove .sh extension
$ export PATH=$PATH:/home/michael

# Exiting from a shell script
exit
exit 1 # this would return signal 1 , for any calling processes to identify it failed due to missing arguments
# port the errors 
echo "Error: Invalid Arguments" >&2 # prints the error message to standard error 'stderr' , which redirects the output to standard error

#----------------------Variables-------------------------------------------------------------------#
mission_name=mars-mission  #variables only can have alpha numeric values so - values not allowed
rocket_status=$(rocket-status $mission_name) # we can store output of another command in a variable
# best practice : variable names must be in lowercase with underscrores to seperate words
file_name="create-and-launch-rocket"
cp $file_name ${file_name}_bkp  # This is how you should encapsulate a variable so you could append the rest of the command. If the variable has been invoked within "" , then no problem you may use like $varible instead of ${variable}
$USER # This is an environment variable

#--------------------- Command Line Argument------------------------------------------------------#
$ create-and-launch-rocket saturn-mission # Here mission name has been passed as a command line argument
mission_name=$1 #first command line argument
# Note: Design the script in the mindset of reusability , use command line arguments to pass inputs
# commandline arguments are passed as strings in linux 

#--------------------- Read Input ----------------------------------------------------------------#
read mission_name # this way the cmdline will expect user input, however this does not prompt the user
mkdir $mission_name

read -p "Enter the mission Name: " mission_name
# Note to thought : A script should be re-usable , therefore using commandline arguments make the script inter-operable within other scripts. Having no user intervention
echo "Capital city of $1 is $2"


#--------------------- Arithmetic Operations -----------------------------------------------------#
# Method 1: Using expr

expr 6 + 3  # need a space between operator and number
expr 6 - 3  # need a space between operator and number
expr 6 / 3  # need a space between operator and number
expr 6 \* 3 # multipication requires escape charchter as well

A=6
B=3

expr $A + $B
expr $A - $B
expr $A / $B # does not retrun decimals, only integer
expr $A \* $B

# Method 2: Using (())

echo $(( A+B ))
echo $(( A-B ))
echo $(( A/B )) # does not return decimals, only integer
echo $(( A*B ))

echo $(( ++A )) # first added one and then value printed
echo $(( --A )) # like above
echo $(( A++ )) # first value A printed , then added one
echo $(( A-- ))

echo $A / $B | bc -l # returns decimal result , bc- basic calculator in linux , -l for floating point results

#--------------------- Conditional Logic -----------------------------------------------------#
# syntax:
if [condition]
then
    action to be performed
fi

# the condition of an if statement encapsulated in [[ ]]
# else if aka elif , else block can be added at the end
if [condition]
then
    action to be performed
elif [condition]
then
    2nd action to be performed
else
    execute this when either of above conditions are not met
fi

# comparisive statements [ string1 = string2 ] , should maintain a space between operators and encapsulated brackets
#? '=' or '!=' operator should only be used to compare strings 
# For numeric comparisons : -eq (equal) , -ne (not equal), -gt (greater than), -lt (less than) 

if [ $rocket_status = "failed" ]
then
  rocket-debug $mission_name
fi

# Method 2 of conditional operators which is available only bash
#* these are only available in Bash : https://github.com/kodekloudhub/shell-scripting-for-beginners-course/blob/master/docs/03-Flow-Control/01-Conditional-Logic.md#conditional-operators
[[ string1 = string2 ]]

# conditional operators
[ condition1 ] && [ condition2 ]
[ condition1 ] || [ condition2 ]
# example :
if [ $month_number -lt 1  ] || [ $month_number -gt 12 ]
then
    echo "Invalid month number given" >&2
    exit 2
fi
# some usecases
[ -z $mission_name ] # check if mission_name has a value , if there's no value returns TRUE
[ -e FILE ] # if file exists
[ -d FILE ] # if file exists and its a directory
[ -s FILE ] # if file exists and has size greater than 0
[ -x FILE ] # if the file executable
[ -w FILE ] # if the file is writable

#example : 
if [ -d /home/bob/caleston ]
then
        echo "Directory exists"
fi

#-------------------------------------------For Loop --------------------------------------------------------------------------
#Syntax
for item in list_of_items
do
    task item
done

list_of_items = lunar-mission jupiter-mission saturn-mission satellite-mission # this can be list of names seperated by space

for mission in lunar-mission jupiter-mission saturn-mission satellite-mission
do
    create-and-launch-rocket $mission
done

# Now in this case we type all the mission names in the for loop, for that we store all the missions in a file called mission-names.txt
for mission in `cat mission-names.txt`
do
    create-and-launch-rocket $mission
done

# Above can be written as below
for mission in $(cat mission-names.txt)
do
    create-and-launch-rocket $mission
done

# In following the mission-1 , mission-2 and goes through the iteration
for misson in 1 2 3 4 5 6 
do
    create-launch-rocket mission-$mission
done

# Iterate through certain number of iterations
for misson in {0..100}
do
    create-launch-rocket mission-$mission
done
# Other adaptations also possible , similar to C
for (( mission = 0 ; mission <= 100; mission++))
do
    create-launch-rocket mission-$mission
done
# -- Some practical usages
# counts the number of lines each file where the script runs
for file in $(ls)
do
    echo Line count of $file is $(cat $file | wc -l)
done

# install packages listed in a list
for packages in $(cat install-packages.txt)
do
    sudo apt-get -y install $package
done

# check the server uptimes in a list of servers
for packages in $(cat servers.txt)
do
    ssh $server uptime
done

#-------------------------------------------While Loop--------------------------------------------------------------------------#
# Helps to iterate until a condition satisfied : True
# Use while loop when you are not sure about number of iterations , this creates infinite loops and helps for menu driven programs
while [ condition ]
do
    task
done

# infinite loop example
while true
do
    task
    break # break statement in for loop or while loops breaks / terminates the loop and exit out of it. Useful for infinite loop
    continue # this keeps running the loop , especially requires when non of the conditionals met inside a loop or unexpected input given
done

# Example : Computer Shutdown program
while true
do
    echo " 1 - Shutdown "
    echo " 2 - Restart "
    echo " 3 - Exit Menu"
    read -p "Enter your choice: " choice
    
    if [ $choice -eq 1 ]
    then
        shutdown now
    elif [ $choice -eq 2 ]
    then
        shutdown -r now
    elif [ $choice -eq 3 ]
    then
        break # breaks the loop
    else
        continue # continues the loop
    fi
done

#-------------------------------------------Case Statement--------------------------------------------------------------------------#
# the value mentioned in paranthesis ) will execute based upon case's value . This is similar to switch statement in C
while true
do
    echo "1. Shutdown"
    echo "2. Restart"
    echo "3. Exit Menu"

    read -p "Enter your choice: " choice
    case $choice in
        1) shutdown now ;;  # double colon is mandatory
        2) shutdown -r now ;;
        3) break ;;
        *) continue ;; # * denotes any other value
    esac
done


#---------------------------------------- Shebang -----------------------------------------------------------------------------------#
ls -l /bin/sh  # check to what shell the bourne shell is referring to
echo $SHELL #check the current shell
# Note : When you share your script with other , you must specifically instruct to run it on bash shell, not any other shell
# shebang is used to specify what shell a shell script must run int , following instruct to run in bash shell
#!/bin/bash
# always start with shebang at the top of your script

#---------------------------------------- Exit Codes --------------------------------------------------------------------------------#
# If you run a command does not exists it returns an error, each command returns an exit code (return code)
# SUCCESS EXIT STATUS=0 , FAILURE: EXIT STATUS>0
# The exit code saved in a special variable called $?, to check the exit code
# most of the cases if command not found , the exit code is 127
echo $?
# good practice is to use exit code in script to indicate the caller
# Default exit code is 0


#---------------------------------------- Functions ---------------------------------------------------------------------------------#
# function does a specific task only
#syntax: Defining a function

function launch-rocket() {
    $mission_name=$1
    #define code here

    return 1 # similar to exit, but will only exit the function. Normal exit will exit the script. Only returns numbers
}

#syntax : Calling a function
launch-rocket lunar-mission  #mission_name has been called as a function parameter , where it pick input from cmdline argument 1

#oder of the function is important, because shell scripts read line by line , therefore function must always be defined before calling the function.

#-- Returning values
# the return only used to return exit codes , not values. Therefore return it using echo instead .
#!/bin/bash
  
function add(){
  echo $(( $1 + $2 )) #returns the value via echo statement
}

result=$(add 3 5)
echo "The result is $result"
 

#-------------------------------Best Practices/IDEs-----------------------
# Install shellcheck
apt-get install shellcheck # for dpkg 
yum install shellcheck # for rpm packages
#usage
shellcheck myscript.sh

# Ref : https://google.github.io/styleguide/shellguide.html   This provides recommendation and best practices. 


#----------------------------- End of Shell Scripting ----------------------#