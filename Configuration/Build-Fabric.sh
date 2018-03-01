#!/bin/bash
# Fabric deployment for OSPF Underlay and EVPN/VXLAN Overlay
# Comannd example ./Build-Fabric.sh
# Date written 2018 February 12

printf  "Fabric initialization begins.\r"

ansible-playbook -i 01-Interfaces/all.inv 01-Interfaces/config-interfaces.yml --extra-vars "pod=pod1"
printf  "Interfaces Configured.\r"
sleep 3

ansible-playbook -i 02-Scale-Options/all.inv 02-Scale-Options/config-scaleoptions.yml --extra-vars "pod=pod1"
printf  "Scale Options Configured.\r"
sleep 3

ansible-playbook -i 03-Routing-iBGP/all.inv 03-Routing-iBGP/config-routing.yml --extra-vars "pod=pod1"
printf  "Routing options set.\r"
sleep 3

ansible-playbook -i 04-Underlay-OSPF/all.inv 04-Underlay-OSPF/config-underlay.yml --extra-vars "pod=pod1"
printf  "OSPF Routing Protocol installed and iBGP configured.\r"
sleep 3

ansible-playbook -i 05-Overlay/all.inv 05-Overlay/config-overlay.yml --extra-vars "pod=pod1"
printf  "Overlay deployed.\r"
sleep 3

secs=$((1 * 60))
while [ $secs -gt 0 ]; do
   echo -ne "Countdown to Fabric Availability: "
   echo -ne "$secs\033[0K\r"
   sleep 1
   : $((secs--))
done
sleep 3

printf "\n\nThe Fabric is ready.\n"
