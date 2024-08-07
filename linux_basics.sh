#!/bin/bash

subscription-manager register --username rimzy.jumaan@gmail.com --password 1YB3gKYQDk9y --auto-attach #RHEL Subscription Manager

#-----------------------Working with Shell--------------------------------#
:<<'END_COMMENT' 

Linux shell is text based inteface between user and operating system (kernel)
~ represents the home directory

Argument acts as an input to a command
command -A argument , here A is a flag/switch/option

Command Types :
1. Internal : Part of the shell itself (echo,cd,pwd,set)
2. External : Binary programs and scripts pre-installed , installed by user (mv,data,uptime,cp)

Check whether internal or external using 'type command'
pwd - present working directory
cd - change directory



-- Create a directory structure

Absolute Path vs Relative Path

Absolute Path is a location of a file denoted from the root directory ; /home/michael/mydir
Relative Path is the path inrelation to the present working directory ; cd mydir

About shell :

Fact: Bash is probably the most popular shell because its features such as auto completion and brace expansion , Name is Bourne again shell

chsh # To change the shell 

bash : /bin/bash
bourne : /bin/sh

Change shell for a certain user : sudo chsh -s /bin/sh bob


Features of bash:

- command auto completion
- can create custom aliases :  alias dt=date
	echo 'alias ll="ls -l"' >> ~/.profile
- history  ; to get a list of previously run commands

Bash Environment Variables

Environment variables in specific stores users login session , which is used by the shell when executing commands 
To see a list of all environment variable use following command

$ env
$SHELL ; stores the vaule of type of shell

$ export OFFICE=caleston ; to set an environment variable 
Office=caleston ; this will only create the variable within the shell, the vaule is not carried to another process or login

Make any variable persistent over subsequent login or reboot , add them to ~/.profile  or ~/.pam_environment file in the users home directory

Example :  
echo 'export MY_VARIABLE="example_value"' >> ~/.profile
echo 'alias ll="ls -l"' >> ~/.profile

Update alias for a certain profile 

echo 'alias up=uptime' >> ~bob/.profile
update PS1 vairable
echo 'PS1="[\d]\u@\h:\w$"' >> ~/.profile


Path Variables

When a user insert an external command into the shell , shell uses $PATH variable to search these external commands
To see the directories defined in $PATH variable, use :

echo $PATH 

If a path variable does not have the location of a command or defined, running a command by itself will result in a failure
To check the location of a command to be identified use:

which command_name 

if above command does not provide a location, it means the external command is not defined in $PATH 
To add it we can use export command

$ export PATH=$PATH:/locationofExternalCommand 
ie: export PATH=$PATH:/opt/obs/bin/
egain we can check the which command at the end

Bash Prompt

[~]$  This is called as bash prompt
~ present working directory (~ its home )
$ = User prompt symbol

This can provide meaning information about name of the user, name of the system and location of the system 
This can be customized to show username and the hostname ; Especially helpfull in remote connections

[michael@prod-server]$

The bash prompt set and controlled by a special shell environment variable, most common of this and one we are interseted is about :
$PS1  variable
to see the vaule assigned to this variable type: echo $PS1
result :  [\W]$
\W = Present working directory
$ = Prompt symbol

How to customize the Bash Prompt ?

The bash prompt can be customized by updating the PS1 variable
Lets now change the prompt, only to display Ubuntu Server 

PS1="ubuntu-server"
Now lets checm it :  echo $PS1 , this will result "ubuntu-server" in shell


END_COMMENT

echo MessageToPrint
echo $HOME # prints the path to home directory
echo $SHELL #prints the current shell
type echo #chck whether a command is internal or External
uptime    #shows how long system has been running from last reboot
mkdir -p #allows creation of recursive directories (directories through path)

pushd #remembers the current working directory before changing the directory specified in the command argument
pushd /etc/hosts # now you have moved the current directory to hosts directory , to return yourself to the directory you have originally working on issue;
popd #return back to the directory you performed pushd 

