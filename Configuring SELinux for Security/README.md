# 🔐 Configuring SELinux for Security

<div align="center">

# 🚀 Linux Security Hardening with SELinux

![Linux](https://img.shields.io/badge/Linux-RHEL%20%7C%20CentOS-E95420?style=for-the-badge&logo=linux)
![SELinux](https://img.shields.io/badge/SELinux-Mandatory_Access_Control-red?style=for-the-badge)
![Security](https://img.shields.io/badge/Security-Hardening-blue?style=for-the-badge)
![Audit](https://img.shields.io/badge/Audit-Logging-success?style=for-the-badge)
![Policy](https://img.shields.io/badge/Policy-Management-orange?style=for-the-badge)
![DevSecOps](https://img.shields.io/badge/DevSecOps-Linux_Security-purple?style=for-the-badge)

### 🛡️ Master SELinux Policies, Mandatory Access Controls & Security Troubleshooting

</div>

---

# 📖 Overview

Security-Enhanced Linux (SELinux) provides Mandatory Access Control (MAC) for Linux systems. Unlike traditional file permissions, SELinux enforces security policies that restrict how users, processes, and services access system resources.

In this lab, you will learn how to:

✅ Understand SELinux fundamentals

✅ Configure security contexts

✅ Apply file access controls

✅ Analyze SELinux denials

✅ Use audit2allow for troubleshooting

✅ Create custom SELinux policies

✅ Manage SELinux booleans

✅ Secure Linux systems using MAC controls

---

# 🎯 Objectives

By the end of this lab, students will be able to:

- 🔐 Understand SELinux architecture and security contexts
- 📂 Configure file access controls using SELinux
- 🔍 Analyze SELinux audit logs
- 🚨 Troubleshoot denials using audit2allow
- 🛠️ Create custom SELinux policy modules
- ⚙️ Configure SELinux booleans and ports
- 📊 Monitor SELinux events and violations
- 🛡️ Implement enterprise-grade security controls

---

# 📚 Prerequisites

Before starting this lab, students should have:

- 🐧 Basic Linux command-line knowledge
- 📂 Understanding of Linux file permissions
- ✍️ Familiarity with nano/vim editors
- ⚙️ Basic system administration skills
- 🔐 Understanding of security fundamentals

---

# ☁️ Lab Environment

## 🚀 Ready-to-Use Cloud Machines

Al Nafi provides Linux-based cloud machines with SELinux pre-installed and configured.

Simply click:

**▶️ Start Lab**

to access your dedicated environment.

No additional installations are required.

---

## 🖥️ Environment Includes

| Component | Description |
|------------|-------------|
| OS | CentOS / RHEL |
| SELinux | Enabled |
| Tools | audit2allow, semanage, sealert |
| Access | Root Privileges |
| Logging | Auditd Enabled |

---

# 🧩 Task 1 — Configure SELinux Policies for File Access

---

## 🔹 Subtask 1.1 Verify SELinux Status and Mode

### Check SELinux Status

```bash
sestatus
```

### View Current Mode

```bash
getenforce
```

### View Configuration File

```bash
cat /etc/selinux/config
```

---

### 📖 Expected Modes

| Mode | Description |
|--------|------------|
| Enforcing | Active and Blocking |
| Permissive | Logging Only |
| Disabled | Turned Off |

---

## 🔹 Subtask 1.2 Understanding SELinux Contexts

### View SELinux Contexts

```bash
ls -Z /etc/passwd /etc/shadow /etc/hosts
```

### Check Directory Contexts

```bash
ls -dZ /var/www/html /home /tmp
```

### View Current User Context

```bash
id -Z
```

---

### 🧠 SELinux Context Components

| Component | Purpose |
|------------|----------|
| User | SELinux Identity |
| Role | User Capabilities |
| Type | Access Control |
| Level | MLS Security |

---

## 🔹 Subtask 1.3 Create Test Environment

### Create Directory Structure

```bash
mkdir -p /opt/webtest/{public,private,logs}
```

### Create Test Files

```bash
echo "Public content" > /opt/webtest/public/index.html

echo "Private data" > /opt/webtest/private/secret.txt

echo "Log entry" > /opt/webtest/logs/access.log
```

### Check Contexts

```bash
ls -lZ /opt/webtest/

ls -lZ /opt/webtest/public/

ls -lZ /opt/webtest/private/
```

---

## 🔹 Subtask 1.4 Configure File Contexts

### Configure Public Web Content

```bash
semanage fcontext -a -t httpd_exec_t "/opt/webtest/public(/.*)?"
```

### Configure Private Directory

```bash
semanage fcontext -a -t admin_home_t "/opt/webtest/private(/.*)?"
```

### Configure Log Directory

```bash
semanage fcontext -a -t httpd_log_t "/opt/webtest/logs(/.*)?"
```

### Apply Contexts

```bash
restorecon -Rv /opt/webtest/
```

### Verify

```bash
ls -lZ /opt/webtest/

ls -lZ /opt/webtest/public/

ls -lZ /opt/webtest/private/

ls -lZ /opt/webtest/logs/
```

---

## 🔹 Subtask 1.5 Test File Access Controls

### Install Apache

```bash
yum install -y httpd
```

### Start Apache

```bash
systemctl start httpd

systemctl enable httpd
```

### Create Symbolic Link

```bash
ln -s /opt/webtest/public /var/www/html/testsite
```

### Test Access

```bash
curl http://localhost/testsite/index.html
```

### View HTTPD Booleans

```bash
getsebool -a | grep httpd | head -10
```

---

# 🧩 Task 2 — Troubleshoot SELinux Denials Using audit2allow

---

## 🔹 Subtask 2.1 Generate SELinux Denials

### Create Test Script

```bash
cat > /tmp/test_script.sh << 'EOF'
#!/bin/bash
echo "Testing SELinux"
date
EOF
```

### Make Executable

```bash
chmod +x /tmp/test_script.sh
```

### Create CGI Directory

```bash
mkdir -p /var/www/cgi-bin

cp /tmp/test_script.sh /var/www/cgi-bin/
```

### Check Context

```bash
ls -lZ /var/www/cgi-bin/test_script.sh
```

---

## 🔹 Subtask 2.2 Monitor Audit Logs

### View Recent Denials

```bash
ausearch -m AVC -ts recent
```

### View Journal Logs

```bash
journalctl -t setroubleshoot --since="10 minutes ago"
```

### Analyze Logs

```bash
sealert -a /var/log/audit/audit.log
```

### Check SELinux Events

```bash
grep "SELinux" /var/log/messages | tail -20
```

---

## 🔹 Subtask 2.3 Generate Policies Using audit2allow

### Create Policy Rules

```bash
ausearch -m AVC -ts recent | audit2allow
```

### Create Policy Module

```bash
ausearch -m AVC -ts recent | audit2allow -M mypolicy
```

### View Policy

```bash
cat mypolicy.te
```

### View Generated Files

```bash
ls -l mypolicy.*
```

---

## 🔹 Subtask 2.4 Create Custom Application

### Create Script

```bash
cat > /opt/custom_app.sh << 'EOF'
#!/bin/bash

echo "Custom app starting..."

touch /var/log/custom_app.log

echo "$(date): Application started" >> /var/log/custom_app.log

echo "Custom app completed."
EOF
```

### Make Executable

```bash
chmod +x /opt/custom_app.sh
```

### Execute

```bash
/opt/custom_app.sh
```

### Check Denials

```bash
ausearch -m AVC -ts recent | tail -10
```

### Generate Policy

```bash
ausearch -m AVC -ts recent | audit2allow -M custom_app_policy
```

### Review Policy

```bash
cat custom_app_policy.te
```

---

## 🔹 Subtask 2.5 Install Custom Policy

### Install Module

```bash
semodule -i custom_app_policy.pp
```

### Verify Installation

```bash
semodule -l | grep custom
```

### Test Again

```bash
/opt/custom_app.sh
```

### Verify No Denials

```bash
ausearch -m AVC -ts recent | grep custom_app || echo "No denials found"
```

### Check Log

```bash
cat /var/log/custom_app.log
```

---

# 🧩 Task 3 — Create Custom SELinux Policies

---

## 🔹 Subtask 3.1 Create Application Structure

### Create Directories

```bash
mkdir -p /opt/myapp/{bin,config,data,logs}
```

### Create Application

```bash
nano /opt/myapp/bin/myapp
```

Paste:

```bash
#!/bin/bash

CONFIG_FILE="/opt/myapp/config/app.conf"
DATA_DIR="/opt/myapp/data"
LOG_FILE="/opt/myapp/logs/app.log"

echo "$(date): Starting MyApp" >> $LOG_FILE

if [ -f "$CONFIG_FILE" ]; then
 source "$CONFIG_FILE"
fi

ls "$DATA_DIR" >> $LOG_FILE

echo "$(date): MyApp completed" >> $LOG_FILE
```

### Make Executable

```bash
chmod +x /opt/myapp/bin/myapp
```

---

## 🔹 Subtask 3.2 Create Configuration

### Create Config File

```bash
cat > /opt/myapp/config/app.conf << 'EOF'
DEBUG=true
MAX_CONNECTIONS=100
TIMEOUT=30
EOF
```

### Create Sample Data

```bash
echo "Sample data file" > /opt/myapp/data/sample.txt
```

---

## 🔹 Subtask 3.3 Create SELinux Policy

### Create Policy Source

```bash
nano myapp_policy.te
```

### Policy Content

```policy
policy_module(myapp_policy, 1.0)

type myapp_exec_t;
type myapp_config_t;
type myapp_data_t;
type myapp_log_t;
type myapp_t;

files_type(myapp_config_t)
files_type(myapp_data_t)
files_type(myapp_log_t)

application_executable_file(myapp_exec_t)

application_domain(myapp_t, myapp_exec_t)

allow myapp_t myapp_config_t:file { read getattr open };

allow myapp_t myapp_data_t:file { read write create getattr open };

allow myapp_t myapp_data_t:dir { read search getattr };

allow myapp_t myapp_log_t:file { write create append getattr open };

allow myapp_t myapp_log_t:dir { write add_name };
```

---

## 🔹 Subtask 3.4 Create File Context Definitions

### Create Context File

```bash
nano myapp_policy.fc
```

### Add Contexts

```policy
/opt/myapp/bin/myapp -- gen_context(system_u:object_r:myapp_exec_t,s0)

/opt/myapp/config(/.*)? gen_context(system_u:object_r:myapp_config_t,s0)

/opt/myapp/data(/.*)? gen_context(system_u:object_r:myapp_data_t,s0)

/opt/myapp/logs(/.*)? gen_context(system_u:object_r:myapp_log_t,s0)
```

---

## 🔹 Subtask 3.5 Compile and Install Policy

### Compile

```bash
make -f /usr/share/selinux/devel/Makefile myapp_policy.pp
```

### Install

```bash
semodule -i myapp_policy.pp
```

### Verify

```bash
semodule -l | grep myapp
```

---

### Apply Contexts

```bash
semanage fcontext -a -f -- -t myapp_exec_t "/opt/myapp/bin/myapp"

semanage fcontext -a -t myapp_config_t "/opt/myapp/config(/.*)?"

semanage fcontext -a -t myapp_data_t "/opt/myapp/data(/.*)?"

semanage fcontext -a -t myapp_log_t "/opt/myapp/logs(/.*)?"
```

### Restore

```bash
restorecon -Rv /opt/myapp/
```

### Verify

```bash
ls -lZ /opt/myapp/bin/myapp

ls -lZ /opt/myapp/config/

ls -lZ /opt/myapp/data/

ls -lZ /opt/myapp/logs/
```

---

## 🔹 Subtask 3.6 Test Policy

### Execute Application

```bash
/opt/myapp/bin/myapp
```

### Check Denials

```bash
ausearch -m AVC -ts recent | grep myapp || echo "No denials found"
```

### View Log

```bash
cat /opt/myapp/logs/app.log
```

### Test Data Operations

```bash
echo "New data entry" > /opt/myapp/data/newfile.txt
```

### Run Multiple Times

```bash
for i in {1..3}
do
 echo "Run $i"
 /opt/myapp/bin/myapp
 sleep 1
done
```

---

# 🧩 Advanced SELinux Management

---

## 🔹 Managing SELinux Booleans

### List Booleans

```bash
getsebool -a | head -20
```

### Check Boolean

```bash
getsebool httpd_can_network_connect
```

### Temporary Change

```bash
setsebool httpd_can_network_connect on
```

### Permanent Change

```bash
setsebool -P httpd_can_network_connect on
```

### View Descriptions

```bash
semanage boolean -l | grep httpd | head -5
```

---

## 🔹 SELinux Port Management

### View Ports

```bash
semanage port -l | grep http
```

### Add Custom Port

```bash
semanage port -a -t http_port_t -p tcp 8080
```

### Verify

```bash
semanage port -l | grep 8080
```

---

# 🛠️ Troubleshooting

---

## ❌ Context Restoration Issues

### Verify Definitions

```bash
semanage fcontext -l | grep myapp
```

### Force Restore

```bash
restorecon -RvF /opt/myapp/
```

---

## ❌ Policy Module Conflicts

### View Modules

```bash
semodule -l | grep -E "(myapp|custom)"
```

### Remove Module

```bash
semodule -r myapp_policy
```

### Reinstall

```bash
semodule -v -i myapp_policy.pp
```

---

## ❌ Audit Analysis

### View Denials

```bash
ausearch -m AVC -ts today | grep denied
```

### Human-Readable Analysis

```bash
sealert -a /var/log/audit/audit.log | tail -50
```

### Verify Service

```bash
systemctl status setroubleshoot
```

---

# 🧪 Lab Verification

## 🔍 Verification Script

```bash
echo "=== SELinux Status Verification ==="

sestatus

echo ""

echo "=== Custom Policy Verification ==="

semodule -l | grep -E "(myapp|custom)"

echo ""

echo "=== File Context Verification ==="

ls -lZ /opt/myapp/bin/myapp

ls -lZ /opt/webtest/public/index.html

echo ""

echo "=== Application Test ==="

/opt/myapp/bin/myapp

echo "Exit Code: $?"

echo ""

echo "=== Denial Check ==="

ausearch -m AVC -ts recent | grep -E "(myapp|webtest)" || echo "No recent denials found"

echo ""

echo "=== Log Verification ==="

tail -3 /opt/myapp/logs/app.log
```

---

# 🎓 Skills Acquired

✅ SELinux Administration

✅ Security Context Management

✅ Mandatory Access Controls

✅ Custom Policy Development

✅ SELinux Troubleshooting

✅ audit2allow Usage

✅ SELinux Boolean Management

✅ SELinux Port Configuration

✅ Security Auditing

✅ Enterprise Linux Hardening

---

# 🌍 Real-World Applications

### 🔐 Enterprise Security

- Mandatory access controls
- Application confinement
- Sensitive data protection

### ☁️ Cloud Infrastructure

- Secure workloads
- Compliance enforcement
- Service isolation

### ⚙️ DevSecOps

- Security automation
- Policy-driven protection
- Infrastructure hardening

### 🛡️ Security Operations

- Incident prevention
- Threat containment
- Access control enforcement

---

# 🏆 Conclusion

In this comprehensive lab, you successfully implemented and managed SELinux security controls across a Linux environment.

You learned how to:

- 🔐 Configure SELinux contexts
- 📂 Control file access securely
- 🚨 Troubleshoot denials with audit2allow
- 🛠️ Create custom policies
- ⚙️ Manage SELinux booleans and ports
- 📊 Analyze audit logs
- 🛡️ Implement enterprise-grade mandatory access controls

These skills are essential for:

- Linux Security Administration
- DevSecOps Engineering
- Compliance & Governance
- Cloud Security
- Enterprise Infrastructure Protection

The policy creation, troubleshooting, and auditing techniques developed during this lab provide a strong foundation for securing Linux systems in production environments.

---

<div align="center">

# 🎉 Lab Completed Successfully

### 🔐 Configuring SELinux for Security

⭐ Protect • Audit • Enforce • Secure ⭐

</div>
