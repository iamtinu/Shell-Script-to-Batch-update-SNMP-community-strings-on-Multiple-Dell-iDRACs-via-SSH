# Shell-Script-to-Batch-update-SNMP-community-strings-on-Multiple-Dell-iDRACs-via-SSH
A bulk update tool that updates the SNMP Agent Community string across multiple Dell iDRAC servers by executing racadm commands directly over SSH

Prerequisites
You need sshpass to automate the password entry. Use below commands to install

Ubuntu - 
apt update
apt install sshpass

Uncomment the line below in script to debug failures (it will show you why it failed)
# sshpass -p "$PASS" ssh $SSH_OPTS "$USER@$IP" "racadm set iDRAC.SNMP.AgentCommunity $NEW_COMMUNITY"

Optional: Ensure SNMP Agent is enabled (Uncomment if needed)
# sshpass -p "$PASS" ssh $SSH_OPTS "$USER@$IP" "racadm set iDRAC.SNMP.AgentEnable 1" > /dev/null 2>&1