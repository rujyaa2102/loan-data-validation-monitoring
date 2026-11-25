#!/bin/bash

TODAY=$(date +%F)

REPORT=~/loan-project/report_$TODAY.txt
LOG=~/loan-project/app.log

if sftp -b - localhost <<SFTP
cd sftp-server/outgoing
put $REPORT
SFTP
then
    echo "$(date '+%F %T') INFO Report sent via SFTP" >> "$LOG"
else
    echo "$(date '+%F %T') ERROR SFTP upload failed" >> "$LOG"
fi
