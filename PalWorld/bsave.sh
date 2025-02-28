#!/bin/bash

# Backup directory path
SAVE_DIR="/home/steam/Steam/steamapps/common/PalServer/Pal/Saved/SaveGames/0/EB2388BBFB5D405CB1BF8194DAF256AD"
#0/EB2388BBFB5D405CB1BF8194DAF256AD 需要根据实际存档参数修改

BACKUP_DIR="/home/steam/Steam/steamapps/common/PalServer/shfiles/backupfiles"

LOG_FILE="/home/steam/Steam/steamapps/common/PalServer/shfiles/logs/back.log"

CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')
BACKUP_FILE=$(date '+%Y-%m-%d_%H:%M:%S').tar.gz

# Backup files
cd $SAVE_DIR && mkdir -p $BACKUP_DIR && tar -czvf $BACKUP_DIR/$BACKUP_FILE ./Level.sav ./LevelMeta.sav ./Players/*
echo "$CURRENT_TIME: Created backup file $BACKUP_FILE" >> $LOG_FILE

# Delete backups older than 3 days and log the action
find "$BACKUP_DIR" -type f -mtime +1 -exec rm {} \; -exec echo "$CURRENT_TIME: Deleted backup file {}" >> $LOG_FILE \;