mv /home/michael/Europe/Morocco /home/michael/Africa # mv sourfileorDirectory destinationDirectory , Move files or directories
cp Asia/India/Mumbai/City.txt /Africa/Egypt/Cairo # cp SourceFileorDirectory DrestinatioDirectory , Copy files or directories
rm Europe/UK/London/Tottenham.txt # rm FileName
cp -r Asia/India/Mumbai /Africa/Egypt/Cairo # Copy directories , recursively
rm -r Europe/UK/London # Delete directories, recursively

cat > Africa/Egypt/Cairo/City.txt # Enter content to a file , use 'Enter' for newline, (crtl + d) to exit
touch /home/michael/Africa/Cairo/City.txt # create a file

#See content of a file
more file_name # view text files in a scrollable manner, [Space] scroll the display , [Enter] scroll the display one line , [b] - scrolls the display backward one screenful data, [/] - Search text
less file_name # allows you to view the context of a file , up arrow & down to scroll , / to search text

ls -l # codeName : long list , provides more details of file such as , ( Access modes,ownership, the last accessed time )
ls -a # view a hidden file or directories, preceded by a single '.' , .bashrc | . (single dot refers to current working directory ) , .. (refers to the directory in the file system, above or before the current directory . This was seen previously in the cd.. command
ls -lt #list all the files in the order they were modified
ls -ltr # revers of above

# Getting Help
whatis command # Displays a one line description what a command does
man command # Provide detailed information about a certain command, as well as command options
date --help # Gives some breif information and usage about a command
apropos command # will search through the man page names, decriptions for instances of the keyword. Useful if you want to lookup all commands within a system that contains specific keyword

echo 'alias up="uptime"' >> ~/.profile


#----------------------Linux Core Concepts-------------------------------#

uname  # display information about the kernel
uname -r or uname -a # to print the kernel version

dmesg #tool used to display message from an area of a kernel called ringBuffer. When linux booted-up various messages comes  from to screeen.
dmesg | grep -i usb

udevadm info --query=path --name=/dev/sda5 #queries for database about udev information
udevadm monitor #monitor kernel uevents

lspci # get information about PCI devices (Nework cards, graphic, Wireless, Raid controllers etc)
lsblk # get information on block devices, Major number and Minor Number
lscpu # give information on CPU
lsmem # give information on Memory
lsmem --summary # give summary information
free -m # give memory usage 
lshw # Get full list of hardware information

ls -l /sbin/init # check if the initd pointers to systemd

# Linux Run Levels
runlevel #check the runlevel
systemctl get-default #get the current run level
#This command looks up the file at , there is a symbolic link 
/etc/systemd/system/default.target -> /lib/systemd/system/graphical.target
systemctl set-default multi-user.target # change default target multi-user target, switching run level 5 to 3

#Creating softlink
ln -s originalfile.txt soft_linkName
#Creating Hard Link
ln originalfile.txt hard_linkName

#Identify file type
file /home/michael/myfile

#check file type ( Directory : d , Regular file - , Charachter c, Link l , Socket File - s , Pipe -p , Block Device - b
ls -ld /home/filename
# drwxr - d , denotes directory 
df -hP # print all mounted file systems 

echo 'caleston123' | sudo -S ls /root #How to parse the root user password 
pwd=caleston
echo $pwd | sudo -S apt install firefox -y
sudo visudo #Giving root user access
your_username ALL=(ALL) NOPASSWD: /bin/ls #Define this entry

#---------------------Package Management---------------------------------#
echo password="myPass"
echo $password | sudo -S apt remove firefox -y

#--rpm and yum package manager--# fro RHEL systems , RHEL, Fedora, CentOS

#The extension of packgages is .rpm 
# rpm is the base package manager for redhat

/var/lib/rpm # rpm database stores all packages installed in system

rpm -ivh telnet.rpm # -i option to install a package
rpm -e telnet.rpm # Uninstall a certain package
rpm -Uvh telnet.rpm # Upgrade package
rpm -q telnet.rpm # query a certain rpm package
rpm -Vf <path to file> # Verify a certian package

#--yum package manager --#

/etc/yum.repos.d # information of reposiroties stored here, extension is .repo
/etc/yum.repos.d/redhat.repo
/etc/yum.repos.d/nginx.repo
#YUM ins the highlevel front end package manager of rpm

