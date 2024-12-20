# HomeBUP2USB
A script to backup home directory to USB
Explanation:
Variables: 
BACKUP_MOUNT_POINT is where the USB will be mounted.
SOURCE_DIR is the user's home directory (or change to any specific directory you want to backup).
BACKUP_DIR is where the backup will be stored on the USB.
LOG_FILE for logging operations.
Permissions: The script checks if it's run with root privileges because mounting requires superuser rights.
USB Detection: It attempts to find the first USB drive using lsblk. You might need to adjust this if your setup differs.
Mounting: If a USB drive is found, it mounts it to the predefined mount point.
Backup: Uses rsync with options:
-a for archive mode (preserves permissions, timestamps, etc.)
-v for verbose output
--delete to remove files from the backup that no longer exist in the source
--exclude to skip caching directories or other unnecessary data
Log: Each major step logs its status for tracking or troubleshooting.
Unmounting: After backup, the USB is unmounted.

Note:
Make sure to give this script executable permissions with chmod +x script_name.sh.
This script assumes the USB drive is accessible by root and writable. You might need to adjust udev rules or use a specific user/group for USB access if not.
Test this script in a controlled environment first to ensure it behaves as expected with your system setup.
