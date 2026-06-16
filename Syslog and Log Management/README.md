# 📋 Syslog and Log Management

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Ubuntu](https://img.shields.io/badge/Ubuntu_20.04_LTS-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![CentOS](https://img.shields.io/badge/CentOS_8-262577?style=for-the-badge&logo=centos&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Rsyslog](https://img.shields.io/badge/Rsyslog-Remote_Logging-0078D4?style=for-the-badge&logo=server&logoColor=white)
![Systemd](https://img.shields.io/badge/Systemd-Journald-000000?style=for-the-badge&logo=linux&logoColor=white)
![Logrotate](https://img.shields.io/badge/Logrotate-Log_Automation-4EAA25?style=for-the-badge&logo=files&logoColor=white)

> 🗂️ A comprehensive hands-on lab covering **rsyslog configuration**, **remote logging**, **journalctl management**, and **automated log rotation** — essential skills for Linux system administration and security monitoring.

---

## 🎓 Learning Objectives

By the end of this lab, students will be able to:

- ✅ Configure and manage system logs using **rsyslog**
- ✅ Set up **remote logging** capabilities with rsyslog
- ✅ Use **journalctl** to view, filter, and manage systemd journal logs
- ✅ Implement **automated log rotation** using logrotate
- ✅ Understand the relationship between **traditional syslog** and systemd journal
- ✅ Monitor system events and **troubleshoot issues** using log analysis

---

## 🔧 Prerequisites

| Requirement | Details |
|---|---|
| 💻 CLI Knowledge | Basic Linux command-line knowledge |
| 🔒 Permissions | Understanding of file permissions and ownership |
| 📝 Text Editor | Familiarity with `nano`, `vim`, or `gedit` |
| ⚙️ Systemd | Knowledge of systemd services |
| 🌐 Networking | Basic networking concepts (IP addresses, ports) |

---

## 🖥️ Lab Environment

> 🚀 **Al Nafi** provides ready-to-use Linux cloud machines. Click **Start Lab** to access your pre-configured environment — no VM setup or software installation required!

| Component | Details |
|---|---|
| 🖥️ OS | Ubuntu 20.04 LTS or CentOS 8 |
| ⚙️ Services | rsyslog, systemd-journald, logrotate |
| 🛠️ Tools | journalctl, logger, tail, grep |

---

## 📡 Task 1: Set Up Remote Logging with rsyslog

### 🔍 Subtask 1.1 — Verify rsyslog Installation and Status

#### 🪜 Step 1: Check if rsyslog is installed

```bash
dpkg -l | grep rsyslog
```

#### 🪜 Step 2: Check rsyslog service status

```bash
sudo systemctl status rsyslog
```

#### 🪜 Step 3: Start and enable rsyslog if not running

```bash
sudo systemctl start rsyslog
sudo systemctl enable rsyslog
```

---

### 🗂️ Subtask 1.2 — Understand rsyslog Configuration Structure

#### 🪜 Step 1: View the main configuration file

```bash
sudo cat /etc/rsyslog.conf
```

#### 🪜 Step 2: List additional configuration files

```bash
ls -la /etc/rsyslog.d/
```

#### 🪜 Step 3: Create a backup of the original configuration

```bash
sudo cp /etc/rsyslog.conf /etc/rsyslog.conf.backup
```

---

### ⚙️ Subtask 1.3 — Configure rsyslog as a Log Server

#### 🪜 Step 1: Edit the rsyslog configuration

```bash
sudo nano /etc/rsyslog.conf
```

#### 🪜 Step 2: Add or uncomment the following lines

```bash
# 📥 Enable UDP syslog reception
$ModLoad imudp
$UDPServerRun 514
$UDPServerAddress 127.0.0.1

# 📥 Enable TCP syslog reception
$ModLoad imtcp
$InputTCPServerRun 514
$InputTCPServerBindRuleset remote
```

#### 🪜 Step 3: Create a custom configuration for remote logging

```bash
sudo nano /etc/rsyslog.d/10-remote.conf
```

#### 🪜 Step 4: Add the following content

```bash
# 🌐 Remote logging configuration
$template RemoteHost,"/var/log/remote/%HOSTNAME%/%PROGRAMNAME%.log"

# 📝 Log remote messages to separate files
if $fromhost-ip != '127.0.0.1' then ?RemoteHost
& stop

# 📝 Create template for local simulation
$template LocalRemote,"/var/log/remote/localhost/%PROGRAMNAME%.log"
if $programname startswith 'remote-' then ?LocalRemote
& stop
```

---

### 📂 Subtask 1.4 — Create Remote Log Directory Structure

#### 🪜 Step 1: Create remote log directories

```bash
sudo mkdir -p /var/log/remote/localhost
```

#### 🪜 Step 2: Set proper ownership and permissions

```bash
sudo chown syslog:adm /var/log/remote/localhost
sudo chmod 755 /var/log/remote/localhost
```

#### 🪜 Step 3: Restart rsyslog to apply changes

```bash
sudo systemctl restart rsyslog
```

#### 🪜 Step 4: Verify rsyslog is listening on port 514

```bash
sudo netstat -tulpn | grep :514
```

---

### 🧪 Subtask 1.5 — Test Remote Logging Configuration

#### 🪜 Step 1: Send a test message using logger

```bash
logger -p local0.info "This is a test message from local system"
```

#### 🪜 Step 2: Send a simulated remote message

```bash
logger -t remote-testapp -p local1.warning "This is a simulated remote application warning"
```

#### 🪜 Step 3: Monitor syslog in real time and test

```bash
# 👁️ Watch syslog output
sudo tail -f /var/log/syslog &
sleep 2
logger -p user.notice "Testing user facility logging"
sleep 2
kill %1
```

#### 🪜 Step 4: Verify the remote log files

```bash
# 📂 Check remote log directory
sudo ls -la /var/log/remote/localhost/

# 📄 Read the remote test app log
sudo cat /var/log/remote/localhost/remote-testapp.log
```

---

## 🔎 Task 2: Use journalctl to View and Manage Logs

### 📖 Subtask 2.1 — Basic journalctl Commands

#### 🪜 Step 1: View all journal entries

```bash
journalctl
```

#### 🪜 Step 2: View journal entries in real-time

```bash
journalctl -f
```

#### 🪜 Step 3: View entries from the current boot

```bash
journalctl -b
```

#### 🪜 Step 4: View entries from the previous boot

```bash
journalctl -b -1
```

#### 🪜 Step 5: View the last 50 entries

```bash
journalctl -n 50
```

---

### 🎯 Subtask 2.2 — Filter Logs by Service and Priority

#### 🪜 Step 1: View logs for a specific service

```bash
journalctl -u rsyslog
```

#### 🪜 Step 2: View logs for systemd-journald

```bash
journalctl -u systemd-journald
```

#### 🪜 Step 3: Filter by priority — errors and above

```bash
journalctl -p err
```

#### 🪜 Step 4: Filter by priority — warnings and above

```bash
journalctl -p warning
```

#### 🪜 Step 5: View logs for a specific time range

```bash
journalctl --since "2024-01-01 00:00:00" --until "2024-12-31 23:59:59"
```

#### 🪜 Step 6: View logs from the last hour

```bash
journalctl --since "1 hour ago"
```

---

### 🔬 Subtask 2.3 — Advanced journalctl Filtering

#### 🪜 Step 1: View logs by Process ID

```bash
journalctl _PID=1
```

#### 🪜 Step 2: View logs by User ID

```bash
journalctl _UID=0
```

#### 🪜 Step 3: View kernel messages only

```bash
journalctl -k
```

#### 🪜 Step 4: View logs in verbose format

```bash
journalctl -o verbose | head -20
```

#### 🪜 Step 5: View logs in JSON format

```bash
journalctl -o json | head -5
```

#### 🪜 Step 6: Follow logs for multiple services simultaneously

```bash
journalctl -f -u rsyslog -u systemd-journald
```

---

### ✍️ Subtask 2.4 — Generate Test Log Entries

#### 🪜 Step 1: Generate messages at different priority levels

```bash
logger -p user.debug   "Debug message for testing"
logger -p user.info    "Info message for testing"
logger -p user.notice  "Notice message for testing"
logger -p user.warning "Warning message for testing"
logger -p user.err     "Error message for testing"
logger -p user.crit    "Critical message for testing"
```

#### 🪜 Step 2: Generate messages with different application tags

```bash
logger -t webapp   "Web application started successfully"
logger -t database "Database connection established"
logger -t security "Failed login attempt detected"
```

#### 🪜 Step 3: View the most recent messages

```bash
journalctl -n 20
```

#### 🪜 Step 4: Filter by specific tags

```bash
journalctl -t webapp
journalctl -t security
```

#### 🪜 Step 5: Search for specific content keywords

```bash
journalctl | grep -i "error"
journalctl | grep -i "failed"
```

---

### 💾 Subtask 2.5 — Journal Storage Management

#### 🪜 Step 1: Check journal disk usage

```bash
journalctl --disk-usage
```

#### 🪜 Step 2: View journal configuration

```bash
sudo cat /etc/systemd/journald.conf
```

#### 🪜 Step 3: Vacuum old journal files — keep last 2 days

```bash
sudo journalctl --vacuum-time=2d
```

#### 🪜 Step 4: Vacuum journal files by size — keep last 100 MB

```bash
sudo journalctl --vacuum-size=100M
```

#### 🪜 Step 5: Check disk usage after cleanup

```bash
journalctl --disk-usage
```

---

## 🔄 Task 3: Automate Log Rotation with logrotate

### 📖 Subtask 3.1 — Understand logrotate Configuration

#### 🪜 Step 1: View the main logrotate configuration

```bash
sudo cat /etc/logrotate.conf
```

#### 🪜 Step 2: List all logrotate configuration files

```bash
ls -la /etc/logrotate.d/
```

#### 🪜 Step 3: View rsyslog's logrotate configuration

```bash
sudo cat /etc/logrotate.d/rsyslog
```

---

### 📁 Subtask 3.2 — Create Custom Log Files for Testing

#### 🪜 Step 1: Create a test application log directory

```bash
sudo mkdir -p /var/log/testapp
```

#### 🪜 Step 2: Create test log files

```bash
sudo touch /var/log/testapp/application.log
sudo touch /var/log/testapp/error.log
sudo touch /var/log/testapp/access.log
```

#### 🪜 Step 3: Set proper ownership and permissions

```bash
sudo chown syslog:adm /var/log/testapp/*.log
sudo chmod 644 /var/log/testapp/*.log
```

#### 🪜 Step 4: Create a log entry generator script

```bash
cat << 'EOF' > /tmp/generate_logs.sh
#!/bin/bash
for i in {1..100}; do
    echo "$(date): Application log entry $i - Normal operation" \
        | sudo tee -a /var/log/testapp/application.log > /dev/null
    echo "$(date): Access log entry $i - User accessed resource" \
        | sudo tee -a /var/log/testapp/access.log > /dev/null
    if [ $((i % 10)) -eq 0 ]; then
        echo "$(date): Error log entry $((i/10)) - Minor error occurred" \
            | sudo tee -a /var/log/testapp/error.log > /dev/null
    fi
done
EOF

chmod +x /tmp/generate_logs.sh
/tmp/generate_logs.sh
```

---

### ⚙️ Subtask 3.3 — Create Custom logrotate Configuration

#### 🪜 Step 1: Create the logrotate config for the test app

```bash
sudo nano /etc/logrotate.d/testapp
```

#### 🪜 Step 2: Add the following configuration

```bash
/var/log/testapp/*.log {
    daily                          # 📅 Rotate daily
    rotate 7                       # 🔁 Keep 7 rotated copies
    compress                       # 🗜️ Compress rotated logs
    delaycompress                  # ⏳ Delay compression by one cycle
    missingok                      # ✅ No error if log file is missing
    notifempty                     # 🚫 Don't rotate empty files
    create 644 syslog adm          # 📄 Create new file with these perms
    postrotate
        /usr/lib/rsyslog/rsyslog-rotate
    endscript
}
```

---

### 🧪 Subtask 3.4 — Test logrotate Configuration

#### 🪜 Step 1: Test the configuration syntax (dry run)

```bash
sudo logrotate -d /etc/logrotate.d/testapp
```

#### 🪜 Step 2: Check current log file sizes before rotation

```bash
ls -lh /var/log/testapp/
```

#### 🪜 Step 3: Force log rotation for testing

```bash
sudo logrotate -f /etc/logrotate.d/testapp
```

#### 🪜 Step 4: Check the results after rotation

```bash
ls -lh /var/log/testapp/
```

---

### 🚀 Subtask 3.5 — Configure Advanced Log Rotation

#### 🪜 Step 1: Create the advanced logrotate configuration file

```bash
sudo nano /etc/logrotate.d/testapp-advanced
```

#### 🪜 Step 2: Add advanced configuration for all three log types

```bash
# 📦 Application log — rotate when it exceeds 1 MB
/var/log/testapp/application.log {
    size 1M
    rotate 5
    compress
    delaycompress
    missingok
    notifempty
    create 644 syslog adm
    copytruncate
}

# 🔴 Error log — rotate weekly, keep 3 months
/var/log/testapp/error.log {
    weekly
    rotate 12
    compress
    delaycompress
    missingok
    notifempty
    create 644 syslog adm
    mail admin@localhost
    mailfirst
}

# 🌐 Access log — rotate daily, keep 30 days
/var/log/testapp/access.log {
    daily
    rotate 30
    compress
    delaycompress
    missingok
    notifempty
    create 644 syslog adm
    sharedscripts
    postrotate
        echo "Access log rotated at $(date)" >> /var/log/testapp/rotation.log
    endscript
}
```

---

### 📊 Subtask 3.6 — Monitor and Verify Log Rotation

#### 🪜 Step 1: Create a rotation monitoring script

```bash
cat << 'EOF' > /tmp/monitor_rotation.sh
#!/bin/bash
echo "📂 === Log Rotation Status ==="
echo "Current log files:"
ls -lh /var/log/testapp/

echo -e "\n⚙️ === Logrotate Status ==="
sudo cat /var/lib/logrotate/status | grep testapp

echo -e "\n🕐 === Recent Rotation Activity ==="
if [ -f /var/log/testapp/rotation.log ]; then
    cat /var/log/testapp/rotation.log
fi
EOF

chmod +x /tmp/monitor_rotation.sh
/tmp/monitor_rotation.sh
```

#### 🪜 Step 2: Generate more log content and test advanced config

```bash
# 📝 Generate fresh log entries
/tmp/generate_logs.sh

# 🔄 Force advanced rotation
sudo logrotate -f /etc/logrotate.d/testapp-advanced

# 📊 Monitor the results
/tmp/monitor_rotation.sh
```

---

## 🔗 Integration and Verification

### 📊 Comprehensive System Log Analysis

#### 🪜 Step 1: Create a full system log analysis script

```bash
cat << 'EOF' > /tmp/log_analysis.sh
#!/bin/bash
echo "📊 === System Log Analysis ==="

echo "1️⃣  Rsyslog Status:"
sudo systemctl status rsyslog --no-pager

echo -e "\n2️⃣  Journal Disk Usage:"
journalctl --disk-usage

echo -e "\n3️⃣  Recent System Errors:"
journalctl -p err --since "1 hour ago" --no-pager

echo -e "\n4️⃣  Log File Sizes (Top 10):"
sudo du -sh /var/log/* 2>/dev/null | sort -hr | head -10

echo -e "\n5️⃣  Remote Log Status:"
if [ -d /var/log/remote ]; then
    sudo find /var/log/remote -type f -exec ls -lh {} \;
fi

echo -e "\n6️⃣  Logrotate Syntax Check:"
sudo logrotate -d /etc/logrotate.conf 2>&1 | grep -E "(error|warning)" \
    || echo "✅ No errors found"
EOF

chmod +x /tmp/log_analysis.sh
/tmp/log_analysis.sh
```

---

### ✅ Final Testing and Validation

#### 🪜 Step 1: Send final test log messages

```bash
logger -p local0.info "Final test: Local message"
logger -t remote-final -p local1.warning "Final test: Remote simulation"
```

#### 🪜 Step 2: Wait for logs to be written

```bash
sleep 2
```

#### 🪜 Step 3: Verify logs in syslog

```bash
echo "📄 Checking syslog:"
sudo tail -5 /var/log/syslog
```

#### 🪜 Step 4: Verify remote logs

```bash
echo "🌐 Checking remote logs:"
sudo tail -5 /var/log/remote/localhost/remote-final.log 2>/dev/null \
    || echo "⚠️ Remote log not found"
```

#### 🪜 Step 5: Verify journal entries

```bash
echo "📖 Checking journal:"
journalctl -n 5 --no-pager
```

#### 🪜 Step 6: Test log rotation one final time

```bash
echo "🔄 Testing log rotation:"
sudo logrotate -f /etc/logrotate.d/testapp
ls -la /var/log/testapp/

echo "✅ All tests completed successfully!"
```

---

## 🛠️ Troubleshooting Common Issues

### 🔴 Issue 1: rsyslog Not Receiving Remote Logs

```bash
# 🔍 Check if rsyslog is listening on port 514
sudo netstat -tulpn | grep :514

# 🔥 Verify firewall settings
sudo ufw status

# 🧪 Check rsyslog configuration syntax
sudo rsyslogd -N1
```

---

### 🔴 Issue 2: journalctl Showing No Entries

```bash
# ⚙️ Check systemd-journald status
sudo systemctl status systemd-journald

# 📂 Verify journal files exist
sudo ls -la /var/log/journal/

# 🔧 Check journal configuration
sudo cat /etc/systemd/journald.conf
```

---

### 🔴 Issue 3: logrotate Not Working

```bash
# 🧪 Check logrotate configuration syntax
sudo logrotate -d /etc/logrotate.conf

# 🔒 Verify file permissions
sudo ls -la /var/log/testapp/

# 📋 Check logrotate status file
sudo cat /var/lib/logrotate/status
```

---

## ✅ Expected Outcomes

After completing this lab, you should have achieved:

| # | Achievement |
|---|---|
| 🎯 1 | Configured rsyslog for local and remote logging |
| 🎯 2 | Mastered journalctl for viewing and filtering systemd journal logs |
| 🎯 3 | Implemented logrotate for automated log management and rotation |
| 🎯 4 | Integrated multiple logging systems into a comprehensive solution |
| 🎯 5 | Built reusable analysis and monitoring scripts |

---

## 💡 Why This Matters

| 🛠️ Use Case | Description |
|---|---|
| 👁️ System Monitoring | Enables proactive detection of issues before they escalate |
| 🛡️ Security Analysis | Centralized logging helps identify unauthorized access attempts |
| 📋 Compliance | Many regulatory frameworks require proper log retention |
| 🔧 Troubleshooting | Well-organized logs reduce time-to-resolution for system issues |
| 📈 Performance | Log analysis identifies bottlenecks and resource usage patterns |

---

## 🏁 Conclusion

In this comprehensive lab, you successfully built a full log management pipeline:

| ✅ Achievement | Impact |
|---|---|
| 📡 rsyslog Setup | Configured local and remote logging with custom templates |
| 🔎 journalctl Mastery | Filtered, searched, and managed systemd journal with precision |
| 🔄 logrotate Automation | Automated log rotation with compression and size-based policies |
| 🔗 System Integration | Combined all tools into a production-ready log management solution |

> ⚡ **The combination of rsyslog, systemd journal, and logrotate provides a robust foundation for enterprise-level log management** — offering the flexibility and reliability needed for production environments while remaining cost-effective.

---

<div align="center">

![Rsyslog](https://img.shields.io/badge/Rsyslog-Remote_Logging-0078D4?style=for-the-badge&logo=server&logoColor=white)
![Journald](https://img.shields.io/badge/Systemd-Journald-000000?style=for-the-badge&logo=linux&logoColor=white)
![Logrotate](https://img.shields.io/badge/Logrotate-Automation-4EAA25?style=for-the-badge&logo=files&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-System_Admin-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Open Source](https://img.shields.io/badge/Open_Source-❤️-red?style=for-the-badge)

*Log Everything. Lose Nothing. 🗂️*

</div>
