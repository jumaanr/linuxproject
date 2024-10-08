#!/bin/bash

cat inventory
ansible test -i inventory --list-hosts
ansible ungrouped --list-hosts # list down the ungrouped hosts in ansible which is mentioned at the toppin
#How to define ungrouped hosts
#How to tell Ansible to refer the inventory file in project folder : look at the ansible.cfg file at the project directory

#Configure ~/.vimrc
set ai
set tabstop=2
set expandtab
set cursorcoloumn
# This needs to be configured to the easeuse of YAML
ansible-doc -l # get the documentation
ansible-doc user # check the documentation for user module
ansible-playbook user.yaml # run the playbook called user.yaml
ansible-playbook --syntax-check --dry-run

## ---- Ansible Navigator ---##
# If you work on a workstation and if you do any changes, that would affect you ansible 
# I.E : Changing python version
# Ansible Navigator is a container runtime that you could keep ansible workstation environment consistent
# In the industry , usually there is a dedicated server for Ansible automation
cat ~/.ansible-navigator.yml