yum install httpd # install package
yum repolist #show all the repos added to the system
yum provides scp # check which package should be installed for a specific application/command to work
yum remove httpd # remove a package , this proceeeds to the uninstallation of the package as well
yum update telnet # update a certain package
yum update # update system

#---- dpkg and apt, apt-get package manager # This is for Debian , Ubuntu, LinuxMint and TrueOS

#package extension is .deb

dpkg -i telnet.deb # install a package
dpkg -r telnet.deb # Uninstall a certain package
dpkg -l telnet # list the packages installed in the system with the package name , version and short description
dpkg -s telnet # check the status of package whether installed in system
dpkg -p <path to file> # display details of certain package

# apt package manager:

#Fact : Higher Level Package Managers are APT and APT-GET . Although they sound similar , both package managers do not depend on each other.
# apt-get is less user friendly
# front-end package manager for Debian distros , under the hood it leverage dpkg
/etc/apt/sources.list # this is where repositories are stored

apt update	# updates repository , download package information from all sources. This is recommended to run after OS installation
apt upgrade	# used to install all available upgrades for all packages currently installed on the system using the sources configured 
apt edit-sources	# Edit /update repositories , This command opens /etc/apt/sources.list using vi or nano text editors , Another way is update the above file directly from txt editor
apt install telnet # To install a certain package
apt remove # To remove a certain package, following that this will give you prompt unistall the application/package
apt search telnet # Can be used to look for a package in the repository configured
apt list | grep telnet # list all the available packages or filter certain package

  
#---------------------Working with Shell II------------------------------#

#-- View file size--
du -sk test.img # print the size of file
du -sh test.img # print the size of the file in human readable format
ls -lh test.img # print long list, print the size of the of using -h option

#--Archive Files [Tar]--

# Note : .tar is the file extension , it just consolidate all files into a single file for backup or migration purpose
tar -cf myTarFile.tar file1 file2 file3 # -c option to create an archive, -f option to specify the tar file name
ls -ltr test.tar # view tar files -r riverse order , -t sort by time
tar -tf test.tar # used to see the content of tar ball
tar -xf # used to extract the content of the tar ball
tar -zcf # -z option is to compress the tar ball to reduce the size, filter the archive through gzip (--gzip , --gunzip, --ungzip)
tar -zvxf myfile.tar.gz # decompress and extract the file, -v for verbose mode



#--Compress/Decompress Files--

# Note : 3 tools , lets see how we compress and decompress file using each tools 

bzip2 test.img  # compress using bzip utility , the result is test.img.bz2
bunzip2 test.img.bz2 # decompress file which has been compressed via bzip2
bzcat test.img.gx # view the content of gzip file without decompress

gzip test.img # compress files using gzip utility , the result is test.img.gz
gunzip test.img.gz # decompress file which has been compressed via gzip
zcat test.img.bz2 # view the content of bzip2 compressed file without decompress 

xz test.img # compress files using xz , the result is test.img.xz
unxz test.img.xz # decompress file which has been decompress via xz
xzcat test.img.xz # view the content of xz file without decompress

#Lab examples
tar -zvcf /home/bob/python.tar.gz /home/bob/reptile/snake/python/
gunzip /home/bob/birds/eagle/eaglet.dat.gz /home/bob/birds/eagle/

# Decompress files to a directory
sudo tar -C /opt/ -xvf caleston-code.tar.gz

#-- Find/Search files --

locate city.txt # returns all the paths matching file based on a database called mlocate.db , to update db
updatedb # to update db file 
find /home/michael -name city.txt # find a certain file inside specified directory

#-- GREP --
grep myKeyword sample.txt #search and show lines has exact "myKeyword" matching
grep -i myKeyword sample.txt # search for keyword "myKeyword" , but ignore case
grep -r "thrid line" /home/michael # can be used to Search for a pattern recursively in a directory. Useful if you dont know which file contains the specific pattern
grep -v myKeyword sample.txt # shows lines that doesnt match the keyword/pattern
grep -w exam example.txt # Use this option to mwatch the whole word , out of exam and example , it returns the line which has exact word 'exam'
grep -w & -v myKeyword sample.txt # inverse of above
grep -A , -B # can be used to print lines after or before matching exact pattern
grep -A 5 myKeyword sample.txt # 5 lines after the match keyword
grep -B 5 myKeyword sample.txt # 5 lines before the match keyword
grep -A5 -B5 myKeyword sample.txt # 5 lines before and after matching keyword/pattern
grep -c "pattern" file.txt # count the lines that match the pattern
grep -e "pattern1" -e "pattern2" file.txt # print lines that match multiple patterns

