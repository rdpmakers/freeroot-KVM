#!/bin/sh
LOG_FILE="/opt/KVM.log"

while true; do
  # Use grep to search for the pattern in the log file
  LOGIN_DETECT=$(grep -o 'login:' "$LOG_FILE" | tail -n 1)
  
  if [ -n "$LOGIN_DETECT" ]; then
    echo "Safe to Remote Shell"
    break
  fi
  
  # Optional: Add a small delay to avoid excessive CPU usage
  sleep 1
done
sshpass -p "asdfqwer" ssh -o StrictHostKeyChecking=no -p2222 ubuntu@localhost
