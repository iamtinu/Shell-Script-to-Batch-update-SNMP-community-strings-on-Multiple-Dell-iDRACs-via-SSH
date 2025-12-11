#!/bin/bash

# --- CONFIGURATION ---
USER="root"
PASS="calvin"                # Your iDRAC password
NEW_COMMUNITY="public"
# ---------------------

SERVERS=(
    "10.202.1.1"
    "10.202.1.2"
    "10.202.1.3"
    "10.202.1.4"
    "10.202.1.5"
    "10.202.1.6"
    "10.202.1.7"
    "10.202.1.8"
    "10.202.1.9"
    "10.202.1.10"
    "10.202.1.11"
    "10.202.1.12"
    "10.202.1.13"
    "10.202.1.14"
    "10.202.1.15"
)

# SSH Options to avoid "StrictHostKeyChecking" prompts and handle older iDRAC ciphers if needed
SSH_OPTS="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR"

for IP in "${SERVERS[@]}"; do
    echo -n "Processing $IP... "

    # 1. Set the Community String
    # We use sshpass to inject the password. The command is passed as an argument to ssh.
    sshpass -p "$PASS" ssh $SSH_OPTS "$USER@$IP" "racadm set iDRAC.SNMP.AgentCommunity $NEW_COMMUNITY" > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        echo "[OK]"
    else
        echo "[FAILED]"
        # Uncomment the line below to debug failures (it will show you why it failed)
        # sshpass -p "$PASS" ssh $SSH_OPTS "$USER@$IP" "racadm set iDRAC.SNMP.AgentCommunity $NEW_COMMUNITY"
    fi

    # 2. Optional: Ensure SNMP Agent is enabled (Uncomment if needed)
    # sshpass -p "$PASS" ssh $SSH_OPTS "$USER@$IP" "racadm set iDRAC.SNMP.AgentEnable 1" > /dev/null 2>&1
done