#-- IO Redirection--

# Note : There are 3 standard data streams , STDOUT, STDIN, STDERR

echo $SHELL > shell.txt # save the STDOUT to a file , a file is created on the name specified or overidden
echo $SHELL >> shell.txt # append the STDOUT to a file

cat missing_file 2> error.txt # 2> denotes STDERR and save the STDERR into a file
cat missing_file 2>> error.txt # append the STDERR , however above and these prints the STDERR
cat missing_file 2> /dev/null # dump the STD error to bitbucket , a place where all the unwanted things go . This wont print STDERR

#-- Pipes --
grep Hello samples.txt | less # get the stdout of one command as stdin of next command. Can have multiple Pipes
echo $SHELL | tee shell.txt # Instead of using redirect operator (>) , you can use tee command followed by the file name where the output should have saved. 
echo $SHELL | tee -a shell.txt # -a option used to append

#-- Vi Editor
vi ~/.vimrc #Edit file , following configuration are necessary for YAML and kubernetes

set smarttab
set expandtab
set shiftwidth=2
set tabstop=2
set number

echo 'alias ll="ls -l"' >> ~/.profile
echo 'alias k='kubectl'' >> ~/.profile
alias c='clear'
alias l='ls -lrt'
alias kga='k get pod --all-namespaces' # https://www.ibm.com/blog/8-kubernetes-tips-and-tricks/

#Note : In most distros today , vi is a symbolic link to vim ridtor
which vi /usr/bin/vi #check where vi is referred to
ls -ltr /usr/bin/vi # check where vi points to 
ls -ltr /etc/alternatives/vi # check where vim is pointed after above command 
# To see the differences between vi and vim , use man pages or check withing them 
vim testfile #Then in command mode do following
:h vi-differences

update-alternatives --display editor # check what is the default editor of the system



#---------------------Networking-----------------------------------------#

#-- DNS --#
/etc/hosts #host file entries like:
192.168.1.115	testvm

/etc/resolv.conf # this is where DNS configuration is 
nameserver	192.168.1.1  #Adding DNS Server
search		mycompany.com # Search domain, so if you ping 'web' it will actually pint web.mycompany.com (Append the domain name )

/etc/nsswitch.conf #this file conifigure the precendce of name resolutions , from left to right
hosts:	files dns # priority hostfile first , then dns 

# Following are lookup tools
nslookup www.google.com
dig www.google.com

#-- Networking --#

ip link # to see and modify the interfaces of hosts
sudo ip link set dev eth0 up # bring a certain interface up
ip addr # check the ip cofniguration
ip addr add 192.168.1.10/24 dev eth0 # assign IPv4 address
# Note : Changes made using this command only valid until a system restart , if you want to persist these you must configure /etc/network/interfaces file.
route # see the routing table
ip route # see the routing table
ip route add 192.168.2.0 via 192.168.1.1 # add a route to a destination
ip route add default via 192.168.2.1 # add a default gateway (send packages to all other networks via routers ip towards our end )
ip route add 0.0.0.0 via 192.168.2.1 # instead of default work you can add 0.0.0.0 to denote any IP ( serves the same purpose )

# Note : if you see a routing entry like  192.168.2.0  0.0.0.0 255.255.255.0 #it means you dont need a default gateway to reach 192.168.2.0 network , becayse you are in this network.

# check interface - up
# check name resolution , perform the correct name resolution
# perform a ping test
# perform a traceroute 
traceroute 192.168.2.5
netstat -an | grep 80 | grep -i LISTEN # check if a certain port is actively listening

#--------------------- Security and File Permissions --------------------#

#-- Linux Accounts --#

# types of accounts : supreuser=0 , systemaccount UID<100 OR 500<UID<1000 ex: sshd, mailuser , Service Accounts - for services nginx, 

