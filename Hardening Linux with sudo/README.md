# 🛡️ Hardening Linux with sudo 

![Linux](https://img.shields.io/badge/OS-Linux%20Security-blue)
![Level](https://img.shields.io/badge/Level-Intermediate-orange)
![Focus](https://img.shields.io/badge/Focus-Sudo%20Hardening-red)
![Lab](https://img.shields.io/badge/Platform-Al%20Nafi%20Cloud-green)

---

## 🧠 Overview

This lab focuses on **securing Linux systems using sudo hardening techniques**. You will learn how to configure privileged access, enforce least privilege, and implement auditing and monitoring for administrative commands.

This is a critical skill in enterprise Linux administration and security engineering.

> **Operating System Context:** This lab is primarily optimized for Ubuntu/Debian based systems, but the practices apply globally to enterprise Linux.

---

## 🎯 Objectives

By the end of this lab, you will be able to:

* ✨ Understand the importance of `sudo` in Linux security architecture  
* ✨ Securely configure `/etc/sudoers` using `visudo`  
* ✨ Implement **least privilege access control**  
* ✨ Configure **comprehensive sudo logging & auditing**  
* ✨ Apply enterprise-level sudo hardening practices  
* ✨ Troubleshoot sudo configuration issues  

---

## 🧰 Prerequisites

Before starting, ensure you have:

* 🐧 Basic Linux command line knowledge  
* 👥 User & group management understanding  
* 🔐 File permissions & ownership basics  
* ✏️ Familiarity with nano or vim  
* 📜 Basic knowledge of Linux log files  

---

## ☁️ Lab Environment Setup

Your cloud machine includes:

* Ubuntu 20.04 LTS / CentOS 8  
* Multiple pre-created test users  
* Logging tools pre-installed  
* Root/admin access enabled  

---

# 🚀 Task 1: Secure sudoers File

### 🔍 Step 1: Check sudo configuration

Run the following commands to check your current sudo version, look at your existing privileges, and view file permissions:

```bash
sudo --version
sudo -l
ls -la /etc/sudoers
ls -la /etc/sudoers.d/
```

### ✏️ Step 2: Edit sudoers safely using visudo

Never edit `/etc/sudoers` with a normal text editor. Always use `visudo` to prevent locking yourself out due to syntax errors:

```bash
sudo visudo
```

**Default structure baseline:**
```text
root    ALL=(ALL:ALL) ALL
%admin  ALL=(ALL) ALL
%sudo   ALL=(ALL:ALL) ALL
```

### 🔐 Step 3: Add security hardening

Add the following hardening rules to the end of the file to secure environments, set strict paths, and enforce extensive input/output logging:

```text
Defaults    env_reset
Defaults    use_pty
Defaults    secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
Defaults    log_input, log_output
Defaults    iolog_dir=/var/log/sudo-io
Defaults    logfile=/var/log/sudo.log
Defaults    timestamp_timeout=15
Defaults    passwd_tries=3
Defaults    passwd_timeout=5
```

### 💾 Step 4: Backup sudoers file

Create a timestamped backup copy of your configuration:

```bash
sudo cp /etc/sudoers /etc/sudoers.backup.$(date +%Y%m%d)
ls -la /etc/sudoers.backup.*
```

---

# 👥 Task 2: Least Privilege Access Control

### 👤 Step 1: Create users

```bash
sudo useradd -m webadmin
sudo useradd -m dbadmin
sudo useradd -m developer
sudo useradd -m auditor
```

### 🔐 Step 2: Create groups

```bash
sudo groupadd web-operators
sudo groupadd db-operators
sudo groupadd dev-team
sudo groupadd audit-team
```

### 👨‍💻 Step 3: Assign users to groups

```bash
sudo usermod -a -G web-operators webadmin
sudo usermod -a -G db-operators dbadmin
sudo usermod -a -G dev-team developer
sudo usermod -a -G audit-team auditor
```

### 🧾 Step 4: Configure sudo rules

Create separate, isolated configuration files inside `/etc/sudoers.d/` for role segregation.

#### 🌐 Web Operators
```bash
sudo visudo -f /etc/sudoers.d/web-operators
```
Add the following lines:
```text
%web-operators ALL=(ALL) /usr/bin/systemctl restart apache2, /usr/bin/systemctl restart nginx
webadmin ALL=(ALL) /usr/bin/systemctl restart apache2
```

#### 🗄️ Database Operators
```bash
sudo visudo -f /etc/sudoers.d/db-operators
```
Add the following lines:
```text
%db-operators ALL=(ALL) /usr/bin/systemctl restart mysql, /usr/bin/systemctl restart postgresql
dbadmin ALL=(ALL) /usr/bin/systemctl restart mysql
```

#### 🧑‍💻 Developers
```bash
sudo visudo -f /etc/sudoers.d/dev-team
```
Add the following lines to block dangerous actions while allowing software installations:
```text
%dev-team ALL=(ALL) /usr/bin/apt update, /usr/bin/apt install *
developer ALL=(ALL) !/usr/bin/apt remove *, !/bin/rm -rf /
```

#### 📊 Auditors
```bash
sudo visudo -f /etc/sudoers.d/audit-team
```
Add the following lines:
```text
%audit-team ALL=(ALL) /bin/cat /var/log/*
auditor ALL=(ALL) /usr/bin/systemctl status *
```

### 🧪 Step 5: Testing permissions

Switch to a test user and check that permissions are strictly enforced:

```bash
su - webadmin
sudo systemctl restart apache2
sudo cat /etc/passwd   # ❌ This should fail with a permission error!
exit
```

---

# 📊 Task 3: sudo Logging & Monitoring

### 📁 Step 1: Setup logging directory

Create and restrict permissions on the destination directory for input/output logs:

```bash
sudo mkdir -p /var/log/sudo-io
sudo chmod 750 /var/log/sudo-io
sudo chown root:adm /var/log/sudo-io
```

### 📝 Step 2: Configure rsyslog

Isolate sudo commands into their own specialized system log file:

```bash
sudo nano /etc/rsyslog.d/50-sudo.conf
```
Add this rule:
```text
:programname, isequal, "sudo" /var/log/sudo-commands.log
& stop
```
Restart the service to apply changes:
```bash
sudo systemctl restart rsyslog
```

### 🔄 Step 3: Log rotation

Prevent your logs from consuming all system storage by establishing a log rotation policy:

```bash
sudo nano /etc/logrotate.d/sudo
```
Add the configuration:
```text
/var/log/sudo.log {
    weekly
    rotate 52
    compress
    missingok
}
```

### 📡 Step 4: Monitoring script

Create an automated check script that looks for high-risk commands and triggers a system notification:

```bash
sudo nano /usr/local/bin/sudo-monitor.sh
```
Add the script contents:
```bash
#!/bin/bash
LOG="/var/log/sudo.log"

if tail -n 100 "$LOG" | grep -E "rm -rf|userdel|mkfs"; then
    echo "ALERT: Dangerous sudo activity detected" | logger
fi
```
Make the monitoring script executable:
```bash
sudo chmod +x /usr/local/bin/sudo-monitor.sh
```

### ⏰ Step 5: Cron job

Automate the execution of your script to run every 15 minutes:

```bash
sudo crontab -e
```
Add this entry to your crontab:
```text
*/15 * * * * /usr/local/bin/sudo-monitor.sh
```

---

## ✅ Verification

Verify your files, check live output streams, and inspect authentication logs to confirm operations:

```bash
# Check syntax integrity of all sudoers files
sudo visudo -c

# Monitor live sudo events
sudo tail -f /var/log/sudo.log

# Monitor security system-wide logs filtered by sudo activity
sudo tail -f /var/log/auth.log | grep sudo
```

---

## 🛠️ Troubleshooting

If something breaks, review these common problems and quick solutions:

* **❌ Syntax errors**  
  Fix files immediately by running `sudo visudo` or checking specific subdirectory files using `sudo visudo -f /etc/sudoers.d/filename`.
* **❌ Permission denied**  
  Double check user identities and group memberships using:
  ```bash
  groups username
  id username
  ```
* **❌ Logging not working**  
  If logs are missing, restart the rsyslog daemon to catch up on updates:
  ```bash
  sudo systemctl restart rsyslog
  ```

---

## 🔐 Best Practices

* ✔ Always use `visudo` (never a standard text editor)
* ✔ Enforce least privilege configurations across all roles
* ✔ Enable extensive sudo input/output logging
* ✔ Rotate logs regularly to conserve disk space
* ✔ Actively monitor suspicious, high-impact commands
* ✔ Restrict access to dangerous binaries that allow shell escapes

---

## 🏁 Conclusion

You successfully implemented enterprise-grade sudo hardening including:

* 🔐 Secure sudoers configuration
* 👥 Role-based access control (RBAC)
* 📊 Centralized logging workflows
* 🚨 Real-time monitoring & alerting rules
* 🧪 Security testing & validation steps

This setup significantly reduces privilege escalation risks and improves your overall system auditability posture within modern enterprise Linux environments.
