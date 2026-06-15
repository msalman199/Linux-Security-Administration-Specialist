# 🛡️ SELinux and AppArmor Basics 

![Linux Security](https://img.shields.io/badge/Linux-Security-blue)
![MAC Model](https://img.shields.io/badge/Access-Control-Mandatory%20(MAC)-red)
![SELinux](https://img.shields.io/badge/SELinux-Enforcing-green)
![AppArmor](https://img.shields.io/badge/AppArmor-Profile%20Based-purple)
![Level](https://img.shields.io/badge/Level-Intermediate-orange)

---

# 🧠 Overview

This lab introduces **Mandatory Access Control (MAC)** systems in Linux using:

* 🛡️ SELinux (Security-Enhanced Linux)  
* 🔒 AppArmor (Application Armor)

You will learn how to configure, enforce, troubleshoot, and analyze security policies that protect Linux systems at the kernel level.

> **Linux Security Foundation:** This environment is designed to establish foundational competencies in hardening OS layers against privilege escalation and unauthorized application execution.

---

# 🎯 Objectives

By the end of this lab, you will be able to:

* ✨ Understand Mandatory Access Control (MAC) systems  
* ✨ Configure and manage SELinux policies and modes  
* ✨ Use SELinux commands like `getenforce`, `setenforce`  
* ✨ Create and manage AppArmor security profiles  
* ✨ Analyze security logs and policy violations  
* ✨ Troubleshoot SELinux and AppArmor issues  
* ✨ Apply real-world security policies  

---

# 🧰 Prerequisites

Before starting, you should have:

* 🐧 Basic Linux command-line knowledge  
* 👥 User and file permission understanding  
* ✏️ Familiarity with editors (nano/vim)  
* ⚙️ Process and service management basics  
* 🌐 Understanding of system services & networking  

---

# ☁️ Lab Environment Setup

Your cloud machine includes:

* 🖥️ CentOS / RHEL / Ubuntu Linux  
* 🛡️ SELinux pre-installed tools  
* 🔐 AppArmor framework enabled  
* 📦 Common system services for testing  
* 👑 Admin privileges enabled  

---

# 🚀 Task 1: SELinux Configuration

### 🔍 Step 1: Check SELinux status

Run these commands to look at the immediate runtime state and internal configuration values:

```bash id="sel1"
getenforce
sestatus
cat /etc/selinux/config
```

### ⚙️ Step 2: Change SELinux mode

Toggle modes dynamically for troubleshooting purposes:

```bash
# Switch to Permissive (logs actions but does not block)
sudo setenforce 0   
getenforce

# Switch to Enforcing (actively denies and logs actions)
sudo setenforce 1   
getenforce
```

### 🧾 Step 3: Permanent configuration

To make configuration persistent across system reboots, modify the main policy file:

```bash
sudo nano /etc/selinux/config
```
Set the following line format:
```text
SELINUX=enforcing
```

### 🏷️ Step 4: SELinux Contexts

Inspect user, process, and object labels used to dictate security mappings:

```bash
ls -Z /etc/passwd
ps -eZ | grep sshd
id -Z
```

### 📁 Step 5: File context management

Create a test space to modify labels, reset context behaviors, and observe target states:

```bash
sudo mkdir /test-selinux
sudo touch /test-selinux/file.txt
ls -Z /test-selinux/

# Change type manually
sudo chcon -t httpd_exec_t /test-selinux/file.txt

# Restore default type based on system database mapping rules
sudo restorecon -R /test-selinux/
```

### 🔐 Step 6: SELinux Booleans

Booleans change feature behaviors at runtime without changing underlying security policies:

```bash
getsebool -a | head
getsebool httpd_can_network_connect
sudo setsebool -P httpd_can_network_connect on
```

---

# 🔒 Task 2: AppArmor Configuration

### 📦 Step 1: Install AppArmor

Install administrative framework utilities onto Debian/Ubuntu platforms:

```bash
sudo apt update
sudo apt install -y apparmor-utils apparmor-profiles
```

### 📊 Step 2: Check status

```bash
sudo apparmor_status
sudo aa-status
```

### 🎭 Step 3: Profile modes

AppArmor profiles isolate behaviors via specific application operational rules:
* 🔴 **Enforce** → Blocks unauthorized script or storage interactions.
* 🟡 **Complain** → Logs unauthorized attempts without obstructing applications.
* ⚪ **Unconfined** → No profile limitations apply.

```bash
sudo aa-complain /usr/bin/ping
sudo aa-enforce /usr/bin/ping
```

### 🧪 Step 4: Create test app

Construct an interactive platform script to establish profile target rules:

```bash
sudo nano /usr/local/bin/test-app.sh
```
Add the template code logic inside:
```bash
#!/bin/bash
echo "App running"
whoami
date
ls /home
```
Set the application binary file privileges:
```bash
sudo chmod +x /usr/local/bin/test-app.sh
```

### 🧠 Step 5: Generate profile

Use automated trace tracking utilities to generate baseline rules:

```bash
sudo aa-genprof /usr/local/bin/test-app.sh
```

### ✏️ Step 6: Edit profile

Open the resulting policy document file manually to alter granular read, write, or execute bounds:

```bash
sudo nano /etc/apparmor.d/usr.local.bin.test-app.sh
```
Example configuration matrix rules inside the block:
```text
/usr/local/bin/test-app.sh r,
/bin/bash ix,
/usr/bin/whoami ix,
/bin/date ix,
/bin/ls ix,
/home/ r,
```

### 🔄 Step 7: Reload profile

Apply all file edits explicitly back to the active operating engine:

```bash
sudo apparmor_parser -r /etc/apparmor.d/usr.local.bin.test-app.sh
```

---

# 🧪 Task 3: Testing & Troubleshooting

### 🔥 SELinux Troubleshooting

Examine denial records and use analyzer assistants to format system remediations:

```bash
sudo ausearch -m AVC -ts recent
sudo sealert -a /var/log/audit/audit.log
```
**Fix context issue permanently:**
```bash
sudo semanage fcontext -a -t httpd_exec_t "/custom-web(/.*)?"
sudo restorecon -R /custom-web/
```

### 🚨 AppArmor Troubleshooting

Track denied application runtime paths down using kernel ring buffers or localized logging streams:

```bash
sudo dmesg | grep -i apparmor
sudo journalctl | grep apparmor
```
**Interactively fix and resolve rules based on past denials:**
```bash
sudo aa-logprof
```

### ⚡ Performance Test

Compare execution speeds under active kernel enforcement environments versus standard runtime:

```bash
# Test with security active
sudo setenforce 1
time for i in {1..1000}; do ls /etc > /dev/null; done

# Test with security inactive
sudo setenforce 0
time for i in {1..1000}; do ls /etc > /dev/null; done
```

### 📊 Security Report Generation

Create an interactive script report layout containing the live evaluation data metrics:

```bash
nano ~/security-report.txt
```
Populate parameters inside the tracking document template:
```text
SELINUX Status: \$(getenforce)
AppArmor Status: \$(sudo aa-status | head -1)
OS: \$(cat /etc/os-release | grep PRETTY_NAME)
```
Compile the dynamic diagnostic evaluation directly out into a production log file:
```bash
bash -c "cat ~/security-report.txt" > ~/final-report.txt
cat ~/final-report.txt
```

---

## 🛠️ Troubleshooting Guide

### ❌ SELinux Issues
* **File blocked** → Fix configuration context patterns using `restorecon`.
* **Service failure** → Check and evaluate targeted operational toggles using `getsebool`.
* **Network blocked** → Adjust systemic network rules and boolean variables.

### ❌ AppArmor Issues
* **App crash** → Profile architecture is too restrictive. Adjust capabilities matrix.
* **No logs** → Enable system monitoring daemons such as `auditd`.
* **Profile errors** → Validate policy file structure layout syntax rules.

---

## 🔐 Best Practices

* ✔ Keep SELinux in enforcing mode whenever possible.
* ✔ Use targeted AppArmor profiles for high-exposure user applications.
* ✔ Monitor audit tracking files and diagnostic messages regularly.
* ✔ Avoid completely disabling system MAC engines across infrastructure components.
* ✔ Test runtime containment policies thoroughly inside testing tiers before staging production.
* ✔ Document and record all manual policy adjustments explicitly.

---

## 🏁 Conclusion

You have successfully learned:
* 🛡️ SELinux enforcement engines & execution context mapping.
* 🔐 AppArmor interactive baseline generation & lifecycle controls.
* 📊 Security constraint troubleshooting strategies.
* 🚨 Log message isolation analysis & system auditing mechanics.
* ⚙️ Real-world enterprise Linux MAC design application methods.

---

## 🎓 Outcome

You are now capable of securing Linux systems using:
1. **SELinux** (kernel-level, label-based MAC enforcement)
2. **AppArmor** (application-level, path-based confinement)

These skills are essential foundations for:
* 🧑‍💻 System Administrators
* 🔐 Cybersecurity Engineers
* ☁️ DevSecOps Professionals
* 🏢 Enterprise Linux Environments