grep -i 'username/userid' /etc/passwd  # get the userid , group id (gid), homedirectory and shell information of the user
/etc/group #File where you have group information stored
id user_name # gives information about a certain user
who # check whos logged into currently to the system
last # shows record of all logged in users, shows date and time when the system is rebooted

su - # switched to any other user in the system , including root
su -c "whoami" #run a specific command as a different user. this is not recommend way to issue commands in root levels 
sudo apt update # this is the recommended way
/etc/sudores # this is where the sudo configuration is stored
visduo # edit sudoers file using this

#---/etc/sudoers file --#
%admin ALL=(ALL) ALL #members of admin gets root privileges
bob ALL=(ALL:ALL) ALL # allow bob root access
sarah localhost=/usr/bin/shutdown -r now # allow sarah to reboot the system

/etc/passwd	#This file stores user information does not save any passwords
/etc/shadow	# passwords are stored in this file content is hased
/etc/group	# stores all information about groups

useradd bob # create a user called bob
passwd bob # set the password for bob
whoami # shows the currently logged in you , Iam 
passwd # change the password by myself

useradd -u 1009 -g 1009 -d /home/student -s /bin/bash -c "Mercury Project Number" bob
# -c : Custom comments , -d custom home directory , -e expiary date , -g specific groupID , -s specific login shell , -u specific UID
userdel bob	# used to delete a user account from the system. In this case, it's deleting the user named "bob"
groupadd -g 1011 developer #create a new group on the system. The -g option specifies the group ID (GID) for the new group. Here, it's creating a group named "developer" with a GID of 1011.
groupdel developer	# deletes a group from the system. In this example, it's deleting the group named "developer

sudo usermod -aG sudo username  # modify the user and add the user to group sudo to give root access
groupmod -g 6000 ateam 

#lab :


#-- File Permissions--#

ls -l myfile.sh # check the permissions of file or directory 
# - regular file , d directory , l link, b blockdevice , s socketfile , 1-N number of hard links , 
# u	owner	permissions for the owner of the file
# g	group	permissions for the group owning the file
# o	others	permissions for all other users
# + add permission , - remove permission

chmod u+rwx,g+r-x,o-rwx #Full access for owners , add read , remove execute for groups and no access for others
chmod u+rwx #provides full access to user
chmod ugo+r-x # Provde read access to owner , group and others , Remove execute access. 
chmod o-rwx # Remove all access for others

# 4-Read , 2-Write , 1-Execute , 0 no permissions

chmod 777 file1 # provide full access to ALL
chmod 555 testfile # provide Read and execute access to Owners groups and others
chmod 660 testfile # provide Read,Write access to owner and group and no access to others
chmod 750 testfile # provide Full access to owner, read and execute access to group , no access to others

chown bob:develeper testfile # changes owner to bob and group to developer
sudo chown -vR mercury sports/ # change the owner of directory and its files to mercury
chown bob android.apk # changes just the owner of the file to bob, Group is unchanged 
chgrp android testfile # change the group for the test-file to the group called android

#--------------------SSH and SCP------------------------------------#
ssh <hostname/ipaddress>
ssh <username>@<hostname/ipaddress> # if user not specified, it will use the current user
ssh -l <username> <hostname/ipaddress> #same can be achieved as above

# Note : requires a valid username and password or SSH Key

# 1. Generate a Key-Pair, client will only one who keeps the private key. Public key can be shared with remote servers
ssh-keygen -t rsa
# public key stored at /home/bob/.ssh/id_rsa.pub
# private key stored at /home/bob/.ssh/id_rsa
# Copy the public key to the remote server
ssh-copy-id username@remoteServer
# This public key now stored in remote server under /home/bob/.ssh/authorized_keys directory

scp /home/bob/caleston-code.tar.gx devapp01:/home/bob # copy the caleston-code.tar.gz to remote host of devapp01
scp /home/bob/caleston-code.tar.gx devapp01:/root
scp -pr /home/bob/media devapp01:/home/bob # -r option to copy directories , -p option for preserve the ownership information

ssh user@hostname 'remoteCommand' #remote command invokation via ssh
ssh devdb01 ' echo 'caleston123' | sudo -S apt install iptables -y' # invoking sudo commands on remote host

