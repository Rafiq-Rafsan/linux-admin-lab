# Linux Backup Automation

## Overview

A Bash script for creating timestamped, gzip-compressed backups on Rocky Linux.

## Features

* Creates timestamped `.tar.gz` archives.
* Logs backup success and failure messages.
* Verifies that the generated archive can be read.
* Removes an archive if creation or verification fails.
* Supports manual restoration with `tar`.

## Project Structure

```text
backup-lab/
├── backup.sh
├── README.md
├── source/
├── backups/
└── logs/
```

## Technologies

* Rocky Linux
* Bash
* tar and gzip
* Git and GitHub

## How to Run

```bash
cd ~/backup-lab
bash -n backup.sh
chmod +x backup.sh
./backup.sh
```

## Restore a Backup

Create a restore directory and extract an archive:

```bash
mkdir -p restore
tar -xzf backups/backup_FILENAME.tar.gz -C restore/
```

Replace `backup_FILENAME.tar.gz` with the actual backup filename.

## Verification

Check the archive contents:

```bash
tar -tzf backups/backup_FILENAME.tar.gz
```

Compare a restored file with the original:

```bash
diff -s source/test.txt restore/test.txt
```

## Learning Outcomes

Practiced Bash scripting, timestamped backups, gzip compression, logging, archive verification, error handling, and file restoration on Rocky Linux.

