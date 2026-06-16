# ⏰ Automating Tasks with Cron

<div align="center">

# 🚀 Linux Task Automation 

![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge&logo=ubuntu)
![Cron](https://img.shields.io/badge/Cron-Automation-blue?style=for-the-badge)
![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?style=for-the-badge&logo=gnubash)
![Systemd](https://img.shields.io/badge/Systemd-Service-red?style=for-the-badge)
![Monitoring](https://img.shields.io/badge/System-Monitoring-success?style=for-the-badge)
![DevOps](https://img.shields.io/badge/DevOps-Automation-orange?style=for-the-badge)

### 🔥 Learn Linux Task Scheduling, Automation, Monitoring, and Cron Management

</div>

---

# 📖 Overview

Cron is one of the most powerful automation tools available in Linux. It allows administrators and DevOps engineers to schedule recurring tasks such as backups, monitoring, maintenance, log rotation, health checks, and reporting.

In this lab, you will learn how to:

✅ Configure and manage cron services

✅ Create scheduled tasks

✅ Automate Bash scripts

✅ Monitor system health

✅ Build backup solutions

✅ Implement alerting mechanisms

✅ Troubleshoot cron-related issues

---

# 🎯 Objectives

By the end of this lab, students will be able to:

- ✅ Understand cron fundamentals and architecture
- ✅ Create and manage cron jobs
- ✅ Schedule recurring automation tasks
- ✅ Integrate shell scripts with cron
- ✅ Monitor cron execution logs
- ✅ Implement backup and maintenance automation
- ✅ Create health monitoring solutions
- ✅ Troubleshoot scheduling issues
- ✅ Build production-style cron workflows

---

# 📚 Prerequisites

Before starting this lab, students should have:

- 🐧 Basic Linux command-line knowledge
- 📜 Shell scripting fundamentals
- 🔐 Understanding of Linux permissions
- ✍️ Experience with text editors (nano/vim)
- 📁 Familiarity with Linux filesystem structure

---

# 🖥️ Lab Environment

## ☁️ Al Nafi Cloud Machine Setup

This lab runs entirely on Al Nafi's Linux cloud machines.

Simply click:

**▶️ Start Lab**

and access a pre-configured Linux environment.

### System Requirements

| Component | Requirement |
|------------|-------------|
| OS | Linux Distribution |
| Scheduler | Cron Service |
| Privileges | Root/Sudo Access |
| Editor | Nano/Vim |
| Utilities | Standard Linux Tools |

---

# 🧩 Task 1 — Understanding and Setting Up Cron

---

## 🔹 Subtask 1.1 Verify Cron Service Status

### 📌 Check Cron Status

```bash
sudo systemctl status cron
```

### 📌 Start Cron Service

```bash
sudo systemctl start cron
```

### 📌 Enable Cron at Boot

```bash
sudo systemctl enable cron
```

---

## 🔹 Subtask 1.2 Explore Cron Configuration Files

### 📂 View System-Wide Cron Directories

```bash
ls -la /etc/cron*
```

### 📂 View User Cron Directories

```bash
sudo ls -la /var/spool/cron/crontabs/
```

### 📂 View Existing User Cron Jobs

```bash
crontab -l
```

---

## 🔹 Subtask 1.3 Understand Cron Syntax

### 📝 Create Cron Reference File

```bash
cat > ~/cron_syntax_reference.txt << 'EOF'
Cron Time Format: * * * * * command
                  | | | | |
                  | | | | +-- Day of week (0-7)
                  | | | +---- Month (1-12)
                  | | +------ Day of month (1-31)
                  | +-------- Hour (0-23)
                  +---------- Minute (0-59)

Special Characters:
* = Any value
, = List separator
- = Range
/ = Step values

Examples:
0 0 * * * = Daily at midnight
0 */6 * * * = Every 6 hours
30 2 * * 1 = Every Monday at 2:30 AM
0 0 1 * * = First day of every month
*/15 * * * * = Every 15 minutes
EOF
```

### 📖 Display Reference

```bash
cat ~/cron_syntax_reference.txt
```

---

# 🧩 Task 2 — Creating and Managing Cron Jobs

---

## 🔹 Subtask 2.1 Create First Cron Job

### 📁 Create Working Directories

```bash
mkdir -p ~/cron_scripts
mkdir -p ~/cron_logs
```

### 📝 Create Date Logger Script

```bash
cat > ~/cron_scripts/date_logger.sh << 'EOF'
#!/bin/bash

echo "$(date): Cron job executed successfully" >> ~/cron_logs/date_log.txt
EOF
```

### 🔓 Make Script Executable

```bash
chmod +x ~/cron_scripts/date_logger.sh
```

### ▶️ Test Script

```bash
~/cron_scripts/date_logger.sh
```

### 📄 Verify Log

```bash
cat ~/cron_logs/date_log.txt
```

---

## 🔹 Subtask 2.2 Add Job to Crontab

### ✏️ Edit Crontab

```bash
crontab -e
```

Add:

```cron
* * * * * /home/$USER/cron_scripts/date_logger.sh
```

### ⚡ Alternative Method

```bash
(crontab -l 2>/dev/null; echo "* * * * * $HOME/cron_scripts/date_logger.sh") | crontab -
```

### 🔍 Verify

```bash
crontab -l
```

---

## 🔹 Subtask 2.3 Monitor Cron Job

```bash
sleep 240

cat ~/cron_logs/date_log.txt
```

### Count Executions

```bash
wc -l ~/cron_logs/date_log.txt
```

---

## 🔹 Subtask 2.4 Create Advanced Automation Scripts

### 📊 System Monitoring Script

```bash
cat > ~/cron_scripts/system_monitor.sh << 'EOF'
#!/bin/bash

LOG_FILE="$HOME/cron_logs/system_monitor.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "=== System Monitor Report - $DATE ===" >> $LOG_FILE

top -bn1 | grep "Cpu(s)" >> $LOG_FILE
free -h >> $LOG_FILE
df -h / >> $LOG_FILE
uptime >> $LOG_FILE

echo "----------------------------------------" >> $LOG_FILE
EOF
```

---

### 💾 Backup Script

```bash
cat > ~/cron_scripts/backup_script.sh << 'EOF'
#!/bin/bash

BACKUP_DIR="$HOME/backups"
DATE=$(date '+%Y%m%d_%H%M%S')
LOG_FILE="$HOME/cron_logs/backup.log"

mkdir -p $BACKUP_DIR

tar -czf "$BACKUP_DIR/home_backup_$DATE.tar.gz" \
-C $HOME \
--exclude='backups' \
--exclude='cron_logs' .

if [ $? -eq 0 ]; then
 echo "$(date): Backup completed successfully" >> $LOG_FILE
else
 echo "$(date): Backup failed" >> $LOG_FILE
fi

cd $BACKUP_DIR
ls -t home_backup_*.tar.gz | tail -n +6 | xargs -r rm
EOF
```

---

### 🧹 Cleanup Script

```bash
cat > ~/cron_scripts/cleanup_script.sh << 'EOF'
#!/bin/bash

LOG_FILE="$HOME/cron_logs/cleanup.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "$DATE: Starting cleanup" >> $LOG_FILE

find $HOME/cron_logs -name "*.log" -type f -mtime +7 -delete
find /tmp -name "tmp*" -user $USER -mtime +1 -delete

echo "$DATE: Cleanup completed" >> $LOG_FILE
EOF
```

---

### 🔓 Make Scripts Executable

```bash
chmod +x ~/cron_scripts/*.sh
```

---

## 🔹 Subtask 2.5 Schedule Multiple Cron Jobs

### 📅 Create Multi-Job Crontab

```bash
cat > ~/temp_crontab << EOF

*/5 * * * * $HOME/cron_scripts/system_monitor.sh
30 * * * * $HOME/cron_scripts/backup_script.sh
0 2 * * * $HOME/cron_scripts/cleanup_script.sh
*/2 * * * * $HOME/cron_scripts/date_logger.sh

EOF
```

### 📥 Install

```bash
crontab ~/temp_crontab
```

### 🔍 Verify

```bash
crontab -l
```

---

# 🧩 Task 3 — Advanced Automation Scripts

---

## 🗄️ Database Maintenance Script

```bash
cat > ~/cron_scripts/db_maintenance.sh << 'EOF'
#!/bin/bash

LOG_FILE="$HOME/cron_logs/db_maintenance.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "$DATE: Starting database maintenance" >> $LOG_FILE

sleep 2

echo "$DATE: Optimizing tables..." >> $LOG_FILE

sleep 1

echo "$DATE: Database integrity check PASSED" >> $LOG_FILE

echo "$DATE: Maintenance completed" >> $LOG_FILE
EOF
```

---

## ❤️ Service Health Check Script

```bash
cat > ~/cron_scripts/health_check.sh << 'EOF'
#!/bin/bash

LOG_FILE="$HOME/cron_logs/health_check.log"

SERVICES=("cron" "systemd-logind")

for service in "${SERVICES[@]}"
do
 if systemctl is-active --quiet $service
 then
   echo "$service OK" >> $LOG_FILE
 else
   echo "$service FAILED" >> $LOG_FILE
 fi
done
EOF
```

---

## 📧 Email Notification Simulation

```bash
cat > ~/cron_scripts/email_notification.sh << 'EOF'
#!/bin/bash

LOG_FILE="$HOME/cron_logs/notifications.log"

echo "Simulated Email Notification Sent" >> $LOG_FILE
EOF
```

---

# 🧩 Task 4 — Monitoring and Troubleshooting

---

## 📜 View Cron Logs

```bash
sudo tail -20 /var/log/cron
```

or

```bash
sudo tail -20 /var/log/syslog | grep CRON
```

---

## 📊 Cron Dashboard Generator

```bash
cat > ~/cron_scripts/cron_dashboard.sh << 'EOF'
#!/bin/bash

DASHBOARD="$HOME/cron_logs/dashboard.html"

echo "<html><body>" > $DASHBOARD
echo "<h1>Cron Dashboard</h1>" >> $DASHBOARD
crontab -l >> $DASHBOARD
echo "</body></html>" >> $DASHBOARD
EOF
```

---

## 🚨 Error Detection Script

```bash
cat > ~/cron_scripts/error_detector.sh << 'EOF'
#!/bin/bash

ERROR_LOG="$HOME/cron_logs/errors.log"

echo "$(date): Starting error detection" >> $ERROR_LOG

if ! systemctl is-active --quiet cron
then
 echo "Cron service is down!" >> $ERROR_LOG
fi
EOF
```

---

# 🛠️ Troubleshooting

---

## ❌ Cron Jobs Not Running

```bash
sudo systemctl status cron
```

```bash
crontab -l
```

```bash
sudo grep CRON /var/log/syslog | tail -10
```

---

## ❌ Permission Problems

```bash
chmod +x ~/cron_scripts/*.sh

chmod 755 ~/cron_scripts/

chmod 755 ~/cron_logs/
```

---

## ❌ Debug Cron Environment

```bash
cat > ~/cron_scripts/debug_script.sh << 'EOF'
#!/bin/bash

DEBUG_LOG="$HOME/cron_logs/debug.log"

echo "PATH=$PATH" >> $DEBUG_LOG
echo "USER=$USER" >> $DEBUG_LOG
echo "PWD=$PWD" >> $DEBUG_LOG
echo "HOME=$HOME" >> $DEBUG_LOG
EOF
```

---

# ✅ Lab Verification

## 🧪 Verification Script

```bash
cat > ~/verify_lab.sh << 'EOF'
#!/bin/bash

echo "=== Cron Lab Verification ==="

systemctl is-active cron

echo ""
echo "Configured Jobs:"
crontab -l

echo ""
echo "Scripts:"
ls ~/cron_scripts/*.sh

echo ""
echo "Logs:"
ls ~/cron_logs/

echo ""
echo "Verification Complete"
EOF

chmod +x ~/verify_lab.sh

~/verify_lab.sh
```

---

# 📊 Skills Acquired

✅ Cron Administration

✅ Task Scheduling

✅ Bash Automation

✅ Backup Management

✅ Health Monitoring

✅ Error Detection

✅ Log Management

✅ Dashboard Creation

✅ DevOps Automation

✅ Linux System Administration

---

# 🌍 Real-World Applications

### 🖥️ System Administration

- Automated backups
- Log rotation
- Disk cleanup

### ⚙️ DevOps

- Deployment scheduling
- Infrastructure monitoring
- Health checks

### 🔐 Security Operations

- Log analysis
- Scheduled security scans
- Alert generation

### 🗄️ Database Administration

- Automated maintenance
- Integrity checks
- Backup automation

---

# 🏆 Conclusion

This lab provided hands-on experience with Linux task automation using Cron.

You learned how to:

- ⏰ Schedule tasks
- 📜 Automate Bash scripts
- 📊 Monitor systems
- 💾 Create backups
- 🚨 Detect errors
- 📧 Generate notifications
- 🔧 Troubleshoot cron environments

These skills form a critical foundation for:

- Linux Administration
- DevOps Engineering
- Site Reliability Engineering (SRE)
- Cloud Operations
- Cybersecurity Automation

---

<div align="center">

## 🎉 Lab Completed Successfully

**Mastering Linux Automation with Cron**

⭐ Happy Learning & Happy Automating ⭐

</div>
