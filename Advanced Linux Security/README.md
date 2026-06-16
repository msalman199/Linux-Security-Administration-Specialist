# 🛡️ Advanced Linux Security

<div align="center">

# 🚀 Enterprise Linux Security Hardening 

![Linux](https://img.shields.io/badge/Linux-Security-E95420?style=for-the-badge\&logo=linux)
![iptables](https://img.shields.io/badge/iptables-Firewall-red?style=for-the-badge)
![nftables](https://img.shields.io/badge/nftables-Modern_Firewall-blue?style=for-the-badge)
![SELinux](https://img.shields.io/badge/SELinux-Mandatory_Access_Control-success?style=for-the-badge)
![AppArmor](https://img.shields.io/badge/AppArmor-Application_Security-orange?style=for-the-badge)
![Nmap](https://img.shields.io/badge/Nmap-Vulnerability_Assessment-purple?style=for-the-badge)
![DevSecOps](https://img.shields.io/badge/DevSecOps-Security_Operations-black?style=for-the-badge)

### 🔐 Master Network Security, Mandatory Access Controls & Vulnerability Assessment

</div>

---

# 📖 Overview

Linux security requires a defense-in-depth approach that combines network protection, mandatory access controls, vulnerability assessments, and continuous monitoring.

In this lab, you will learn how to:

✅ Configure iptables firewall policies

✅ Deploy nftables for modern packet filtering

✅ Implement SELinux security policies

✅ Configure AppArmor profiles

✅ Perform vulnerability assessments

✅ Analyze security logs

✅ Conduct network security scanning

✅ Build comprehensive security monitoring solutions

---

# 🎯 Objectives

By the end of this lab, students will be able to:

* 🛡️ Configure and manage iptables and nftables
* 🔐 Implement SELinux and AppArmor policies
* 🔍 Perform Linux vulnerability assessments
* 🌐 Apply network hardening techniques
* 📊 Analyze security logs and events
* 🚨 Detect and investigate potential threats
* ⚙️ Create automated security assessment tools
* 🏢 Understand enterprise Linux security frameworks

---

# 📚 Prerequisites

Before starting this lab, students should have:

* 🐧 Basic Linux command-line skills
* 👤 Knowledge of users and permissions
* 🌐 Understanding of networking concepts
* 🔒 Familiarity with security principles
* ✍️ Experience using vim or nano
* ⚡ Root or sudo access

---

# ☁️ Lab Environment

## 🚀 Ready-to-Use Cloud Machines

Al Nafi provides pre-configured Linux cloud machines for this lab.

Simply click:

**▶️ Start Lab**

to access your dedicated environment.

No VM setup or infrastructure deployment is required.

---

## 🖥️ Environment Includes

| Component        | Description              |
| ---------------- | ------------------------ |
| Operating System | Ubuntu / Debian / CentOS |
| Firewall Tools   | iptables & nftables      |
| MAC Frameworks   | SELinux & AppArmor       |
| Assessment Tools | Nmap, Netcat             |
| Privileges       | Root / Sudo Access       |

---

# 🧩 Task 1 — Network Security with iptables and nftables

---

## 🔹 Subtask 1.1 Understanding Current Network Configuration

### View Network Interfaces

```bash
ip addr show
```

### View Active Connections

```bash
ss -tuln
```

### Check Existing Firewall Rules

```bash
sudo iptables -L -v -n
```

### View Running Services

```bash
systemctl list-units --type=service --state=running
```

---

## 🔹 Subtask 1.2 Configure iptables for Basic Security

### Create Firewall Script

```bash
sudo nano /etc/iptables-security.sh
```

### Add Configuration

```bash
#!/bin/bash

iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT

iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

iptables -A INPUT -p tcp --dport 22 -m recent --name ssh_attack --set
iptables -A INPUT -p tcp --dport 22 -m recent --name ssh_attack --rcheck --seconds 60 --hitcount 4 -j DROP

iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP

iptables -A INPUT -j LOG --log-prefix "IPTABLES-DROPPED: " --log-level 4
iptables -A INPUT -j DROP

echo "iptables rules configured successfully"
```

### Make Executable

```bash
sudo chmod +x /etc/iptables-security.sh
```

### Apply Rules

```bash
sudo /etc/iptables-security.sh
```

### Verify Rules

```bash
sudo iptables -L -v -n
```

---

## 🔹 Subtask 1.3 Persist iptables Rules

### Install Persistence Package

```bash
sudo apt update

sudo apt install -y iptables-persistent
```

### Save Rules

```bash
sudo iptables-save > /etc/iptables/rules.v4
```

### CentOS/RHEL Alternative

```bash
sudo service iptables save
```

---

## 🔹 Subtask 1.4 Configure nftables

### Install nftables

```bash
sudo apt install -y nftables
```

### Create Configuration

```bash
sudo nano /etc/nftables-security.conf
```

### Add Configuration

```bash
#!/usr/sbin/nft -f

flush ruleset

define SSH_PORT = 22
define HTTP_PORT = 80
define HTTPS_PORT = 443

table inet security_table {

 chain input {
  type filter hook input priority 0;
  policy drop;

  iif lo accept

  ct state established,related accept

  tcp dport $SSH_PORT ct state new limit rate 4/minute accept

  tcp dport { $HTTP_PORT, $HTTPS_PORT } accept

  icmp type echo-request limit rate 1/second accept

  log prefix "nftables-dropped: " drop
 }

 chain forward {
  type filter hook forward priority 0;
  policy drop;
 }

 chain output {
  type filter hook output priority 0;
  policy accept;
 }
}
```

### Load Configuration

```bash
sudo nft -f /etc/nftables-security.conf
```

### View Rules

```bash
sudo nft list ruleset
```

### Enable Service

```bash
sudo systemctl enable nftables

sudo systemctl start nftables
```

---

# 🧩 Task 2 — Advanced Security with SELinux and AppArmor

---

## 🔹 Subtask 2.1 Working with SELinux

### Check Status

```bash
sestatus
```

### Install SELinux Utilities

```bash
sudo apt install -y selinux-utils selinux-basics
```

### Check Mode

```bash
getenforce
```

### View Contexts

```bash
ls -Z /etc/passwd

ps -eZ | head -10
```

---

### Create Custom Policy Directory

```bash
mkdir ~/selinux-policy

cd ~/selinux-policy
```

### Create Policy

```bash
nano myapp.te
```

### Policy Content

```policy
policy_module(myapp, 1.0)

type myapp_t;
type myapp_exec_t;

domain_type(myapp_t)
domain_entry_file(myapp_t, myapp_exec_t)

allow myapp_t myapp_exec_t:file { read execute };

allow myapp_t self:process { fork signal };

allow myapp_t self:fifo_file rw_fifo_file_perms;

allow myapp_t self:tcp_socket create_stream_socket_perms;

allow myapp_t self:udp_socket create_socket_perms;
```

### Compile Policy

```bash
make -f /usr/share/selinux/devel/Makefile myapp.pp
```

### Install Policy

```bash
sudo semodule -i myapp.pp
```

### Verify

```bash
semodule -l | grep myapp
```

---

## 🔹 Subtask 2.2 Configure AppArmor

### Check Status

```bash
sudo apparmor_status
```

### Install Utilities

```bash
sudo apt install -y apparmor-utils
```

### View Profiles

```bash
sudo aa-status
```

### List Profiles

```bash
ls /etc/apparmor.d/
```

---

### Create Test Application

```bash
sudo nano /usr/local/bin/testapp
```

```bash
#!/bin/bash

echo "Test application running"

echo "Current user: $(whoami)"

echo "Current directory: $(pwd)"

ls /etc/ | head -5
```

### Make Executable

```bash
sudo chmod +x /usr/local/bin/testapp
```

### Generate Profile

```bash
sudo aa-genprof /usr/local/bin/testapp
```

### Create Profile

```bash
sudo nano /etc/apparmor.d/usr.local.bin.testapp
```

```text
#include <tunables/global>

/usr/local/bin/testapp {

#include <abstractions/base>
#include <abstractions/bash>

/usr/local/bin/testapp r,
/bin/bash ix,
/bin/dash ix,

/etc/ r,
/etc/** r,

/proc/version r,

/usr/bin/whoami ix,
/usr/bin/ls ix,
/bin/pwd ix,
/usr/bin/head ix,

deny /etc/passwd w,
deny /etc/shadow rw,
deny /root/** rw,
}
```

### Load Profile

```bash
sudo apparmor_parser -r /etc/apparmor.d/usr.local.bin.testapp
```

### Verify

```bash
sudo aa-status | grep testapp
```

### Test Application

```bash
/usr/local/bin/testapp
```

---

## 🔹 Subtask 2.3 Security Context Manager

### Create Script

```bash
sudo nano /usr/local/bin/security-context-manager.sh
```

### Add Script

```bash
#!/bin/bash

echo "=== Security Context Manager ==="

check_selinux() {
 sestatus
 echo
 ls -Z /var/log/ | head -5
}

check_apparmor() {
 sudo aa-status | head -10
}

show_process_contexts() {
 ps -eZ | head -10
}

check_selinux
check_apparmor
show_process_contexts

echo "Security context check completed"
```

### Run Script

```bash
sudo chmod +x /usr/local/bin/security-context-manager.sh

sudo /usr/local/bin/security-context-manager.sh
```

---

# 🧩 Task 3 — Vulnerability Assessment

---

## 🔹 Subtask 3.1 System Information Gathering

### Create Assessment Script

```bash
nano ~/vulnerability-assessment.sh
```

### Features

✅ System Information Collection

✅ Network Configuration Analysis

✅ User Enumeration

✅ Critical File Permission Review

✅ Service Enumeration

✅ Firewall Status Verification

### Execute

```bash
chmod +x ~/vulnerability-assessment.sh

./vulnerability-assessment.sh
```

---

## 🔹 Subtask 3.2 Network Security Scanning

### Install Tools

```bash
sudo apt update

sudo apt install -y nmap netcat-openbsd
```

### Create Scan Script

```bash
nano ~/network-security-scan.sh
```

### Scan Features

✅ TCP Port Scanning

✅ Service Detection

✅ Vulnerability Scanning

✅ Common Port Testing

✅ Network Exposure Analysis

### Execute

```bash
chmod +x ~/network-security-scan.sh

./network-security-scan.sh
```

---

## 🔹 Subtask 3.3 Security Log Analysis

### Create Analysis Script

```bash
nano ~/security-log-analysis.sh
```

### Analysis Features

✅ Failed Authentication Detection

✅ Sudo Activity Monitoring

✅ System Error Analysis

✅ Firewall Event Review

✅ Network Activity Analysis

✅ Process Investigation

### Run Script

```bash
chmod +x ~/security-log-analysis.sh

./security-log-analysis.sh
```

---

## 🔹 Subtask 3.4 Comprehensive Security Assessment

### Create Master Assessment Script

```bash
nano ~/comprehensive-security-assessment.sh
```

### Master Assessment Features

✅ Vulnerability Assessment

✅ Network Security Scan

✅ Log Analysis

✅ Security Recommendations

✅ Report Consolidation

### Execute

```bash
chmod +x ~/comprehensive-security-assessment.sh

./comprehensive-security-assessment.sh
```

---

# 🧪 Verification and Testing

---

## 🔹 Testing Network Security

### Test SSH

```bash
ssh localhost -p 22
```

### Test Web Service

```bash
curl -I http://localhost
```

### Test Blocked Port

```bash
nc -zv localhost 21
```

---

## 🔹 Testing Security Policies

### Execute Application

```bash
/usr/local/bin/testapp
```

### Attempt Restricted Action

```bash
echo "test" > /etc/test-file
```

---

## 🔹 Monitoring Security Events

### Authentication Monitoring

```bash
sudo tail -f /var/log/auth.log
```

### Security Event Monitoring

```bash
sudo tail -f /var/log/syslog | grep -E "(DROPPED|DENIED|FAILED)"
```

### Firewall Monitoring

```bash
sudo journalctl -f -u iptables
```

---

# 🛠️ Troubleshooting Common Issues

---

## ❌ iptables Issues

### Allow SSH Immediately

```bash
sudo iptables -I INPUT 1 -p tcp --dport 22 -j ACCEPT
```

### Emergency Reset

```bash
sudo iptables -F

sudo iptables -P INPUT ACCEPT

sudo iptables -P FORWARD ACCEPT

sudo iptables -P OUTPUT ACCEPT
```

---

## ❌ SELinux Issues

### View Denials

```bash
sudo ausearch -m AVC -ts recent
```

### Disable Temporarily

```bash
sudo setenforce 0
```

### Re-enable

```bash
sudo setenforce 1
```

---

## ❌ AppArmor Issues

### Complain Mode

```bash
sudo aa-complain /usr/local/bin/testapp
```

### Enforce Mode

```bash
sudo aa-enforce /usr/local/bin/testapp
```

### Disable Profile

```bash
sudo aa-disable /usr/local/bin/testapp
```

---

# 🎓 Skills Acquired

✅ Network Security Hardening

✅ iptables Administration

✅ nftables Management

✅ SELinux Policy Development

✅ AppArmor Profile Creation

✅ Vulnerability Assessment

✅ Security Log Analysis

✅ Threat Detection

✅ Security Monitoring

✅ Linux Security Operations

---

# 🌍 Real-World Applications

### 🔐 Enterprise Security

* Firewall management
* Access control enforcement
* Threat prevention

### ☁️ Cloud Security

* Secure cloud workloads
* Network segmentation
* Compliance controls

### ⚙️ DevSecOps

* Security automation
* Infrastructure hardening
* Continuous monitoring

### 🛡️ Security Operations

* Threat hunting
* Incident detection
* Security auditing

---

# 🏆 Conclusion

In this comprehensive lab, you successfully implemented advanced Linux security controls across multiple security layers.

You learned how to:

* 🛡️ Configure iptables and nftables firewalls
* 🔐 Implement SELinux and AppArmor policies
* 🔍 Perform vulnerability assessments
* 📊 Analyze security logs and events
* 🚨 Monitor and investigate threats
* ⚙️ Automate security assessments
* 🌐 Harden Linux network environments

These skills are essential for:

* Linux System Administration
* DevSecOps Engineering
* Security Operations Centers (SOC)
* Cloud Security Engineering
* Enterprise Infrastructure Protection

The techniques learned in this lab provide a strong defense-in-depth strategy that combines network filtering, mandatory access controls, vulnerability management, and continuous monitoring to secure Linux environments effectively.

---

<div align="center">

# 🎉 Lab Completed Successfully

### 🛡️ Advanced Linux Security

⭐ Secure • Monitor • Harden • Defend ⭐

</div>
