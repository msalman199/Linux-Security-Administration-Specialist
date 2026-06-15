# ⚙️ Systemd for Service Management 

![Linux](https://img.shields.io/badge/OS-Linux-blue)
![Systemd](https://img.shields.io/badge/Service-Systemd-green)
![Logging](https://img.shields.io/badge/Logs-journalctl-orange)
![Level](https://img.shields.io/badge/Level-Intermediate-purple)
![Automation](https://img.shields.io/badge/Focus-Service%20Management-red)

---

# 🧠 Overview

This lab focuses on **systemd service management in Linux**, covering how to control services, create custom units, monitor logs, and troubleshoot system services.

Systemd is the **core init system** used in modern Linux distributions.

> **Core OS Reference:** Understanding unit states and process initialization is essential for deploying and maintaining production architectures.

---

# 🎯 Objectives

By the end of this lab, you will be able to:

* ✨ Understand systemd service architecture  
* ✨ Manage services using `systemctl`  
* ✨ Create custom systemd service units  
* ✨ Monitor logs using `journalctl`  
* ✨ Debug and troubleshoot service failures  
* ✨ Implement secure service configurations  

---

# 🧰 Prerequisites

Before starting, you should have:

* 🐧 Basic Linux command-line knowledge  
* 📂 File permission understanding  
* ✏️ Familiarity with nano or vim  
* ⚙️ Basic understanding of processes/services  
* 🔐 Sudo/root access  

---

# ☁️ Lab Environment Setup

Your system includes:

* 🐧 Ubuntu 20.04 / CentOS 8 / Rocky Linux  
* ⚙️ Systemd (default init system)  
* 🧰 Pre-installed system utilities  
* 📝 Text editors (nano, vim)  
* 🔐 Root access for service control  

---

# 🚀 Task 1: Systemctl Basics

### 🔍 Step 1: Check systemd status

Run basic checks to determine the core version and global operational layout profile:

```bash id="sd1"
systemctl --version
systemctl status
```

### 📋 Step 2: List services

Display all active service units or inspect full unit registration file records:

```bash
systemctl list-units --type=service
systemctl list-unit-files --type=service
```

### ⚙️ Step 3: Service control (example: cron)

Manage individual runtime states explicitly using explicit daemon control directives:

```bash
systemctl status cron
sudo systemctl stop cron
sudo systemctl start cron
sudo systemctl restart cron
```

### 🔄 Step 4: Enable/Disable services

Configure initialization states across standard multi-user targets:

```bash
systemctl is-enabled cron
sudo systemctl disable cron
sudo systemctl enable cron
sudo systemctl enable --now cron
```

### 🚫 Step 5: Masking services

Enforce ultimate service blockages to prevent manual activations or dependency chain triggers:

```bash
sudo systemctl mask cron
sudo systemctl unmask cron
systemctl list-dependencies cron
```

---

# 🧩 Task 2: Custom Systemd Services

### 🛠️ Step 1: Create service directory

```bash
sudo mkdir -p /opt/myapp
```

### 📜 Step 2: Create service script

Build an endless loop executable script logic path:

```bash
sudo nano /opt/myapp/myservice.sh
```
Add the shell tracking script layout logic:
```bash
#!/bin/bash
LOG="/var/log/myservice.log"

while true; do
  echo "$(date): Service running (PID $$)" >> $LOG
  sleep 30
done
```
Set correct system file execution boundaries:
```bash
sudo chmod +x /opt/myapp/myservice.sh
```

### ⚙️ Step 3: Create systemd unit

Define custom configuration variables inside the centralized service registry:

```bash
sudo nano /etc/systemd/system/myservice.service
```
Populate the configuration structure map:
```text
[Unit]
Description=My Custom Service
After=network.target

[Service]
Type=simple
ExecStart=/opt/myapp/myservice.sh
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

### 🔄 Step 4: Reload systemd

Force systemd to refresh its cache mapping table to pick up the new unit definition:

```bash
sudo systemctl daemon-reload
```

### ▶️ Step 5: Start service

```bash
sudo systemctl start myservice
sudo systemctl enable myservice
systemctl status myservice
```

### 📄 Step 6: Check logs

Monitor standard application file output metrics:

```bash
tail -f /var/log/myservice.log
```

---

# ⚙️ Task 3: Advanced Systemd Service

### 🌍 Step 1: Environment-based service script

Construct an advanced runtime script with variable fallbacks:

```bash
sudo nano /opt/myapp/advanced.sh
```
Add the execution parameters:
```bash
#!/bin/bash
LOG="${LOG_PATH:-/var/log/advanced.log}"
NAME="${SERVICE_NAME:-AdvancedService}"
INTERVAL="${SLEEP_INTERVAL:-20}"

while true; do
  echo "$(date): $NAME running" >> $LOG
  sleep $INTERVAL
done
```
Make the advanced script file executable:
```bash
sudo chmod +x /opt/myapp/advanced.sh
```

### 📦 Step 2: Environment file

Isolate deployment configurations securely into an infrastructure variable file:

```bash
sudo nano /etc/default/advanced-service
```
Populate keys:
```text
SERVICE_NAME=ProductionService
LOG_PATH=/var/log/advanced.log
SLEEP_INTERVAL=15
ENVIRONMENT=Production
```

### ⚙️ Step 3: Systemd service

Link the custom environment configurations to the orchestration block definitions:

```bash
sudo nano /etc/systemd/system/advanced.service
```
Map the service definitions explicitly:
```text
[Unit]
Description=Advanced Service
After=network.target

[Service]
Type=simple
EnvironmentFile=/etc/default/advanced-service
ExecStart=/opt/myapp/advanced.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

### 🚀 Step 4: Start advanced service

```bash
sudo systemctl daemon-reload
sudo systemctl start advanced
sudo systemctl enable advanced
systemctl status advanced
```

---

# 📊 Task 4: Log Monitoring (journalctl)

### 📜 Step 1: View logs

Read unified binary logs systematically from across the global infrastructure:

```bash
sudo journalctl
```

### 🔎 Step 2: Service logs

Filter log records down explicitly to a specific unit name:

```bash
sudo journalctl -u myservice
sudo journalctl -u myservice -f
```

### ⏱️ Step 3: Time-based logs

Query historical traces utilizing relative human-readable timeline strings:

```bash
sudo journalctl --since "1 hour ago"
sudo journalctl -b
```

### 🚨 Step 4: Error logs

Isolate specific logging output entries by log warning and error importance:

```bash
sudo journalctl -p err
```

### 📦 Step 5: Export logs

```bash
sudo journalctl -u myservice > myservice.log
```

---

# 🧪 Task 5: Service Troubleshooting

### ❌ Step 1: Create failing service

Build a target shell application designed to return immediate failure codes:

```bash
sudo nano /opt/myapp/fail.sh
```
Add failure logic:
```bash
#!/bin/bash
echo "Failing service"
exit 1
```

### ⚙️ Step 2: Service unit

```bash
sudo nano /etc/systemd/system/fail.service
```
Add unit metadata:
```text
[Unit]
Description=Fail Service

[Service]
ExecStart=/opt/myapp/fail.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

### 🔍 Step 3: Debug logs

Trigger the structural runtime failure loops and isolate trace issues:

```bash
sudo systemctl daemon-reload
sudo systemctl start fail
sudo journalctl -u fail -n 20
```

### 🛠️ Step 4: Fix service

Remediate script application bugs to recover functional states across execution lines:

```bash
sudo nano /opt/myapp/fail.sh
```
Replace with long-running, functional script logic:
```bash
#!/bin/bash
while true; do
  echo "Service running OK" >> /var/log/fail.log
  sleep 60
done
```

---

# 🔐 Security Best Practices

* ✔ **Run services as non-root users** to prevent wide privilege exposures.
* ✔ **Limit file permissions** across internal processing executable matrices.
* ✔ **Use environment files securely** to prevent configuration variables leak patterns.
* ✔ **Enable restart policies** (`on-failure`, `always`) to preserve persistent container lifecycles.
* ✔ **Monitor logs regularly** using targeted `journalctl` query flows.

---

# 🧰 Task 6: Service Hardening (Best Practice)

Isolate processes by setting up low-privilege system daemons and securing file structures:

```bash
# Create a dedicated, shell-less service user accounts profile
sudo useradd -r -s /bin/false myservice-user

# Change application binary file ownership boundaries away from root layers
sudo chown myservice-user:myservice-user /opt/myapp/myservice.sh
```

---

# 🏁 Conclusion

You have successfully learned:
