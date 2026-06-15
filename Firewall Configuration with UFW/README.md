# 🔥 Firewall Configuration with UFW 


---

## 🧠 Overview

This lab focuses on **Linux firewall security using UFW (Uncomplicated Firewall)**. You will learn how to control network traffic, secure services, create firewall policies, and monitor logs for suspicious activity.

You will gain hands-on experience with real-world firewall administration used in production Linux servers and cloud environments.

---

## 🎯 Objectives

By the end of this lab, students will be able to:

* 🔥 Understand firewall fundamentals and UFW architecture
* 🔥 Install and enable UFW on Linux systems
* 🔥 Configure allow/deny rules for services and ports
* 🔥 Create advanced IP-based and application firewall policies
* 🔥 Enable and analyze UFW logging
* 🔥 Troubleshoot firewall configuration issues
* 🔥 Apply firewall best practices for production systems

---

## 🧰 Prerequisites

Before starting this lab, students should have:

* 🐧 Basic Linux command-line knowledge
* 🌐 Understanding of ports, protocols, and IP addressing
* 🔐 Familiarity with SSH, HTTP, and HTTPS concepts
* 🧑‍💻 Basic system administration knowledge
* ⚙️ Access to a Linux terminal with sudo privileges

---

## ☁️ Lab Environment

### Ready-to-Use Cloud Machines

Al Nafi provides Linux-based cloud machines for this lab. Click **Start Lab** to access your environment instantly. No VM setup required.

### Environment Includes:
* Ubuntu Linux with sudo access  
* UFW firewall pre-installed (or installable)  
* Network testing tools (`ping`, `curl`, `telnet`)  
* Logging utilities (`journalctl`, syslog tools)  

---

# 🚀 Task 1: Set Up Basic Firewall Rules with UFW

### 🔍 Subtask 1.1: Install and Check UFW Status

#### Step 1: Check UFW version
```bash
sudo ufw --version
```

#### Step 2: Install UFW (if missing)
```bash
sudo apt update
sudo apt install ufw -y
```

#### Step 3: Check UFW status
```bash
sudo ufw status
```

#### Step 4: View verbose status
```bash
sudo ufw status verbose
```

---

### ⚙️ Subtask 1.2: Enable UFW and Default Policies

#### Step 1: Set safe defaults
```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

#### Step 2: Allow SSH (CRITICAL - DO NOT SKIP)
```bash
sudo ufw allow ssh
```

#### Step 3: Enable firewall
```bash
sudo ufw enable
```

#### Step 4: Verify status
```bash
sudo ufw status
```

---

### 🌐 Subtask 1.3: Basic Service Rules

#### Allow common services
```bash
sudo ufw allow http
sudo ufw allow https
sudo ufw allow ftp
```

#### Allow custom ports
```bash
sudo ufw allow 8080
sudo ufw allow 3306/tcp
```

#### View rules as a numbered list
```bash
sudo ufw status numbered
```

---

### 🚫 Subtask 1.4: Deny Rules

Explicitly block unwanted traffic patterns:

```bash
sudo ufw deny 23
sudo ufw deny smtp
```

---

# 🛡️ Task 2: Create Custom Firewall Policies

### 🌍 Subtask 2.1: IP-Based Rules

Restrict or grant access to targeted hosts and subnets:

```bash
# Allow all traffic from a specific IP
sudo ufw allow from 192.168.1.100

# Allow a specific IP to access SSH only
sudo ufw allow from 192.168.1.100 to any port 22

# Allow an entire local subnet
sudo ufw allow from 192.168.1.0/24

# Deny all traffic from a specific malicious IP
sudo ufw deny from 203.0.113.100

# Allow a specific IP to access HTTP only
sudo ufw allow from 10.0.0.50 to any port 80
```

---

### 📦 Subtask 2.2: Port Range Rules

```bash
# Allow TCP port range
sudo ufw allow 6000:6010/tcp

# Allow UDP port range
sudo ufw allow 60000:61000/udp

# Deny NetBIOS port range
sudo ufw deny 135:139/tcp
```

---

### 🔌 Subtask 2.3: Interface Rules

Identify your interface names first, then bind custom rules to them:

```bash
ip addr show
```
Apply rules to specific network interfaces:
```bash
# Allow HTTP traffic only on eth0
sudo ufw allow in on eth0 to any port 80

# Allow MySQL traffic only on the local loopback interface
sudo ufw allow in on lo to any port 3306
```

---

### 📱 Subtask 2.4: Application Rules

```bash
# List available application profiles
sudo ufw app list

# View details about a specific application profile
sudo ufw app info 'Apache Full'

# Allow traffic using the profile name
sudo ufw allow 'Apache Full'
```

#### Custom Application Profile
Create your own custom application definition file:
```bash
sudo nano /etc/ufw/applications.d/myapp
```
Add the following profile configuration:
```text
[MyWebApp]
title=My Custom Web App
description=App on port 8080
ports=8080/tcp
```
Update and apply the custom profile rules:
```bash
sudo ufw app update MyWebApp
sudo ufw allow MyWebApp
```

---

# 📊 Task 3: Logging and Troubleshooting

### 🧾 Subtask 3.1: Enable Logging

```bash
sudo ufw logging on
sudo ufw logging medium
sudo ufw logging high
```

---

### 📜 Subtask 3.2: View Logs

```bash
# View UFW service logs
sudo journalctl -u ufw

# Follow UFW logs in real-time
sudo journalctl -u ufw -f

# Check system logs for general UFW entries
sudo grep UFW /var/log/syslog

# Isolate blocked traffic entries specifically
sudo grep "UFW BLOCK" /var/log/syslog
```

---

### 🧪 Subtask 3.3: Test Traffic

Verify whether traffic is being properly blocked or allowed from the command line:

```bash
# Test a blocked port (should time out or be refused)
telnet localhost 23

# Test an allowed web port
curl -I http://localhost
```

---

### 📋 Subtask 3.4: Rule Management

```bash
# View rules with index numbers
sudo ufw status numbered

# Delete a rule by its index number (e.g., rule number 5)
sudo ufw delete 5

# Delete a rule by specifying its definition
sudo ufw delete allow 8080

# Insert a high-priority rule at the top of the stack (index 1)
sudo ufw insert 1 allow from 192.168.1.50
```

---

### ⚠️ Subtask 3.5: Advanced Troubleshooting

```bash
# View core configuration properties
sudo cat /etc/ufw/ufw.conf

# View raw Netfilter/iptables rules
sudo ufw show raw

# View listening ports and active firewall rules
sudo ufw show listening

# View rules in their added command-line format
sudo ufw show added

# Completely reset the firewall to default states (warning: clears all custom rules)
sudo ufw --force reset
```

---

# 🧪 Task 4: Firewall Automation Scripts

### ⚙️ Firewall Setup Script

Create a script to rapidly deploy your baseline security profile:

```bash
nano ~/firewall_setup.sh
```
Add the configuration deployment logic:
```bash
#!/bin/bash

echo "Configuring UFW Firewall..."

# Force a clean slate reset
sudo ufw --force reset

# Set default security baselines
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Configure structural core service profiles
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https

# Apply application and port metrics
sudo ufw allow 'Apache Full'
sudo ufw allow 8080/tcp

# Block dangerous or legacy protocols explicitly
sudo ufw deny telnet
sudo ufw deny ftp

# Enable logging telemetry and fire the engine up
sudo ufw logging medium
sudo ufw enable

# Output final status check
sudo ufw status verbose
echo "Firewall setup complete!"
```
Make the script executable and run it:
```bash
chmod +x ~/firewall_setup.sh
./firewall_setup.sh
```

---

### 📡 Monitoring Script

Create an audit parsing tool to keep track of connection states:

```bash
nano ~/ufw_monitor.sh
```
Add the log parsing logic:
```bash
#!/bin/bash

echo "=== UFW Monitoring Report ==="
echo

# Print detailed operational layout parameters
sudo ufw status verbose
echo

echo "--- Recent Blocked Connections ---"
sudo grep "UFW BLOCK" /var/log/syslog | tail -10
echo

echo "--- Recent Allowed Connections ---"
sudo grep "UFW ALLOW" /var/log/syslog | tail -5
```
Make the script executable and run it:
```bash
chmod +x ~/ufw_monitor.sh
./ufw_monitor.sh
```

---

## 🛠️ Troubleshooting Guide

* **❌ Locked Out SSH**  
  If you are locked out or your remote connection freezes, disable the firewall engine entirely via an out-of-band console to restore access:
  ```bash
  sudo ufw disable
  ```
* **❌ Rule Prioritization Issues**  
