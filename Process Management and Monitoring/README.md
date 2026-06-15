# ⚙️ Process Management and Monitoring 

![Linux](https://img.shields.io/badge/OS-Linux-blue)
![Processes](https://img.shields.io/badge/Topic-Process%20Management-red)
![Monitoring](https://img.shields.io/badge/Focus-System%20Monitoring-green)
![Automation](https://img.shields.io/badge/Automation-Cron-orange)
![Level](https://img.shields.io/badge/Level-Intermediate-purple)

---

# 🧠 Overview

This lab focuses on **Linux process management and system monitoring**, teaching how to observe, control, prioritize, and automate processes in real-time systems.

You will gain hands-on experience with system tools used by professional Linux administrators.

> **Core System Reference:** Managing lifecycle executions and processing thread pipelines represents a core operational baseline for high-availability deployments.

---

# 🎯 Objectives

By the end of this lab, you will be able to:

* ✨ Monitor system processes using `ps`, `top`, and `htop`  
* ✨ Understand process states and resource usage  
* ✨ Manage processes using `kill`, `nice`, and `renice`  
* ✨ Automate process monitoring using `cron`  
* ✨ Implement process management best practices  
* ✨ Troubleshoot process-related issues  

---

# 🧰 Prerequisites

Before starting, you should have:

* 🐧 Basic Linux command-line knowledge  
* 👥 Understanding of file permissions  
* ✏️ Familiarity with text editors (nano/vim)  
* 🧠 Basic shell scripting knowledge  
* 🔐 Sudo privileges on Linux system  

---

# ☁️ Lab Environment Setup

Your lab system includes:

* 🐧 Ubuntu / CentOS Linux  
* 📊 Process monitoring tools (`ps`, `top`, `htop`)  
* ⏰ Cron daemon for scheduling  
* 🧰 Pre-installed utilities and editors  

---

# 🚀 Task 1: Process Monitoring

### 🔍 Step 1: View running processes

Run basic snapshots of standard process trees and explore active resource lists across the user operating landscape:

```bash id="p1"
ps
ps aux
```

### 📊 Step 2: Understand process details

Key columns breakdown inside the execution table array:
* 👤 **USER** → Process owner context space.
* 🆔 **PID** → Process identification index number.
* ⚡ **%CPU** → CPU cycle utilization speed profile.
* 💾 **%MEM** → Real layout physical memory footprints.
* 📦 **COMMAND** → Explicit runtime execution paths or commands.

### 🌳 Step 3: Process tree view

Map structural parent-child tree lines or extract resource utilization metrics in specific sorted profiles:

```bash
ps auxf
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu
```

### 🔎 Step 4: Search processes

Isolate running software targets dynamically using system filtering layers:

```bash
ps aux | grep bash
ps -u $(whoami)
```

### 🔥 Step 5: Real-time monitoring (top)

```bash
top
```
**Interactive shortcuts inside the interface map:**
* `P` → Sort tasks dynamically by CPU engine pressure.
* `M` → Sort tasks dynamically by memory pressure footprint.
* `k` → Send kill signal triggers directly via target PID entries.
* `r` → Renice priority levels dynamically.
* `q` → Exit out back to shell profiles.

### ⚡ Step 6: Enhanced monitoring (htop)

Install and spin up interactive graph visualizations to manage active environments cleanly:

```bash
sudo apt install htop -y
htop
```
**Functional dashboard map keys:**
* `F1` → Display system documentation help overlays.
* `F3` → Interactively filter string configurations.
* `F5` → Visual hierarchical parent-child engine mappings.
* `F9` → Send direct system kill execution configurations.
* `F10` → Clean exit configurations.

---

# ⚙️ Task 2: Process Management

### 🧪 Step 1: Create test processes

#### CPU stress script
Construct an endless iterative structural code script path loop:
```bash
cat > cpu_intensive.sh << 'EOF'
#!/bin/bash
while true; do
  echo "working..." > /dev/null
done
EOF

chmod +x cpu_intensive.sh
```

#### Memory test script
Construct a baseline runtime memory allocation leak model:
```bash
cat > memory_test.sh << 'EOF'
#!/bin/bash
data=""
while true; do
  data=$data"memory load "
  sleep 1
done
EOF

chmod +x memory_test.sh
```

### 🎚️ Step 2: Process priority (nice)

Inspect standard nice states and spin up test pipelines using modified initial resource weight schedulers:

```bash
ps -o pid,ni,cmd -p $$
nice -n 10 ./cpu_intensive.sh &
sudo nice -n -5 ./cpu_intensive.sh &
```

### 🔄 Step 3: Change priority (renice)

Locate the targeted stress processing metrics and alter execution values dynamically at runtime:

```bash
ps aux | grep cpu_intensive
renice 10 <PID>
ps -o pid,ni,cmd -p <PID>
```

### ❌ Step 4: Kill processes

Manage tasks and enforce dynamic application shutdowns via jobs handles or specific matching targets:

```bash
jobs -l
kill %1
pkill cpu_intensive
pkill -9 cpu_intensive
killall memory_test.sh
```

---

# ⏰ Task 3: Automation with Cron

### 📁 Step 1: Monitoring directory

```bash
mkdir -p ~/process_monitoring
cd ~/process_monitoring
```

### 📊 Step 2: System monitor script

Build a telemetry tracking file log workflow script engine output mapping:

```bash
cat > system_monitor.sh << 'EOF'
#!/bin/bash
echo "System Report - $(date)" >> system.log
top -bn1 | head -5 >> system.log
ps aux --sort=-%cpu | head -5 >> system.log
ps aux --sort=-%mem | head -5 >> system.log
df -h >> system.log
EOF

chmod +x system_monitor.sh
```

### 🚨 Step 3: CPU alert script

```bash
cat > cpu_alert.sh << 'EOF'
#!/bin/bash
CPU=$(top -bn1 | grep "Cpu" | awk '{print $2}')
if [ "${CPU%.*}" -gt 80 ]; then
  echo "High CPU detected: $CPU" >> cpu_alert.log
fi
EOF

chmod +x cpu_alert.sh
```

### 🚨 Step 4: Memory alert script

```bash
cat > memory_alert.sh << 'EOF'
#!/bin/bash
MEM=$(free | awk '/Mem:/ {printf("%d", $3/$2 * 100)}')
if [ "$MEM" -gt 80 ]; then
  echo "High Memory: $MEM%" >> memory_alert.log
fi
EOF

chmod +x memory_alert.sh
```

<h3>⏰ Step 5: Cron jobs</h3>

Open and register scheduled evaluation automated processing loops into system crontab configs:

```bash
crontab -e
```
Add the automated polling cron values directly to the file mapping rules:
```text
*/5 * * * * /home/\$USER/process_monitoring/system_monitor.sh
*/2 * * * * /home/\$USER/process_monitoring/cpu_alert.sh
*/2 * * * * /home/\$USER/process_monitoring/memory_alert.sh
```

---

# 📊 Task 4: Monitoring Dashboard

Create an automated quick visual data snapshot dashboard template logic script file:

```bash
cat > dashboard.sh << 'EOF'
#!/bin/bash
clear
echo "=== PROCESS DASHBOARD ==="
echo "Time: \$(date)"
echo
uptime
echo
ps aux --sort=-%cpu | head -5
echo
ps aux --sort=-%mem | head -5
EOF

chmod +x dashboard.sh
./dashboard.sh
```

---

# 🧰 Task 5: Process Manager Toolkit

Design an interactive console choice execution path architecture engine to triage processes:

```bash
cat > process_manager.sh << 'EOF'
#!/bin/bash

echo "1. Show processes"
echo "2. Top CPU"
echo "3. Top MEM"
echo "4. Kill process"
read choice

case \$choice in
1) ps aux | head ;;
2) ps aux --sort=-%cpu | head ;;
3) ps aux --sort=-%mem | head ;;
4) echo "Enter PID to kill:"; read pid; kill \$pid ;;
esac
EOF

chmod +x process_manager.sh
```

---

# 🛠️ Troubleshooting

### ❌ Process not killing
* Enforce absolute kernel drops using hard terminate paths:
  ```bash
  kill -9 PID
  pkill -f process_name
  ```

### ❌ High CPU usage
* Track usage metrics directly and damp down active operational priorities:
  ```bash
  top -o %CPU
  renice 19 PID
  ```

### ❌ Cron not working
* Inspect target configuration mappings and verify daemon engines running cleanly:
  ```bash
  sudo systemctl status cron
  crontab -l
  ```

---

# 📌 Best Practices

* ✔ Monitor system resource baselines regularly.
* ✔ Avoid blindly killing low-level critical operating system parent components.
* ✔ Leverage `nice` and `renice` options to keep performance profiles properly balanced.
* ✔ Automate validation scripts via crontab layers to detect performance outliers.
* ✔ Record tracking metrics to dedicated log streams for triage audits.

---

# 🏁 Conclusion

You have successfully learned:
* 📊 Process monitoring workflows via `ps`, `top`, and `htop` abstractions.
* ⚙️ Process flow controls and task termination mechanics via signals.
* ⏰ Automated cron loop integration pipelines.
* 📈 Real-time performance behavior analytics configurations.
* 🧰 Scripted utility template toolkit patterns.

---

# 🎓 Outcome

You are now capable of:
1. Managing Linux processes efficiently.
2. Monitoring system performance in real-time environments.
3. Automating infrastructure health validation flows.
4. Troubleshooting unhandled execution thread lockouts.

These skills are essential core competencies for **System Administrators** and **DevOps Engineers**.
