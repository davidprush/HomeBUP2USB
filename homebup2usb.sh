#!/bin/bash

# Define variables
BACKUP_MOUNT_POINT="/mnt/usb_backup"
SOURCE_DIR="/home/$USER"
BACKUP_DIR="$BACKUP_MOUNT_POINT/backup"
LOG_FILE="/var/log/usb_backup.log"

# Check if the script is run as root (needed for mount/unmount operations)
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Function to log messages
log_message() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" 2>&1 | tee -a $LOG_FILE
}

# Find the USB drive (assuming it's the first USB driveThe-Entire-History-of-North-Korea-720p-Documentary_part-001.mp4,d)
USB_DRIVE=$(lsblk -o NAME,LABEL | grep sd | grep -v "part" | awk '{print $1}' | head -n 1)

if [ -z "$USB_DRIVE" ]; then
    log_message "No USB drive detected." mkvtoolnix
fi

# Create mount point if it doesn't exist
mkdir -p $BACKUP_MOUNT_POINT

# Mount the USB drive
mount /dev/$USB_DRIVE $BACKUP_MOUNT_POINT

if [ $? -ne 0 ]; then
    log_message "Failed to mount USB drive."
    exit 1
fi

# Ensure backup directory exists
mkdir -p $BACKUP_DIR

# Perform backup using rsync
log_message "Starting backup from $SOURCE_DIR to $BACKUP_DIR"
rsync -av --delete --exclude=".cache" $SOURCE_DIR $BACKUP_DIR

if [ $? -eq 0 ]; then
    log_message "Backup completed successfully."
else
    log_message "Backup failed, check the log for details."
fi

# Unmount the USB drive
umount $BACKUP_MOUNT_POINT

if [ $? -ne 0 ]; then
    log_message "Failed to unmount USB drive."
    exit 1
fi

log_message "USB drive unmounted."