#----- Network Security in Linux--#
# Installing iptables
sudo apt install iptables
sudo iptables -L # list the default rules configured in the system
sudo iptables -L -v -n # -v verbos , -n shows numerical addresses instead of resolving hostnames

iptables -A INPUT -p tcp -s 172.16.238.187 --dport 22 -j ACCEPT #open ssh traffic from 172.16.238.187
# -A add or append rule , -p protocol , -s Source , -d destination , --dport Destination port , -j Action to take 
iptables -A INPUT -p tcp --dport 22 -j DROP # drop all other ssh traffic

sudo iptables -I INPUT 3 -p protocol --dport port_number -j ACTION # put the input rule at no3 place of policy chain , otherwise it will be at the top unless specified
iptables -I OUTPUT -p tcp -d 172.168.238.100 --dport 443 -j ACCEPT # put the rule of Accepting HTTPS OUTBOUND traffic towards 172.168.238.100 on top 
iptables -D OUTPUT 5 # Delete output rule at position 5

# Rules are applied from top to bottom
# new rules are added at bottom, if you want to add at top use -I option
# Returning traffic via Ephemeral ports does not require inbound allow rules , because by default the policy accepts from traffic from anywhere

ssh-copy-id bob@devdb01
ssh-copy-id bob@devapp01 
ssh devdb01 ' echo 'caleston123' | sudo -S apt install iptables -y'
ssh devapp01 ' echo 'caleston123' | sudo -S apt install iptables -y'

ssh devapp01 ' echo 'caleston123' | sudo -S iptables -L'
ssh devdb01 ' echo 'caleston123' | sudo -S iptables -L'

iptables -A INPUT -p tcp -s 172.16.238.187 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s 172.16.238.187 --dport 80 -j ACCEPT

ssh devapp01 ' echo 'caleston123' | sudo -S iptables -A INPUT -p tcp -s 172.16.238.187 --dport 22 -j ACCEPT '
ssh devapp01 ' echo 'caleston123' | sudo -S iptables -A INPUT -p tcp -s 172.16.238.187 --dport 80 -j ACCEPT '

ssh devapp01 ' echo 'caleston123' | sudo -S iptables -D INPUT 3'
ssh devapp01 ' echo 'caleston123' | sudo -S iptables -A INPUT -j DROP'

iptables -A OUT -p tcp -d 172.16.238.11 --dport 5432 -j ACCEPT
iptables -A OUT -p tcp -d 172.16.238.15 --dport 80 -j ACCEPT

ssh devapp01 ' echo 'caleston123' | sudo -S iptables -A OUTPUT -p tcp -d 172.16.238.11 --dport 5432 -j ACCEPT'
ssh devapp01 ' echo 'caleston123' | sudo -S iptables -A OUTPUT -p tcp -d 172.16.238.15 --dport 80 -j ACCEPT'
ssh devapp01 ' echo 'caleston123' | sudo -S iptables -A OUTPUT -p tcp --dport 80 -j DROP'
ssh devapp01 ' echo 'caleston123' | sudo -S iptables -A OUTPUT -p tcp --dport 443 -j DROP'

ssh devapp01 ' echo 'caleston123' | sudo -S iptables -I OUTPUT -p tcp -d google.com --dport 443 -j ACCEPT'

# IP Tables rules saving permanently
#------ Debian-----#
#1 : Using iptables-persistent Package , automatically load iptables rules from files stored in /etc/iptables/ during system startup.
sudo apt-get install iptables-persistent
sudo netfilter-persistent save # During installation, it will ask if you want to save current iptables rules; you can choose yes. If you modify rules later and need to save them again, you can use:

# 2 : Manually saving and restoring: If you prefer not to use iptables-persistent, you can manually save your rules to a file and then restore them at boot time by editing the /etc/rc.local file or creating a custom systemd service.
sudo iptables-save > /etc/iptables/rules.v4 #To save rules:
#To restore them on boot, you could add the following line to /etc/rc.local before exit 0:
iptables-restore < /etc/iptables/rules.v4
# Note : Ensure /etc/rc.local is executable and enabled at boot.

