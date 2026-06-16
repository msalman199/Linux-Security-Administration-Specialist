# 💾 System Backup and Restoration

<div align="center">

# 🚀 Linux Backup & Disaster Recovery 

![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge&logo=ubuntu)
![Rsync](https://img.shields.io/badge/rsync-Backup-blue?style=for-the-badge)
![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?style=for-the-badge&logo=gnubash)
![Cron](https://img.shields.io/badge/Cron-Automation-orange?style=for-the-badge)
![Backup](https://img.shields.io/badge/Data-Protection-success?style=for-the-badge)
![Disaster Recovery](https://img.shields.io/badge/Disaster-Recovery-red?style=for-the-badge)

### 🔐 Learn Enterprise Backup Strategies, Automation, Verification & Disaster Recovery

</div>

---

# 📖 Overview

System backups are one of the most critical responsibilities of Linux administrators. A reliable backup and restoration strategy protects systems from accidental deletion, hardware failures, ransomware incidents, and data corruption.

In this lab, you will learn how to:

✅ Use rsync for efficient backups

✅ Create incremental and full backups

✅ Automate backup operations using cron

✅ Restore files and directories from backups

✅ Verify backup integrity

✅ Build production-ready backup scripts

✅ Implement disaster recovery procedures

---

# 🎯 Objectives

By the end of this lab, students will be able to:

- 💾 Understand backup and restoration concepts
- 🔄 Use rsync effectively for backups
- ⏰ Automate backups using cron jobs
- 🛠️ Restore files and directories
- 🔍 Verify backup integrity
- 📊 Create backup monitoring solutions
- 🚨 Implement disaster recovery procedures
- ⚙️ Develop enterprise backup scripts

---

# 📚 Prerequisites

Before starting this lab, students should have:

- 🐧 Basic Linux command-line knowledge
- 📂 Understanding of file systems and permissions
- ✍️ Familiarity with text editors (Nano/Vim)
- 📜 Basic shell scripting knowledge
- ⏰ Understanding of cron scheduling

---

# ☁️ Lab Environment

## 🚀 Ready-to-Use Cloud Machines

Al Nafi provides Linux-based cloud machines for this lab.

Simply click:

**▶️ Start Lab**

to access your pre-configured environment.

No virtual machine setup is required.

### Environment Includes

| Component | Description |
|------------|-------------|
| OS | Ubuntu 20.04 / CentOS 8 |
| Backup Tool | rsync |
| Scheduler | Cron |
| Storage | Backup Workspace |
| Sample Data | Included |

---

# 🧩 Task 1 — Use rsync for System Backups

---

## 🔹 Subtask 1.1 Understanding rsync Basics

### Verify Installation

```bash
rsync --version
```

### Basic Syntax

```bash
rsync [options] source destination
```

### Why rsync?

✅ Fast

✅ Incremental

✅ Preserves permissions

✅ Supports compression

✅ Ideal for backups

---

## 🔹 Subtask 1.2 Create Sample Data

### Create Test Directory

```bash
mkdir -p /home/$USER/important_data

cd /home/$USER/important_data
```

### Create Sample Files

```bash
echo "This is document 1" > document1.txt

echo "This is document 2" > document2.txt

echo "Configuration data" > config.conf
```

### Create Subdirectory

```bash
mkdir subdirectory

echo "Nested file content" > subdirectory/nested_file.txt
```

### Create Large Test File

```bash
dd if=/dev/zero of=largefile.dat bs=1M count=10
```

### Configure Permissions

```bash
chmod 755 document1.txt

chmod 644 document2.txt

chmod 600 config.conf
```

### Verify Structure

```bash
ls -la

ls -la subdirectory/
```

---

## 🔹 Subtask 1.3 Perform Basic rsync Backup

### Create Backup Location

```bash
mkdir -p /home/$USER/backups
```

### Run Backup

```bash
rsync -av /home/$USER/important_data/ \
/home/$USER/backups/basic_backup/
```

### Verify Backup

```bash
ls -la /home/$USER/backups/basic_backup/
```

### Important Options

| Option | Purpose |
|----------|---------|
| -a | Archive Mode |
| -v | Verbose Output |

---

## 🔹 Subtask 1.4 Advanced rsync Options

### Advanced Backup

```bash
rsync -avz --progress --stats \
/home/$USER/important_data/ \
/home/$USER/backups/advanced_backup/
```

### Incremental Backup

```bash
rsync -av \
--link-dest=/home/$USER/backups/advanced_backup \
/home/$USER/important_data/ \
/home/$USER/backups/incremental_backup/
```

### Backup With Exclusions

```bash
rsync -av \
--exclude='*.tmp' \
--exclude='*.log' \
/home/$USER/important_data/ \
/home/$USER/backups/filtered_backup/
```

### Advanced Options

| Option | Description |
|----------|------------|
| -z | Compression |
| --progress | Progress Display |
| --stats | Transfer Statistics |
| --link-dest | Hard-link Incrementals |
| --exclude | Ignore Files |

---

## 🔹 Subtask 1.5 Create Comprehensive Backup Script

### Create Script

```bash
nano /home/$USER/system_backup.sh
```

### Backup Script

```bash
#!/bin/bash

BACKUP_SOURCE="/home/$USER"
BACKUP_DEST="/home/$USER/backups/system_backup"
LOG_FILE="/home/$USER/backups/backup.log"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p "$BACKUP_DEST"
mkdir -p "$(dirname "$LOG_FILE")"

log_message() {
 echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log_message "Starting system backup..."

rsync -av \
 --delete \
 --exclude='*.tmp' \
 --exclude='*.cache' \
 --exclude='.Trash*' \
 --exclude='Downloads/' \
 --stats \
 "$BACKUP_SOURCE/" \
 "$BACKUP_DEST/" 2>&1 | tee -a "$LOG_FILE"

if [ ${PIPESTATUS[0]} -eq 0 ]; then

 log_message "Backup completed successfully"

 BACKUP_SIZE=$(du -sh "$BACKUP_DEST" | cut -f1)

 log_message "Backup size: $BACKUP_SIZE"

 find "$BACKUP_DEST" -type f > \
 "$BACKUP_DEST/../backup_manifest_$DATE.txt"

else

 log_message "Backup failed"

 exit 1

fi

log_message "Backup process completed"
```

### Make Executable

```bash
chmod +x /home/$USER/system_backup.sh
```

### Run Script

```bash
./system_backup.sh
```

### View Log

```bash
cat /home/$USER/backups/backup.log
```

---

# 🧩 Task 2 — Automate Backups with Cron Jobs

---

## 🔹 Subtask 2.1 Understanding Cron Syntax

```text
* * * * * command
│ │ │ │ │
│ │ │ │ └── Day of Week
│ │ │ └──── Month
│ │ └────── Day of Month
│ └──────── Hour
└────────── Minute
```

---

## 🔹 Subtask 2.2 Create Automated Daily Backup

### Edit Crontab

```bash
crontab -e
```

### Schedule Daily Backup

```cron
0 2 * * * /home/$USER/system_backup.sh >> /home/$USER/backups/cron_backup.log 2>&1
```

---

## 🔹 Subtask 2.3 Create Weekly Backup Script

### Create Script

```bash
nano /home/$USER/weekly_backup.sh
```

### Weekly Backup

```bash
#!/bin/bash

BACKUP_SOURCE="/home/$USER"

BACKUP_DEST="/home/$USER/backups/weekly_backup_$(date +%Y%m%d)"

LOG_FILE="/home/$USER/backups/weekly_backup.log"

mkdir -p "$BACKUP_DEST"

echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting weekly backup" >> "$LOG_FILE"

rsync -av \
 --delete \
 --exclude='*.tmp' \
 --exclude='*.cache' \
 "$BACKUP_SOURCE/" \
 "$BACKUP_DEST/" >> "$LOG_FILE" 2>&1

tar -czf "$BACKUP_DEST.tar.gz" \
-C "$(dirname "$BACKUP_DEST")" \
"$(basename "$BACKUP_DEST")"

rm -rf "$BACKUP_DEST"

echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup completed" >> "$LOG_FILE"
```

### Make Executable

```bash
chmod +x /home/$USER/weekly_backup.sh
```

---

## 🔹 Subtask 2.4 Configure Multiple Cron Jobs

```cron
# Daily Backup
0 2 * * * /home/$USER/system_backup.sh

# Weekly Backup
0 3 * * 0 /home/$USER/weekly_backup.sh

# Monthly Backup
0 4 1 * * /home/$USER/system_backup.sh

# Verification
0 6 * * * /home/$USER/verify_backup.sh
```

---

## 🔹 Subtask 2.5 Create Backup Verification Script

### Create Script

```bash
nano /home/$USER/verify_backup.sh
```

### Verification Script

```bash
#!/bin/bash

BACKUP_DIR="/home/$USER/backups/system_backup"

LOG_FILE="/home/$USER/backups/verification.log"

log_message() {
 echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

log_message "Starting backup verification..."

if [ ! -d "$BACKUP_DIR" ]; then
 log_message "ERROR: Backup directory not found"
 exit 1
fi

BACKUP_FILE_COUNT=$(find "$BACKUP_DIR" -type f | wc -l)

BACKUP_SIZE=$(du -sh "$BACKUP_DIR" | cut -f1)

log_message "Files: $BACKUP_FILE_COUNT"

log_message "Size: $BACKUP_SIZE"

log_message "Backup verification completed"
```

### Make Executable

```bash
chmod +x /home/$USER/verify_backup.sh
```

---

## 🔹 Subtask 2.6 Test Cron Jobs

### View Jobs

```bash
crontab -l
```

### Test Backup

```bash
./system_backup.sh
```

### Test Verification

```bash
./verify_backup.sh
```

### Check Cron

```bash
systemctl status cron
```

### View Cron Logs

```bash
grep CRON /var/log/syslog | tail -10
```

---

# 🧩 Task 3 — Restore a System from Backup

---

## 🔹 Subtask 3.1 Simulate Data Loss

### Create Recovery Point

```bash
rsync -av \
/home/$USER/important_data/ \
/home/$USER/backups/pre_disaster_backup/
```

### Simulate File Loss

```bash
rm -f document1.txt

rm -f document2.txt

echo "corrupted data" > config.conf

rm -rf subdirectory
```

### Verify Damage

```bash
ls -la

cat config.conf
```

---

## 🔹 Subtask 3.2 Restore Individual Files

```bash
rsync -av \
/home/$USER/backups/system_backup/important_data/document1.txt \
/home/$USER/important_data/
```

```bash
rsync -av \
/home/$USER/backups/system_backup/important_data/document2.txt \
/home/$USER/important_data/
```

### Restore Directory

```bash
rsync -av \
/home/$USER/backups/system_backup/important_data/subdirectory/ \
/home/$USER/important_data/subdirectory/
```

---

## 🔹 Subtask 3.3 Complete Restoration

### Remove Damaged Directory

```bash
rm -rf /home/$USER/important_data
```

### Restore Entire Backup

```bash
rsync -av \
/home/$USER/backups/system_backup/important_data/ \
/home/$USER/important_data/
```

### Verify

```bash
ls -la /home/$USER/important_data/

cat config.conf

cat subdirectory/nested_file.txt
```

---

## 🔹 Subtask 3.4 Create Restoration Script

### Create Script

```bash
nano /home/$USER/restore_system.sh
```

### Features

✅ Confirmation Prompt

✅ Pre-Restore Backup

✅ Full Restoration

✅ Logging

✅ Statistics Generation

### Make Executable

```bash
chmod +x /home/$USER/restore_system.sh
```

---

## 🔹 Subtask 3.5 Selective Restoration Tool

### Create Script

```bash
nano /home/$USER/selective_restore.sh
```

### Features

✅ Restore Single Files

✅ Restore Multiple Files

✅ List Backup Contents

✅ Interactive Menu

### Make Executable

```bash
chmod +x /home/$USER/selective_restore.sh
```

### Run

```bash
./selective_restore.sh
```

---

## 🔹 Subtask 3.6 Verify Restoration Integrity

### Create Script

```bash
nano /home/$USER/verify_restoration.sh
```

### Features

✅ Compare Files

✅ Verify Permissions

✅ Check Integrity

✅ Generate Reports

### Make Executable

```bash
chmod +x /home/$USER/verify_restoration.sh
```

### Run

```bash
./verify_restoration.sh
```

### View Results

```bash
cat /home/$USER/backups/restoration_verification.log
```

---

# 🛠️ Troubleshooting Common Issues

---

## ❌ Permission Denied

### Check Permissions

```bash
ls -la /home/$USER/important_data/
```

### Fix Permissions

```bash
chmod -R u+rw /home/$USER/important_data/
```

### Use Sudo

```bash
sudo rsync -av /etc/ /home/$USER/backups/etc_backup/
```

---

## ❌ Insufficient Disk Space

### View Disk Usage

```bash
df -h
```

### Backup Size

```bash
du -sh /home/$USER/backups/
```

### Cleanup Old Backups

```bash
find /home/$USER/backups/ \
-name "*.tar.gz" \
-mtime +30 \
-delete
```

---

## ❌ Cron Jobs Not Running

### Service Status

```bash
systemctl status cron
```

### Start Service

```bash
sudo systemctl start cron
```

### Logs

```bash
grep CRON /var/log/syslog | tail -20
```

### View Jobs

```bash
crontab -l
```

---

## ❌ Backup Corruption

### Generate Checksums

```bash
find /home/$USER/backups/system_backup \
-type f \
-exec md5sum {} \; \
> /home/$USER/backups/backup_checksums.md5
```

### Verify Integrity

```bash
cd /home/$USER/backups

md5sum -c backup_checksums.md5
```

---

# 🧪 Final Verification

### Check Backup Logs

```bash
cat /home/$USER/backups/backup.log
```

### Verify Backup Exists

```bash
ls -la /home/$USER/backups/system_backup/
```

### Verify Cron Jobs

```bash
crontab -l
```

### Verify Restoration

```bash
./verify_restoration.sh
```

---

# 🎓 Skills Acquired

✅ Linux Backup Administration

✅ Disaster Recovery Planning

✅ rsync Mastery

✅ Incremental Backups

✅ Full Backups

✅ Backup Automation

✅ Restoration Procedures

✅ Backup Verification

✅ Cron Scheduling

✅ Enterprise Data Protection

---

# 🌍 Real-World Applications

### 💾 System Administration

- Server backups
- Configuration backups
- Disaster recovery

### ☁️ Cloud Infrastructure

- Snapshot validation
- Data synchronization
- Backup automation

### ⚙️ DevOps

- CI/CD backup processes
- Infrastructure protection
- Automated recovery

### 🛡️ Security Operations

- Ransomware recovery
- Incident response
- Business continuity

---

# 🏆 Conclusion

In this comprehensive lab, you successfully implemented professional backup and restoration procedures using rsync and cron.

You learned how to:

- 💾 Create efficient backups
- 🔄 Automate backup workflows
- 🧪 Verify backup integrity
- 🛠️ Restore files and systems
- 📊 Monitor backup operations
- 🚨 Prepare for disaster recovery

These skills are directly applicable to:

- Linux Administration
- DevOps Engineering
- Site Reliability Engineering (SRE)
- Cloud Operations
- Cybersecurity & Incident Response

The backup, verification, and restoration solutions created during this lab provide a strong foundation for protecting critical data and ensuring business continuity in production environments.

---

<div align="center">

# 🎉 Lab Completed Successfully

### 💾 System Backup and Restoration

⭐ Backup • Verify • Restore • Recover ⭐

</div>
