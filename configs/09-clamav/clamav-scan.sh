#!/bin/bash
# /usr/local/bin/clamav-scan.sh
# Reconstructed from the lab report screenshots (Figure 9.9.2).
# Complete as shown. Needs chmod +x. Run daily by cron (see crontab).
# Known bug kept as in the screenshot: the date format reads "%Y-m-%d", so the log header
# prints a literal "m" in place of the month (the log in Figure 9.9.6 shows "2026-m-06").
# It should be "%Y-%m-%d".
SCAN_DIRS="/home /var/www"
LOG_FILE="/var/log/clamav/daily-scan.log"
SCAN_DATE=$(date +"%Y-m-%d %H:%M:%S")
echo "=== Scan Started at $SCAN_DATE ===" >> "$LOG_FILE"
clamscan -r -i --log="$LOG_FILE" $SCAN_DIRS
echo "=== Scan Completed ===" >> "$LOG_FILE"
