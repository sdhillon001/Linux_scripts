#!/bin/bash

# Define backup destination directory
backup_dir="/mnt/500GB_HD/backups"
datestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Create backup directory if it doesn't exist
mkdir -p "$backup_dir"

# Get the latest backup directory
latest_backup=$(ls -dtr "$backup_dir"/* | tail -n 1)

# Incremental Backup /home directory
rsync -av --delete --backup --backup-dir="$backup_dir/home_backup_$datestamp" /home/ "$backup_dir/incremental_home_backup"

# Check if /home backup was successful
if [ $? -eq 0 ]; then
    echo "Home directory backup completed successfully on $datestamp." >> "$backup_dir/backup_log.txt"
else
    echo "Error: Home directory backup failed on $datestamp." >> "$backup_dir/backup_log.txt"
fi

# Incremental Backup /etc directory
rsync -av --delete --backup --backup-dir="$backup_dir/etc_backup_$datestamp" /etc/ "$backup_dir/incremental_etc_backup"

# Check if /etc backup was successful
if [ $? -eq 0 ]; then
    echo "Etc directory backup completed successfully on $datestamp." >> "$backup_dir/backup_log.txt"
else
    echo "Error: Etc directory backup failed on $datestamp." >> "$backup_dir/backup_log.txt"
fi
