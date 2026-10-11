
#!/bin/bash

set -o pipefail

# Backup configuration
SOURCE="$HOME/backup-lab/source"
BACKUP_DIR="$HOME/backup-lab/backups"
LOG_DIR="$HOME/backup-lab/logs"

# Create required directories
if ! mkdir -p "$BACKUP_DIR" "$LOG_DIR"; then
    echo "ERROR: Cannot create backup or log directories" >&2
    exit 1
fi

LOG_FILE="$LOG_DIR/backup.log"

# Logging function
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S'): $1" | tee -a "$LOG_FILE"
}

# Check source directory
if [ ! -d "$SOURCE" ]; then
    log_message "ERROR - Source directory not found: $SOURCE"
    exit 1
fi

# Generate timestamped backup filename
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"

# Create compressed backup
if tar -czf "$BACKUP_FILE" -C "$SOURCE" .; then

    # Verify the archive can be read
    if tar -tzf "$BACKUP_FILE" > /dev/null; then
        log_message "SUCCESS - Backup verified: $BACKUP_FILE"
    else
        log_message "ERROR - Backup verification failed: $BACKUP_FILE"
        rm -f -- "$BACKUP_FILE"
        exit 1
    fi

else
    log_message "ERROR - Backup creation failed: $BACKUP_FILE"
    rm -f -- "$BACKUP_FILE"
    exit 1
fi
