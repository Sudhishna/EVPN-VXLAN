#!/bin/bash
# Remove all the configs
# Comannd example ./Remove-Fabric.sh
# Date written 2018 February 12

printf  "Removing configuration begins.\r"

ansible-playbook -i 01-Interfaces/all.inv 01-Interfaces/remove-config.yml --extra-vars "pod=pod1"
sleep 5 

printf "\n\nThe configurations were successfully removed.\n"