#--- RHEL ------#
#1) Using the iptables-service package: This package allows you to save and reload iptables rules.
sudo service iptables save
#This command saves the current iptables configuration to /etc/sysconfig/iptables for IPv4 rules. For IPv6, use ip6tables-save and ip6tables-restore. The rules are automatically applied on system boot.
#2) Manually saving and restoring : you can manually save your iptables rules to a file and restore them at boot time, but you might use a custom systemd service or /etc/rc.d/rc.local for executing the restore command.

#--------------- Scheduling Jobs (Cron Jobs)---#
# Fact : crond is the service which takes care of cronjobs
# whatever you entered in the file : /var/spool/cron/crontabs/UserName will run as a scheduled task as the user
# Lets say if we want to schedule following command and get the output to a certain log file
uptime >> /tmp/system-report.txt
# this should run everyday at 9 PM
# Sunday -0 .... Friday - 6
crontab -l #list all cronjobs
crontab -e # this opens the file using default editor , example vim . 
# m	h  dom  mon  dow  command
  0 21 *    *    *    uptime >> /tmp/system-report.txt # every day 9 PM run this command
  10 8 19   2    1    command  # run command on Monday February 19th at 08:10 AM
  10 8 19   *    *    command  # run command on Anyweekday every month 19th at 08:10 AM
  10 8 *    *    *    command  # run command on Anyweekday everymonth everyday at 08:10 AM
  *  *  *   *    *    command  # run command on everyminute
 */2 *  *   *    *    command  # run this command every 2 minutes
 59 23  *   *    0    command  # run this command every Sunday 11:59 PM ( Ideal for a backup job )

# --- Service Management with SystemD --#

# A systemd service is a unit managed by the `systemd` init system on Linux, used to define how services (daemon processes) should start, stop, and be managed on the system. Services are described by `.service` files, which can specify details such as the executable path, arguments, dependencies, and environment settings. 
# `systemd` enables efficient management of service states, supports automatic restarting of failed services, and allows for complex dependency management to ensure services start in the correct order.

# systemd services unit files are located at 
/etc/systemd/system/
# if you want to create a service , need to create a unit file named serviceName.service
/etc/systemd/system/serviceName.service
# Basic syntax---------
[Unit]
Description=Python Django for Project Mercury # Description
Documentation=http://wiki.caleston-dec.ca.reported # Any documentation
After=postgresql.service # Define dependent service to start before the required application services

[Service]
ExecStart=/usr/bin.project-mercurty.sh
WorkingDirectory=/opt/ #defines the working directory
User=project_mercurty #Add the service account that use to run the service , user=project_mercury (Define the user who runs it )
Restart=on-failure # acceptable values : Always , on-failure : Restart on Failure
RestartSec=10 # Restart after a certain time, Set the time in seconds to wait before the system attempts to restart it

[Install]
WantedBy graphical.target #Allow the service to run after boot by specifying the systemd target or the run level you want to enable it there

#---------------------#
systemctl daemon-reload # Running this command after editing a service unit file reload the system manager configurations and make systemd aware of the changes.
systemctl start project-mercury.service # start the relevant service

# SYSTEMD Tools - systemctl , journalctl

systemctl start docker # start service
systemctl stop service # stop running service
systemctl restart service # bring down service and bring it back up
systemctl enable service # make service persistent across boots/reboots
systemctl disable service # disable service at boots/reboots
systemctl status service # provide information about service

systemctl edit project-mercury.service --full #edit unit files using following command. This will apply changes to the modified service.
#Units edited this way apply the changes immediately. Without having to run daemon-reload.

systemctl get default	#Get the current run level
systemctl set-default multi-user.target	#Change the running target
systemctl list-units --all	#Lists all units systemd has /had loaded or attempted to load. This prints all units in ACTIVE, INACTIVE, DEAD, FAILED, TRANSIENT states
systemctl list-units #This only gives information on active units

journalctl	#prints all the log entries to the newest version
journalctl -b	#See the log information from the current boot
journalctl -u UNIT	#See the log entries for a specific unit
journalctl -u docker.service

ps -p 1 # check the init process pid=1 



#--------------------- Storage in Linux -------------------------------#
