# 🌐 Networking Basics and Tools — Complete Linux Lab Guide

![Linux](https://img.shields.io/badge/Linux-Networking-blue)
![Topic](https://img.shields.io/badge/Networking-Basics-green)
![Focus](https://img.shields.io/badge/System-Administration-orange)
![Automation](https://img.shields.io/badge/Scripting-Bash-yellow)
![Level](https://img.shields.io/badge/Level-Beginner--Intermediate-red)

---

## 🧠 Overview

This lab focuses on **Linux networking fundamentals and essential system utilities**, helping you understand how to inspect, analyze, and troubleshoot network configurations and connectivity in real-world environments.

You will work with both **legacy tools (`ifconfig`, `netstat`)** and **modern tools (`ip`, `ss`)**, along with automation scripts for diagnostics and monitoring.

---

## 🎯 Objectives

By the end of this lab, students will be able to:

* ✨ Use essential Linux networking commands including `ifconfig`, `ip`, `netstat`, and `ss`
* ✨ Configure and manage network interfaces on Linux systems
* ✨ Test network connectivity using `ping` and `traceroute` commands
* ✨ Understand network interface states and configurations
* ✨ Analyze network connections and listening services
* ✨ Troubleshoot basic network connectivity issues

---

## 🧰 Prerequisites

Before starting this lab, students should have:

* 🐧 Basic Linux command-line knowledge
* 👥 Understanding of file permissions and text editors
* 💻 Familiarity with terminal environment
* 🌐 Basic networking concepts (IP addresses, ports, protocols)

---

## ☁️ Ready-to-Use Cloud Machines

Al Nafi provides Linux-based cloud machines for this lab. Simply click **Start Lab** to access your pre-configured environment. No additional setup is required.

### 🖥️ Lab Environment Setup

Your environment includes:

- Ubuntu / CentOS Linux system  
- Pre-installed networking tools (`ip`, `ss`, `netstat`, `ping`)  
- Administrative privileges (`sudo`)  
- Bash shell environment  

---

# 🚀 Task 1: Network Interface Management

---

## 🔍 Subtask 1.1: Using `ifconfig`

```bash
ifconfig
ifconfig -a
ifconfig eth0

💡 If eth0 does not exist:

ip link show
ifconfig eth0 | grep -E "(RX|TX)"
⚙️ Subtask 1.2: Using ip Command
ip link show
ip addr show
ip route show
ip -s link show
ip -4 addr show
📊 Subtask 1.3: Comparison Script
nano network_comparison.sh
#!/bin/bash

echo "=== Network Comparison Report ==="

echo "--- ifconfig ---"
ifconfig | head -10

echo "--- ip addr ---"
ip addr show | head -10

echo "--- routing ---"
route -n | head -5

echo "--- ip route ---"
ip route show
chmod +x network_comparison.sh
./network_comparison.sh
🔒 Task 2: Network Connection Analysis
🔍 netstat
netstat -a
netstat -l
netstat -tlnp
netstat -ulnp
netstat -rn
⚡ ss Command
ss -a
ss -l
ss -tlnp
ss -ulnp
ss -s
📡 Network Monitor Script
nano network_monitor.sh
#!/bin/bash

echo "=== Network Monitoring Report ==="
echo "Date: $(date)"

echo "--- Interfaces ---"
ip link show | awk -F': ' '/^[0-9]+/ {print $2}'

echo "--- IPs ---"
ip addr show | grep inet

echo "--- TCP LISTEN ---"
ss -tlnp | grep LISTEN | head -5

echo "--- UDP ---"
ss -ulnp | head -5

echo "--- Stats ---"
ss -s

echo "--- Routes ---"
ip route show
chmod +x network_monitor.sh
./network_monitor.sh
🛠️ Task 3: Network Configuration
🔍 View Configuration
ip addr show
ip route show
cat /etc/resolv.conf
📌 Temporary IP
sudo ip addr add 192.168.100.10/24 dev eth0
ip addr show eth0
sudo ip addr del 192.168.100.10/24 dev eth0
🎚️ Interface Control
ip link show eth0
sudo ip link set eth0 down
sudo ip link set eth0 up
ip link show eth0
🌐 Task 4: Connectivity Testing
📡 ping
ping -c 4 127.0.0.1
ping -c 4 $(ip route show default | awk '{print $3}')
ping -c 4 8.8.8.8
ping -c 4 google.com
ping -D google.com
🗺️ traceroute
sudo apt update && sudo apt install traceroute -y
traceroute google.com
traceroute -n google.com
📜 Connectivity Script
nano connectivity_test.sh
#!/bin/bash

echo "=== Connectivity Test ==="
echo "Start: $(date)"

ping -c 2 127.0.0.1 >/dev/null && echo "Localhost: OK" || echo "Localhost: FAIL"

GATEWAY=$(ip route show default | awk '{print $3}')
ping -c 2 $GATEWAY >/dev/null && echo "Gateway: OK" || echo "Gateway: FAIL"

ping -c 2 google.com >/dev/null && echo "DNS: OK" || echo "DNS: FAIL"

ping -c 2 8.8.8.8 >/dev/null && echo "Internet: OK" || echo "Internet: FAIL"

echo "End: $(date)"
chmod +x connectivity_test.sh
./connectivity_test.sh
🔬 Task 5: Advanced Network Analysis
🔍 Ports
ss -tlnp | grep LISTEN
ss -tlnp | grep :22
ss -tlnp | grep :80
nc -zv localhost 22
📊 Network Stats
watch -n 2 cat /proc/net/dev
ip -s link show
📜 Diagnostic Script
nano network_diagnostic.sh
#!/bin/bash

echo "=== Network Diagnostic Report ==="
echo "Time: $(date)"

echo "--- IPs ---"
ip addr show | grep inet

echo "--- Gateway ---"
ip route show default

echo "--- DNS ---"
cat /etc/resolv.conf

echo "--- Services ---"
ss -tlnp | grep LISTEN | head -5

echo "--- Tests ---"
ping -c 1 127.0.0.1 >/dev/null && echo "Local OK"
ping -c 1 8.8.8.8 >/dev/null && echo "Internet OK"
ping -c 1 google.com >/dev/null && echo "DNS OK"
chmod +x network_diagnostic.sh
./network_diagnostic.sh
⚠️ Troubleshooting
📦 Missing tools
sudo apt install net-tools traceroute netcat -y
🔐 Permission issues
sudo <command>
🌐 Interface check
ip link show
📌 Key Concepts Summary
ifconfig → legacy network tool
ip → modern networking suite
netstat → legacy connection tool
ss → modern socket analyzer
ping → connectivity test
traceroute → route tracking
🏁 Conclusion

In this lab, you learned:

Network interface inspection and configuration
Modern vs legacy networking tools
Connectivity testing and troubleshooting
Network automation with shell scripts
Basic Linux network diagnostics

These skills are essential for Linux system administration, cybersecurity, and DevOps engineering.
