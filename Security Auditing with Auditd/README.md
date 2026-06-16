# 🔍 Security Auditing with Auditd

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Ubuntu](https://img.shields.io/badge/Ubuntu_20.04_LTS-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![CentOS](https://img.shields.io/badge/CentOS_8-262577?style=for-the-badge&logo=centos&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Auditd](https://img.shields.io/badge/Auditd-Security_Auditing-DC143C?style=for-the-badge&logo=shield&logoColor=white)
![Systemd](https://img.shields.io/badge/Systemd-Service_Manager-000000?style=for-the-badge&logo=linux&logoColor=white)
![Security](https://img.shields.io/badge/Security-Compliance_Monitoring-8B0000?style=for-the-badge&logo=shield&logoColor=white)
![Forensics](https://img.shields.io/badge/Forensics-Incident_Response-FF6600?style=for-the-badge&logo=search&logoColor=white)

> 🛡️ A comprehensive hands-on lab covering **auditd installation**, **custom audit rules**, **log analysis**, **system call monitoring**, and **automated audit management** — essential skills for Linux security, compliance, and incident response.

---

## 🎓 Learning Objectives

By the end of this lab, students will be able to:

- ✅ Understand the fundamentals of **Linux system auditing** using auditd
- ✅ Install and configure the **auditd service** for comprehensive system monitoring
- ✅ Create and implement **custom audit rules** for monitoring sensitive files and directories
- ✅ **Analyze audit logs** to identify suspicious activities and security events
- ✅ Generate detailed **audit reports** for compliance and security analysis
- ✅ Troubleshoot common **auditd configuration** issues

---

## 🔧 Prerequisites

| Requirement | Details |
|---|---|
| 💻 CLI Knowledge | Basic Linux command-line operations |
| 🔒 Permissions | Understanding of file permissions and ownership |
| ⚙️ Services | Familiarity with systemd and `systemctl` commands |
| 📋 Log Analysis | Basic knowledge of log file analysis |
| 📂 File System | Understanding of Linux file system structure |

---

## 🖥️ Lab Environment

> 🚀 **Al Nafi** provides ready-to-use Linux cloud machines. Click **Start Lab** to access your pre-configured environment — no VM setup required!

| Component | Details |
|---|---|
| 🖥️ OS | Ubuntu 20.04 LTS or CentOS 8 |
| 🔑 Access | Root or `sudo` access required |
| 💾 Hardware | Minimum 2 GB RAM and 10 GB disk space |
| 🌐 Network | Required for package installation |

---

## ⚙️ Task 1: Configure Auditd Rules for Monitoring Sensitive Files

### 📦 Subtask 1.1 — Install and Enable Auditd Service

#### 🪜 Step 1: Update the package repository and install auditd

```bash
# 🔄 Update package lists
sudo apt update

# 📥 Install auditd and related utilities
sudo apt install auditd audispd-plugins -y
```

#### 🪜 Step 2: Start and enable the auditd service

```bash
# ▶️ Start the auditd service
sudo systemctl start auditd

# 🔁 Enable auditd to start automatically at boot
sudo systemctl enable auditd

# 📊 Check the status of auditd service
sudo systemctl status auditd
```

#### 🪜 Step 3: Verify auditd installation and configuration files

```bash
# ✅ Check if audit daemon is running
sudo auditctl -s

# 📋 List current audit rules
sudo auditctl -l

# 📄 View main configuration file
sudo cat /etc/audit/auditd.conf
```

---

### 📝 Subtask 1.2 — Configure Basic Audit Rules

#### 🪜 Step 1: Create a backup of existing audit rules

```bash
# 📂 Create backup directory
sudo mkdir -p /etc/audit/backup

# 💾 Backup current rules file
sudo cp /etc/audit/rules.d/audit.rules \
    /etc/audit/backup/audit.rules.backup.$(date +%Y%m%d)
```

#### 🪜 Step 2: Create custom audit rules file

```bash
sudo nano /etc/audit/rules.d/custom-security.rules
```

#### 🪜 Step 3: Add the following security monitoring rules

```bash
# 🛡️ Custom Security Audit Rules

# 👤 Monitor changes to passwd file
-w /etc/passwd -p wa -k passwd_changes

# 👥 Monitor changes to group file
-w /etc/group -p wa -k group_changes

# 🔒 Monitor changes to shadow file
-w /etc/shadow -p wa -k shadow_changes

# 🔑 Monitor changes to sudoers file
-w /etc/sudoers -p wa -k sudoers_changes

# 🔐 Monitor SSH configuration changes
-w /etc/ssh/sshd_config -p wa -k ssh_config_changes

# 🚪 Monitor login/logout events
-w /var/log/lastlog -p wa -k login_events

# ❌ Monitor failed login attempts
-w /var/log/faillog -p wa -k failed_logins

# 🚀 Monitor system startup scripts
-w /etc/init.d/ -p wa -k init_scripts

# ⏰ Monitor cron jobs
-w /etc/cron.allow    -p wa -k cron_changes
-w /etc/cron.deny     -p wa -k cron_changes
-w /etc/cron.d/       -p wa -k cron_changes
-w /etc/cron.daily/   -p wa -k cron_changes
-w /etc/cron.hourly/  -p wa -k cron_changes
-w /etc/cron.monthly/ -p wa -k cron_changes
-w /etc/cron.weekly/  -p wa -k cron_changes
-w /etc/crontab       -p wa -k cron_changes

# 🌐 Monitor network configuration changes
-w /etc/hosts    -p wa -k network_changes
-w /etc/network/ -p wa -k network_changes

# 🔒 Make the configuration immutable
-e 2
```

#### 🪜 Step 4: Load the new audit rules

```bash
# 🔄 Reload audit rules
sudo augenrules --load

# 🔁 Restart auditd service to apply changes
sudo service auditd restart

# ✅ Verify rules are loaded
sudo auditctl -l
```

---

### 📂 Subtask 1.3 — Monitor Specific Directories and Files

#### 🪜 Step 1: Create rules for monitoring user directories

```bash
sudo nano /etc/audit/rules.d/user-monitoring.rules
```

#### 🪜 Step 2: Add the following directory monitoring rules

```bash
# 👁️ User Directory Monitoring Rules

# 🗂️ Monitor /tmp directory for suspicious activities
-w /tmp     -p wa -k tmp_access
-w /var/tmp -p wa -k var_tmp_access

# ⚙️ Monitor system binaries
-w /bin      -p wa -k system_binaries
-w /sbin     -p wa -k system_binaries
-w /usr/bin  -p wa -k system_binaries
-w /usr/sbin -p wa -k system_binaries

# 📚 Monitor library directories
-w /lib      -p wa -k system_libraries
-w /lib64    -p wa -k system_libraries
-w /usr/lib  -p wa -k system_libraries

# 🧩 Monitor kernel modules
-w /lib/modules -p wa -k kernel_modules
```

#### 🪜 Step 3: Apply the new rules

```bash
# 🔄 Reload all audit rules
sudo augenrules --load

# 🔁 Restart auditd service
sudo service auditd restart

# 🔢 Check total number of rules loaded
sudo auditctl -l | wc -l
```

---

## 🔬 Task 2: Analyze Audit Logs for Suspicious Activities

### 🧪 Subtask 2.1 — Generate Test Activities

#### 🪜 Step 1: Create test activities for passwd file monitoring

```bash
# ➕ Create a test user (triggers passwd file monitoring)
sudo useradd testuser1

# ✏️ Modify the test user
sudo usermod -c "Test User for Audit Demo" testuser1

# 🗑️ Delete the test user
sudo userdel testuser1
```

#### 🪜 Step 2: Create test activities for file system monitoring

```bash
# 📄 Create test files in monitored directories
sudo touch /tmp/suspicious_file.txt
echo "test content" | sudo tee /tmp/suspicious_file.txt

# 💾 Backup SSH config, add comment, then restore
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
echo "# Test comment for audit" | sudo tee -a /etc/ssh/sshd_config
sudo cp /etc/ssh/sshd_config.backup /etc/ssh/sshd_config
```

#### 🪜 Step 3: Create test cron job activities

```bash
# ➕ Add a test cron job
echo "0 2 * * * /bin/echo 'test cron job'" | sudo tee -a /etc/crontab

# 🗑️ Remove the test cron job
sudo sed -i '/test cron job/d' /etc/crontab
```

---

### 🔍 Subtask 2.2 — Search and Analyze Audit Logs

#### 🪜 Step 1: Use ausearch to find specific events

```bash
# 👤 Search for passwd file changes
sudo ausearch -k passwd_changes

# 🔐 Search for SSH configuration changes
sudo ausearch -k ssh_config_changes

# ⏰ Search for cron-related changes
sudo ausearch -k cron_changes

# 🕐 Search for events in the last hour
sudo ausearch -ts recent
```

#### 🪜 Step 2: Generate detailed audit reports

```bash
# 📊 Create a comprehensive audit report
sudo aureport

# 📅 Generate summary report for today
sudo aureport --start today

# 👤 Generate user activity report
sudo aureport -u

# 📄 Generate file access report
sudo aureport -f

# 🔐 Generate authentication report
sudo aureport -au
```

#### 🪜 Step 3: Analyze specific event types

```bash
# 📂 Search for file access events
sudo ausearch -m PATH

# 🔑 Search for user authentication events
sudo ausearch -m USER_AUTH

# ⚙️ Search for system call events
sudo ausearch -m SYSCALL

# 👤 Search for root user events
sudo ausearch -ui 0
```

---

### 📜 Subtask 2.3 — Create Custom Log Analysis Scripts

#### 🪜 Step 1: Create the automated log analysis script

```bash
nano audit_analyzer.sh
```

#### 🪜 Step 2: Add the following script content

```bash
#!/bin/bash

# 📊 Audit Log Analysis Script

echo "=== 📋 Audit Log Analysis Report ==="
echo "📅 Generated on: $(date)"
echo "======================================"

echo ""
echo "1️⃣  SYSTEM OVERVIEW:"
echo "-------------------"
sudo auditctl -s

echo ""
echo "2️⃣  RECENT PASSWD CHANGES:"
echo "-------------------------"
sudo ausearch -k passwd_changes -ts recent 2>/dev/null \
    | grep -E "(type=|msg=)" | head -10

echo ""
echo "3️⃣  SSH CONFIGURATION CHANGES:"
echo "-----------------------------"
sudo ausearch -k ssh_config_changes -ts recent 2>/dev/null \
    | grep -E "(type=|msg=)" | head -10

echo ""
echo "4️⃣  CRON JOB MODIFICATIONS:"
echo "--------------------------"
sudo ausearch -k cron_changes -ts recent 2>/dev/null \
    | grep -E "(type=|msg=)" | head -10

echo ""
echo "5️⃣  TEMPORARY FILE ACCESS:"
echo "-------------------------"
sudo ausearch -k tmp_access -ts recent 2>/dev/null \
    | grep -E "(type=|msg=)" | head -10

echo ""
echo "6️⃣  FAILED LOGIN ATTEMPTS:"
echo "-------------------------"
sudo ausearch -k failed_logins -ts recent 2>/dev/null \
    | grep -E "(type=|msg=)" | head -10

echo ""
echo "7️⃣  SUMMARY STATISTICS:"
echo "----------------------"
echo "📦 Total events today  : $(sudo ausearch -ts today 2>/dev/null | wc -l)"
echo "👤 Unique users active : $(sudo aureport -u --start today 2>/dev/null | grep -v '^$' | wc -l)"
echo "📄 Files accessed      : $(sudo aureport -f --start today 2>/dev/null | grep -v '^$' | wc -l)"

echo ""
echo "=== ✅ End of Report ==="
```

#### 🪜 Step 3: Make the script executable and run it

```bash
chmod +x audit_analyzer.sh
./audit_analyzer.sh
```

---

## 📐 Task 3: Create Custom Audit Rules

### 🌐 Subtask 3.1 — Design Application-Specific Audit Rules

#### 🪜 Step 1: Create web server monitoring rules

```bash
sudo nano /etc/audit/rules.d/webserver-monitoring.rules
```

```bash
# 🌐 Web Server Security Monitoring Rules

# ⚙️ Monitor Apache/Nginx configuration files
-w /etc/apache2/ -p wa -k webserver_config
-w /etc/nginx/   -p wa -k webserver_config

# 🌍 Monitor web root directories
-w /var/www/ -p wa -k web_content

# 📋 Monitor log directories
-w /var/log/apache2/ -p wa -k webserver_logs
-w /var/log/nginx/   -p wa -k webserver_logs

# 🔒 Monitor SSL certificates
-w /etc/ssl/ -p wa -k ssl_certificates

# 🐘 Monitor PHP configuration
-w /etc/php/ -p wa -k php_config
```

#### 🪜 Step 2: Create database monitoring rules

```bash
sudo nano /etc/audit/rules.d/database-monitoring.rules
```

```bash
# 🗄️ Database Security Monitoring Rules

# 🐬 Monitor MySQL configuration and data
-w /etc/mysql/         -p wa -k mysql_config
-w /var/lib/mysql/     -p wa -k mysql_data
-w /var/log/mysql/     -p wa -k mysql_logs

# 🐘 Monitor PostgreSQL configuration and data
-w /etc/postgresql/    -p wa -k postgresql_config
-w /var/lib/postgresql/-p wa -k postgresql_data
-w /var/log/postgresql/-p wa -k postgresql_logs
```

---

### ⚙️ Subtask 3.2 — Implement Process and System Call Monitoring

#### 🪜 Step 1: Create system call monitoring rules

```bash
sudo nano /etc/audit/rules.d/syscall-monitoring.rules
```

```bash
# ⚙️ System Call Monitoring Rules

# 🗑️ Monitor file deletion attempts
-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -k file_deletion
-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -k file_deletion

# 🔒 Monitor file permission changes
-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -k permission_changes
-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -k permission_changes

# 👤 Monitor file ownership changes
-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -k ownership_changes
-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -k ownership_changes

# ▶️ Monitor process execution
-a always,exit -F arch=b64 -S execve -k process_execution
-a always,exit -F arch=b32 -S execve -k process_execution

# 🌐 Monitor network connections
-a always,exit -F arch=b64 -S socket -S connect -k network_connections
-a always,exit -F arch=b32 -S socket -S connect -k network_connections
```

#### 🪜 Step 2: Create privileged operations monitoring rules

```bash
sudo nano /etc/audit/rules.d/privileged-operations.rules
```

```bash
# 🔑 Privileged Operations Monitoring Rules

# 🔐 Monitor sudo usage
-w /usr/bin/sudo -p x -k sudo_usage

# 🔀 Monitor su usage
-w /bin/su -p x -k su_usage

# 👤 Monitor passwd command usage
-w /usr/bin/passwd -p x -k passwd_usage

# 💾 Monitor mount operations
-a always,exit -F arch=b64 -S mount -k mount_operations
-a always,exit -F arch=b32 -S mount -k mount_operations

# 🧩 Monitor kernel module loading
-w /sbin/insmod  -p x -k module_loading
-w /sbin/rmmod   -p x -k module_loading
-w /sbin/modprobe -p x -k module_loading

# ⏱️ Monitor system time changes
-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time_changes
-a always,exit -F arch=b32 -S adjtimex -S settimeofday -k time_changes
```

---

### 🧪 Subtask 3.3 — Test and Validate Custom Rules

#### 🪜 Step 1: Load all custom rules and verify

```bash
# 🔄 Load all audit rules
sudo augenrules --load

# 🔁 Restart auditd service
sudo service auditd restart

# 📋 Display all loaded rules
sudo auditctl -l

# 🔢 Count total rules
echo "✅ Total audit rules loaded: $(sudo auditctl -l | wc -l)"
```

#### 🪜 Step 2: Test the custom rules with sample activities

```bash
# 🗑️ Test file deletion monitoring
touch /tmp/test_delete_file.txt
rm /tmp/test_delete_file.txt

# 🔒 Test permission changes
touch /tmp/test_chmod_file.txt
chmod 755 /tmp/test_chmod_file.txt
rm /tmp/test_chmod_file.txt

# 👤 Test ownership changes
touch /tmp/test_chown_file.txt
sudo chown root:root /tmp/test_chown_file.txt
sudo rm /tmp/test_chown_file.txt

# 🔐 Test sudo usage
sudo whoami

# ▶️ Test process execution
/bin/ls /tmp
```

#### 🪜 Step 3: Verify that events are being captured

```bash
# 🗑️ Check for file deletion events
sudo ausearch -k file_deletion -ts recent

# 🔒 Check for permission change events
sudo ausearch -k permission_changes -ts recent

# 👤 Check for ownership change events
sudo ausearch -k ownership_changes -ts recent

# 🔐 Check for sudo usage events
sudo ausearch -k sudo_usage -ts recent

# ▶️ Check for process execution events
sudo ausearch -k process_execution -ts recent | head -20
```

---

### 🤖 Subtask 3.4 — Create Automated Rule Management Script

#### 🪜 Step 1: Create the rule management script

```bash
nano audit_rule_manager.sh
```

#### 🪜 Step 2: Add the following script content

```bash
#!/bin/bash

# 🤖 Audit Rule Management Script

RULES_DIR="/etc/audit/rules.d"
BACKUP_DIR="/etc/audit/backup"

show_menu() {
    echo "=== 🛡️ Audit Rule Manager ==="
    echo "1️⃣  List all active rules"
    echo "2️⃣  Backup current rules"
    echo "3️⃣  Load rules from file"
    echo "4️⃣  Test rule syntax"
    echo "5️⃣  Generate rule statistics"
    echo "6️⃣  Search for specific rule"
    echo "7️⃣  Exit"
    echo "=============================="
}

list_rules() {
    echo "📋 Active Audit Rules:"
    echo "======================"
    sudo auditctl -l | nl
    echo ""
    echo "🔢 Total rules: $(sudo auditctl -l | wc -l)"
}

backup_rules() {
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    sudo mkdir -p $BACKUP_DIR
    sudo cp -r $RULES_DIR/* $BACKUP_DIR/backup_$TIMESTAMP/
    echo "💾 Rules backed up to: $BACKUP_DIR/backup_$TIMESTAMP/"
}

load_rules() {
    echo "🔄 Loading audit rules..."
    sudo augenrules --load
    sudo service auditd restart
    echo "✅ Rules loaded successfully!"
}

test_syntax() {
    echo "🧪 Testing audit rule syntax..."
    sudo augenrules --check
}

generate_stats() {
    echo "📊 Audit Rule Statistics:"
    echo "========================="
    echo "📁 Total rule files   : $(ls $RULES_DIR/*.rules 2>/dev/null | wc -l)"
    echo "📋 Total active rules : $(sudo auditctl -l | wc -l)"
    echo "👁️  Watch rules        : $(sudo auditctl -l | grep -c '^-w')"
    echo "⚙️  System call rules  : $(sudo auditctl -l | grep -c '^-a')"
    echo ""
    echo "🏷️  Rule categories:"
    sudo auditctl -l | grep -o '\-k [^ ]*' | sort | uniq -c | sort -nr
}

search_rules() {
    read -p "🔍 Enter search term: " search_term
    echo "Results for: $search_term"
    echo "=========================="
    sudo auditctl -l | grep -i "$search_term" | nl
}

while true; do
    show_menu
    read -p "Select an option (1-7): " choice
    case $choice in
        1) list_rules ;;
        2) backup_rules ;;
        3) load_rules ;;
        4) test_syntax ;;
        5) generate_stats ;;
        6) search_rules ;;
        7) echo "👋 Exiting..."; exit 0 ;;
        *) echo "⚠️ Invalid option. Please try again." ;;
    esac
    echo ""
    read -p "Press Enter to continue..."
    clear
done
```

#### 🪜 Step 3: Make the script executable and run it

```bash
chmod +x audit_rule_manager.sh
./audit_rule_manager.sh
```

---

## 🛠️ Troubleshooting Common Issues

### 🔴 Issue 1: Auditd Service Won't Start

```bash
# 🔍 Check service status for detailed error messages
sudo systemctl status auditd -l

# 🧪 Check audit configuration syntax
sudo auditctl -R /etc/audit/rules.d/audit.rules

# 💾 Check disk space (auditd requires adequate space)
df -h /var/log/audit/

# 🔁 Reset audit rules if corrupted
sudo auditctl -D
sudo augenrules --load
```

---

### 🔴 Issue 2: Too Many Audit Events (Performance Impact)

```bash
# 📊 Check current audit rate
sudo auditctl -s

# 🔽 Reduce audit rate temporarily
sudo auditctl -r 100

# 📋 Review and optimize noisy rules
sudo auditctl -l | grep -v "necessary_rules"
```

---

### 🔴 Issue 3: Missing Audit Events

```bash
# ✅ Verify rules are loaded correctly
sudo auditctl -l | grep "expected_rule"

# ⚙️ Check if audit daemon is running
sudo systemctl status auditd

# 🔒 Verify log file permissions
ls -la /var/log/audit/
```

---

## ⚡ Performance Optimization Tips

### 💡 Tip 1: Optimize Rule Efficiency

```bash
# ✅ Use specific paths instead of wildcards
# GOOD:  -w /etc/passwd -p wa -k passwd_changes
# AVOID: -w /etc/* -p wa -k etc_changes

# ✅ Group related rules under common keys
# Reduces overhead and simplifies log searches
```

### 💡 Tip 2: Manage Log Rotation

```bash
# ⚙️ Configure log rotation in auditd.conf
sudo nano /etc/audit/auditd.conf

# 🔧 Key settings to adjust:
# max_log_file = 50          → max size per log file (MB)
# num_logs = 10              → number of rotated logs to keep
# max_log_file_action = rotate
```

### 💡 Tip 3: Monitor System Resources

```bash
# 📊 Create performance monitoring script
nano audit_performance_monitor.sh
```

```bash
#!/bin/bash

echo "=== 📊 Audit Performance Monitor ==="

echo "⚙️  Audit daemon status:"
sudo auditctl -s

echo ""
echo "💾 Disk usage for audit logs:"
du -sh /var/log/audit/

echo ""
echo "📈 Current audit rate:"
sudo auditctl -s | grep rate

echo ""
echo "🧠 Memory usage by auditd:"
ps aux | grep auditd | grep -v grep
```

---

## ✅ Expected Outcomes

After completing this lab, you should have achieved:

| # | Achievement |
|---|---|
| 🎯 1 | Installed and configured auditd with proper service management |
| 🎯 2 | Created comprehensive monitoring rules for sensitive system files |
| 🎯 3 | Developed log analysis skills using `ausearch` and `aureport` |
| 🎯 4 | Built specialized rules for web servers, databases, and system calls |
| 🎯 5 | Automated audit management with reusable shell scripts |
| 🎯 6 | Optimized auditd performance for production environments |

---

## 💡 Why This Matters

| 🛠️ Use Case | Description |
|---|---|
| 📋 Compliance | Meets regulatory standards — PCI DSS, HIPAA, SOX |
| 🚨 Incident Response | Provides detailed forensic information during security incidents |
| 🔍 Threat Detection | Identifies unauthorized access attempts and suspicious activities |
| 🛡️ System Integrity | Monitors changes to critical system files and configurations |
| 👤 User Accountability | Tracks user actions for security and compliance purposes |

---

## 🏁 Conclusion

In this comprehensive lab, you successfully built a full security auditing pipeline:

| ✅ Achievement | Impact |
|---|---|
| ⚙️ Auditd Setup | Configured the audit daemon with a production-ready ruleset |
| 🛡️ Custom Rules | Monitored files, directories, system calls, and privileged ops |
| 🔍 Log Analysis | Used `ausearch` and `aureport` for forensic-level investigation |
| 🌐 App Monitoring | Built rules for web servers, databases, and kernel modules |
| 🤖 Automation | Created scripts for analysis, reporting, and rule management |

> ⚡ **Security auditing with auditd is crucial** for enterprise security monitoring, compliance auditing, forensic investigation support, proactive threat hunting, and Linux system administration best practices.

---

<div align="center">

![Auditd](https://img.shields.io/badge/Auditd-Security_Auditing-DC143C?style=for-the-badge&logo=shield&logoColor=white)
![Forensics](https://img.shields.io/badge/Forensics-Incident_Response-FF6600?style=for-the-badge&logo=search&logoColor=white)
![Compliance](https://img.shields.io/badge/Compliance-PCI_HIPAA_SOX-8B0000?style=for-the-badge&logo=checkmark&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-System_Admin-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Open Source](https://img.shields.io/badge/Open_Source-❤️-red?style=for-the-badge)

*Audit Everything. Trust Nothing. Verify Always. 🔍*

</div>
