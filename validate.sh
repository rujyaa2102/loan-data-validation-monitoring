#!/bin/bash

# Loan Data Validation Script

DIR=~/loan-project
TODAY=$(date +%F)

REPORT="$DIR/report_$TODAY.txt"
LOG="$DIR/app.log"

echo "Loan Validation Report - $TODAY" > "$REPORT"

check() {
    NAME="$1"
    QUERY="$2"

    RESULT=$(mysql -N -e "$QUERY" loan_db)
    if [ $? -ne 0 ]; then
        echo "$(date '+%F %T') ERROR $NAME - query could not run" >> "$LOG"
        exit 1
    fi


    if [ -n "$RESULT" ]; then

        echo "$(date '+%F %T') ERROR $NAME" >> "$LOG"

        echo "--- $NAME ---" >> "$REPORT"

        echo "$RESULT" >> "$REPORT"

    else

        echo "$(date '+%F %T') INFO $NAME ok" >> "$LOG"

    fi
}

check "Duplicate loan_id" "SELECT loan_id, COUNT(*) FROM loans GROUP BY loan_id HAVING COUNT(*) > 1"

check "Missing customer name" "SELECT * FROM loans WHERE customer_name IS NULL OR customer_name = ''"

check "Invalid amount" "SELECT * FROM loans WHERE amount <= 0"
