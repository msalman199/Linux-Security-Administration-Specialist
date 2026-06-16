# 🛡️ System Hardening with Fail2Ban

<div align="center">

# 🚀 Linux Security & Intrusion Prevention 

![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge&logo=ubuntu)
![Fail2Ban](https://img.shields.io/badge/Fail2Ban-Intrusion_Prevention-red?style=for-the-badge)
![Cybersecurity](https://img.shields.io/badge/Cybersecurity-System_Hardening-blue?style=for-the-badge)
![SSH](https://img.shields.io/badge/SSH-Protection-success?style=for-the-badge)
![Apache](https://img.shields.io/badge/Apache-Security-orange?style=for-the-badge&logo=apache)
![DevSecOps](https://img.shields.io/badge/DevSecOps-Automation-purple?style=for-the-badge)

### 🔐 Protect Linux Systems Against Brute-Force Attacks & Intrusion Attempts

</div>

---

# 📖 Overview

Fail2Ban is one of the most effective intrusion prevention frameworks available for Linux systems. It continuously monitors log files, detects malicious activities such as brute-force login attempts, and automatically blocks offending IP addresses using firewall rules.

In this lab, you will learn how to:

✅ Install and configure Fail2Ban

✅ Protect SSH services

✅ Secure Apache/Nginx web servers

✅ Configure FTP protection

✅ Create custom filters and jails

✅ Automate monitoring and maintenance

✅ Manage banned IP addresses

✅ Implement production-ready intrusion prevention

---

# 🎯 Objectives

By the end of this lab, students will be able to:

- 🛡️ Install and configure Fail2Ban
- 🔐 Protect SSH from brute-force attacks
- 🌐 Create web server protection policies
- 📜 Build custom filters and jails
- ⏱️ Configure automated ban durations
- 📊 Monitor intrusion activity
- 🚨 Implement proactive security measures
- 🔎 Analyze system logs effectively
- ⚙️ Automate Fail2Ban maintenance

---

# 📚 Prerequisites

Before starting this lab, students should have:

- 🐧 Basic Linux command-line skills
- 📂 Understanding of system logs
- ✍️ Familiarity with text editors (Nano/Vim)
- 🌐 Basic networking knowledge
- 🔑 Understanding of SSH services
- 📜 Basic regular expression knowledge

---

# 🖥️ Lab Environment

## ☁️ Al Nafi Cloud Machine Setup

This lab runs entirely on a single Linux machine provided by Al Nafi.

Simply click:

**▶️ Start Lab**

to access your pre-configured Ubuntu/CentOS instance.

No additional virtual machines are required.

---

# 🧩 Task 1 — Installing and Configuring Fail2Ban

---

## 🔹 Subtask 1.1 Install Fail2Ban

### 📦 Update Repositories

```bash
sudo apt update
```

### 📦 Install Fail2Ban

```bash
sudo apt install fail2ban -y
```

### ✅ Verify Installation

```bash
fail2ban-client version
```

---

## 🔹 Subtask 1.2 Explore Fail2Ban Structure

### 📂 Navigate to Configuration Directory

```bash
cd /etc/fail2ban
```

### 📋 List Configuration Files

```bash
ls -la
```

### 📖 View Main Configuration

```bash
sudo cat fail2ban.conf
```

### 📖 View Jail Template

```bash
sudo cat jail.conf
```

---

## 🔹 Subtask 1.3 Create Local Configuration Files

### 📁 Create Local Jail File

```bash
sudo cp jail.conf jail.local
```

### 📁 Create Local Fail2Ban File

```bash
sudo cp fail2ban.conf fail2ban.local
```

### 🔍 Verify

```bash
ls -la *.local
```

---

## 🔹 Subtask 1.4 Configure Basic Settings

### ✏️ Edit Configuration

```bash
sudo nano fail2ban.local
```

### Add Configuration

```ini
[Definition]

loglevel = INFO
logtarget = /var/log/fail2ban.log

socket = /var/run/fail2ban/fail2ban.sock

pidfile = /var/run/fail2ban/fail2ban.pid

dbfile = /var/lib/fail2ban/fail2ban.sqlite3
```

---

# 🧩 Task 2 — Configuring SSH Protection

---

## 🔹 Subtask 2.1 Enable SSH Jail

### Edit Jail Configuration

```bash
sudo nano jail.local
```

### Configure Defaults

```ini
[DEFAULT]

bantime = 600

findtime = 600

maxretry = 3

backend = auto

destemail = admin@yourdomain.com

sender = fail2ban@yourdomain.com

action = %(action_)s
```

---

### 🔐 Enable SSH Jail

```ini
[sshd]

enabled = true

port = ssh

filter = sshd

logpath = /var/log/auth.log

maxretry = 3

bantime = 3600

findtime = 600
```

---

## 🔹 Subtask 2.2 Create Custom SSH Filter

### Create Filter File

```bash
sudo nano /etc/fail2ban/filter.d/sshd-custom.conf
```

### Add Filter

```ini
[Definition]

failregex = ^%(__prefix_line)s(?:error: PAM: )?[aA]uthentication (?:failure|error|failed) for .* from <HOST>( via \S+)?\s*$
            ^%(__prefix_line)s(?:error: )?Received disconnect from <HOST>: 3: .*: Auth fail$
            ^%(__prefix_line)sUser .+ from <HOST> not allowed because not listed in AllowUsers$
            ^%(__prefix_line)sUser .+ from <HOST> not allowed because listed in DenyUsers$
            ^%(__prefix_line)sUser .+ from <HOST> not allowed because not in any group$
            ^%(__prefix_line)srefused connect from \S+ \(<HOST>\)$
            ^%(__prefix_line)sReceived disconnect from <HOST>: 11: Bye Bye$
            ^%(__prefix_line)sConnection closed by <HOST>$

ignoreregex =

[Init]

__prefix_line = (?:(?:\S+ )?(?:kernel: )?(?:\[\s*\d+\.\d+\] )?(?:\S+\s+)?(?:\S+:\s+)?)?
```

---

## 🔹 Subtask 2.3 Test SSH Configuration

### Start Fail2Ban

```bash
sudo systemctl start fail2ban
```

### Enable at Boot

```bash
sudo systemctl enable fail2ban
```

### Check Status

```bash
sudo systemctl status fail2ban
```

### View Active Jails

```bash
sudo fail2ban-client status
```

### View SSH Jail

```bash
sudo fail2ban-client status sshd
```

---

# 🧩 Task 3 — Custom Jail Configurations

---

## 🔹 Subtask 3.1 Configure Apache Protection

### Edit Jail Configuration

```bash
sudo nano jail.local
```

### Apache Authentication Protection

```ini
[apache-auth]

enabled = true

port = http,https

filter = apache-auth

logpath = /var/log/apache2/error.log

maxretry = 3

bantime = 3600

findtime = 600
```

---

### Apache Bad Bots Protection

```ini
[apache-badbots]

enabled = true

port = http,https

filter = apache-badbots

logpath = /var/log/apache2/access.log

maxretry = 2

bantime = 86400

findtime = 600
```

---

### Apache NoScript Protection

```ini
[apache-noscript]

enabled = true

port = http,https

filter = apache-noscript

logpath = /var/log/apache2/access.log

maxretry = 6

bantime = 86400

findtime = 600
```

---

## 🔹 Subtask 3.2 Create Custom Web Application Filter

### Create Filter

```bash
sudo nano /etc/fail2ban/filter.d/webapp-custom.conf
```

### Add Configuration

```ini
[Definition]

failregex = ^<HOST> -.*"(GET|POST).*" (404|403|500) .*$
            ^<HOST> -.*"(GET|POST).*(\.php|\.asp|\.jsp).*" 200 .*$
            ^<HOST> -.*"(GET|POST).*(union|select|insert|delete|drop|create|alter).*" .*$
            ^<HOST> -.*"(GET|POST).*(<script|javascript:|vbscript:).*" .*$

ignoreregex =
```

---

### Enable Web Application Jail

```ini
[webapp-custom]

enabled = true

port = http,https

filter = webapp-custom

logpath = /var/log/apache2/access.log

maxretry = 5

bantime = 7200

findtime = 300
```

---

## 🔹 Subtask 3.3 Configure FTP Protection

### VSFTPD Jail

```ini
[vsftpd]

enabled = true

port = ftp,ftp-data,ftps,ftps-data

filter = vsftpd

logpath = /var/log/vsftpd.log

maxretry = 3

bantime = 3600

findtime = 600
```

---

### ProFTPD Jail

```ini
[proftpd]

enabled = true

port = ftp,ftp-data,ftps,ftps-data

filter = proftpd

logpath = /var/log/proftpd/proftpd.log

maxretry = 3

bantime = 3600

findtime = 600
```

---

# 🧩 Task 4 — Automating Ban Duration and Monitoring

---

## 🔹 Subtask 4.1 Configure Progressive Bans

```ini
[DEFAULT]

bantime.increment = true

bantime.factor = 2

bantime.formula = ban.Time * (1<<(ban.Count if ban.Count<20 else 20)) * banFactor

bantime.maxtime = 604800

bantime.overalljails = true
```

---

## 🔹 Subtask 4.2 Create Monitoring Script

### Create Script

```bash
sudo nano /usr/local/bin/fail2ban-monitor.sh
```

### Monitoring Script

```bash
#!/bin/bash

LOG_FILE="/var/log/fail2ban-monitor.log"

DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "=== Fail2Ban Status Report - $DATE ===" >> $LOG_FILE

systemctl is-active fail2ban >> $LOG_FILE

fail2ban-client status >> $LOG_FILE

tail -20 /var/log/fail2ban.log | grep "Ban" >> $LOG_FILE

echo "=== End Report ===" >> $LOG_FILE
```

### Make Executable

```bash
sudo chmod +x /usr/local/bin/fail2ban-monitor.sh
```

### Test Script

```bash
sudo /usr/local/bin/fail2ban-monitor.sh
```

### View Log

```bash
sudo cat /var/log/fail2ban-monitor.log
```

---

## 🔹 Subtask 4.3 Schedule Automated Monitoring

### Edit Root Crontab

```bash
sudo crontab -e
```

### Add Job

```cron
0 * * * * /usr/local/bin/fail2ban-monitor.sh
```

---

## 🔹 Subtask 4.4 Create Ban Management Script

### Create Script

```bash
sudo nano /usr/local/bin/fail2ban-manage.sh
```

### Features

✅ Show jail status

✅ Ban IP manually

✅ Unban IP

✅ List banned IPs

✅ Display help menu

### Make Executable

```bash
sudo chmod +x /usr/local/bin/fail2ban-manage.sh
```

### Test

```bash
sudo /usr/local/bin/fail2ban-manage.sh --status
```

---

# 🧩 Task 5 — Testing and Verification

---

## 🔹 Subtask 5.1 Restart and Verify

### Restart Service

```bash
sudo systemctl restart fail2ban
```

### Check Status

```bash
sudo systemctl status fail2ban
```

### Verify Jails

```bash
sudo fail2ban-client status
```

### SSH Jail Status

```bash
sudo fail2ban-client status sshd
```

---

## 🔹 Subtask 5.2 Test Ban Functionality

### Monitor Authentication Logs

```bash
sudo tail -f /var/log/auth.log
```

### Simulate Failed SSH Login

```bash
ssh testuser@localhost
```

### Check Ban Status

```bash
sudo fail2ban-client status sshd
```

### View Ban Activity

```bash
sudo tail -20 /var/log/fail2ban.log
```

---

## 🔹 Subtask 5.3 Verify Log Monitoring

### View Log Path

```bash
sudo fail2ban-client get sshd logpath
```

### Verify Permissions

```bash
ls -la /var/log/auth.log
```

### Test Log Rotation

```bash
sudo logrotate -f /etc/logrotate.d/rsyslog
```

### Restart Fail2Ban

```bash
sudo systemctl restart fail2ban
```

---

# 🧩 Task 6 — Advanced Configuration

---

## 🔹 Subtask 6.1 Configure Whitelist

### Edit Jail Configuration

```bash
sudo nano jail.local
```

### Add Trusted Networks

```ini
[DEFAULT]

ignoreip = 127.0.0.1/8 ::1 192.168.1.0/24 10.0.0.0/8

ignoreself = true

ignorecommand =
```

---

## 🔹 Subtask 6.2 Configure Email Notifications

### Install Mail Utilities

```bash
sudo apt install mailutils -y
```

### Configure Email Alerts

```ini
[DEFAULT]

destemail = admin@yourdomain.com

sender = fail2ban@yourdomain.com

mta = mail

action = %(action_mwl)s
```

---

## 🔹 Subtask 6.3 Performance Optimization

### Edit Configuration

```bash
sudo nano fail2ban.local
```

### Add Optimizations

```ini
[Definition]

dbpurgeage = 86400

dbmaxmatches = 10

backend = systemd
```

---

# 🧩 Task 7 — Maintenance and Troubleshooting

---

## 🔹 Subtask 7.1 Create Maintenance Script

### Create Script

```bash
sudo nano /usr/local/bin/fail2ban-maintenance.sh
```

### Features

✅ Reload Configuration

✅ Database Cleanup

✅ Log Rotation

✅ Configuration Validation

### Make Executable

```bash
sudo chmod +x /usr/local/bin/fail2ban-maintenance.sh
```

### Weekly Schedule

```cron
0 2 * * 0 /usr/local/bin/fail2ban-maintenance.sh
```

---

## 🔹 Subtask 7.2 Troubleshooting Checklist

### Service Status

```bash
sudo systemctl status fail2ban
```

### Test Configuration

```bash
sudo fail2ban-client -t
```

### Verify Logs

```bash
ls -la /var/log/auth.log /var/log/fail2ban.log
```

### Active Jails

```bash
sudo fail2ban-client status
```

### Firewall Rules

```bash
sudo iptables -L -n
```

### Real-Time Monitoring

```bash
sudo tail -f /var/log/fail2ban.log
```

### Resource Usage

```bash
ps aux | grep fail2ban
```

---

# 🧪 Verification & Testing

## 🔍 Create Verification Script

```bash
sudo nano /usr/local/bin/fail2ban-verify.sh
```

### Verification Script

```bash
#!/bin/bash

echo "=== Fail2Ban System Verification ==="

echo "1. Service Status:"
systemctl is-active fail2ban

echo ""

echo "2. Active Jails:"
fail2ban-client status

echo ""

echo "3. Configuration Test:"
fail2ban-client -t

echo ""

echo "4. Recent Activity:"
tail -10 /var/log/fail2ban.log

echo ""

echo "=== Verification Complete ==="
```

### Make Executable

```bash
sudo chmod +x /usr/local/bin/fail2ban-verify.sh
```

### Run Verification

```bash
sudo /usr/local/bin/fail2ban-verify.sh
```

---

# 🎓 Skills Acquired

✅ Linux Security Hardening

✅ Intrusion Prevention Systems

✅ SSH Protection

✅ Apache/Nginx Security

✅ FTP Security

✅ Log Analysis

✅ Regex-Based Detection

✅ Automated Monitoring

✅ Security Automation

✅ Incident Response Preparation

---

# 🌍 Real-World Applications

### 🔐 Linux Server Security

- SSH brute-force protection
- Intrusion prevention
- Automated banning

### 🌐 Web Security

- Web attack detection
- Malicious bot blocking
- Application protection

### ⚙️ DevSecOps

- Automated security monitoring
- Alerting systems
- Security automation

### 🛡️ Security Operations

- Threat detection
- Log monitoring
- Security event response

---

# 🏆 Conclusion

In this comprehensive lab, you successfully implemented a complete intrusion prevention system using Fail2Ban.

You learned how to:

- 🔐 Protect SSH services
- 🌐 Secure web servers
- 📂 Create custom jails and filters
- 🚨 Detect malicious activity
- ⏱️ Automate ban management
- 📊 Monitor security events
- 📧 Configure alerting
- ⚙️ Automate maintenance

These skills are directly applicable to:

- Linux Security Administration
- DevSecOps Engineering
- SOC Operations
- Cloud Security
- Cyber Defense

The monitoring, management, and automation scripts developed during this lab provide a production-ready foundation for securing Linux systems against brute-force attacks and malicious activity.

---

<div align="center">

# 🎉 Lab Completed Successfully

### 🛡️ System Hardening with Fail2Ban

⭐ Secure • Detect • Monitor • Protect ⭐

</div>
