# 🌐 Network Monitoring with Tcpdump

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![CentOS](https://img.shields.io/badge/CentOS-262577?style=for-the-badge&logo=centos&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Tcpdump](https://img.shields.io/badge/Tcpdump-Packet_Analyzer-0078D4?style=for-the-badge&logo=wireshark&logoColor=white)
![Networking](https://img.shields.io/badge/Networking-Security_Monitoring-red?style=for-the-badge&logo=cisco&logoColor=white)
![Security](https://img.shields.io/badge/Security-Incident_Analysis-darkred?style=for-the-badge&logo=shield&logoColor=white)

> 🔭 A comprehensive hands-on lab covering **packet capture**, **traffic filtering**, **security incident analysis**, and **automated network monitoring** using **tcpdump** on Linux systems.

---

## 🎓 Learning Objectives

By the end of this lab, students will be able to:

- ✅ Install and configure **tcpdump** on a Linux system
- ✅ Capture network packets using various tcpdump commands and options
- ✅ Apply **filters** to capture specific types of network traffic
- ✅ **Analyze captured packets** to identify potential security incidents
- ✅ Save captured traffic to **PCAP files** for later analysis
- ✅ Interpret common **network protocols** and traffic patterns
- ✅ Use tcpdump for basic **network troubleshooting** and security monitoring

---

## 🔧 Prerequisites

| Requirement | Details |
|---|---|
| 💻 CLI Knowledge | Basic Linux command-line operations |
| 🌐 Networking | Fundamental knowledge of IP addresses, ports, protocols |
| 📂 File System | Familiarity with Linux file system navigation |
| 🛡️ Security | Basic understanding of network security concepts |
| 🔑 Access | Root or `sudo` access for network monitoring |

---

## 🖥️ Lab Environment

> 🚀 **Al Nafi** provides ready-to-use Linux cloud machines. Click **Start Lab** to access your pre-configured environment — no VM setup required!

| Detail | Info |
|---|---|
| 🖥️ System | Single Linux machine |
| 🛠️ Tools | All pre-installed |
| ☁️ Platform | Al Nafi Cloud |

---

## 📦 Task 1: Installing and Setting Up Tcpdump

### 🔍 Subtask 1.1 — Verify Tcpdump Installation

#### 🪜 Step 1: Check if tcpdump is already installed

```bash
which tcpdump
```

#### 🪜 Step 2: Check the version

```bash
tcpdump --version
```

---

### 📥 Subtask 1.2 — Install Tcpdump (if needed)

#### 🪜 Step 1: Install on Ubuntu/Debian

![APT](https://img.shields.io/badge/APT-Ubuntu%2FDebian-E95420?style=flat-square&logo=ubuntu&logoColor=white)

```bash
sudo apt update
sudo apt install tcpdump -y
```

#### 🪜 Step 2: Install on CentOS/RHEL/Fedora

![YUM](https://img.shields.io/badge/YUM%2FDNF-CentOS%2FRHEL-262577?style=flat-square&logo=centos&logoColor=white)

```bash
sudo yum install tcpdump -y
# OR for newer versions
sudo dnf install tcpdump -y
```

---

### 🌐 Subtask 1.3 — Check Network Interfaces

#### 🪜 Step 1: List all available network interfaces

```bash
ip link show
```

#### 🪜 Step 2: Show interfaces tcpdump can monitor

```bash
sudo tcpdump -D
```

> 📌 Make note of your primary network interface — usually `eth0`, `ens33`, or `enp0s3`.

---

## 📡 Task 2: Basic Packet Capture with Tcpdump

### 📡 Subtask 2.1 — Capture All Traffic

#### 🪜 Step 1: Start capturing all network traffic

```bash
sudo tcpdump -i eth0
```

> ⏱️ Let this run for ~30 seconds, then stop with `Ctrl+C`.

---

### 📡 Subtask 2.2 — Capture with Packet Count Limit

#### 🪜 Step 1: Capture only the first 10 packets

```bash
sudo tcpdump -i eth0 -c 10
```

---

### 📡 Subtask 2.3 — Capture with Verbose Output

#### 🪜 Step 1: Use verbose mode for detailed packet info

```bash
sudo tcpdump -i eth0 -v -c 5
```

#### 🪜 Step 2: Use double-verbose for even more detail

```bash
sudo tcpdump -i eth0 -vv -c 5
```

---

### 📡 Subtask 2.4 — Display Packet Contents

#### 🪜 Step 1: Show packet contents in hex AND ASCII

```bash
sudo tcpdump -i eth0 -X -c 3
```

#### 🪜 Step 2: Show only ASCII content

```bash
sudo tcpdump -i eth0 -A -c 3
```

---

## 🎯 Task 3: Applying Filters to Capture Specific Traffic

### 🔵 Subtask 3.1 — Protocol-Based Filters

#### 🪜 Step 1: Capture only TCP traffic

```bash
sudo tcpdump -i eth0 tcp -c 10
```

#### 🪜 Step 2: Capture only UDP traffic

```bash
sudo tcpdump -i eth0 udp -c 10
```

#### 🪜 Step 3: Capture only ICMP traffic

```bash
sudo tcpdump -i eth0 icmp -c 5
```

---

### 🔵 Subtask 3.2 — Port-Based Filters

#### 🪜 Step 1: Capture HTTP traffic (port 80)

```bash
sudo tcpdump -i eth0 port 80 -c 10
```

#### 🪜 Step 2: Capture HTTPS traffic (port 443)

```bash
sudo tcpdump -i eth0 port 443 -c 10
```

#### 🪜 Step 3: Capture SSH traffic (port 22)

```bash
sudo tcpdump -i eth0 port 22 -c 10
```

---

### 🔵 Subtask 3.3 — Host-Based Filters

#### 🪜 Step 1: Capture traffic for a specific host

```bash
# 🖥️ Terminal 1 — start tcpdump
sudo tcpdump -i eth0 host 8.8.8.8 -c 5

# 🖥️ Terminal 2 — generate traffic
ping -c 3 8.8.8.8
```

#### 🪜 Step 2: Capture traffic from a specific source

```bash
sudo tcpdump -i eth0 src host 8.8.8.8 -c 5
```

#### 🪜 Step 3: Capture traffic to a specific destination

```bash
sudo tcpdump -i eth0 dst host 8.8.8.8 -c 5
```

---

### 🔵 Subtask 3.4 — Complex Filters

#### 🪜 Step 1: Capture HTTP or HTTPS traffic

```bash
sudo tcpdump -i eth0 'port 80 or port 443' -c 10
```

#### 🪜 Step 2: Capture TCP traffic on specific ports

```bash
sudo tcpdump -i eth0 'tcp and (port 22 or port 80)' -c 10
```

#### 🪜 Step 3: Capture traffic from a specific network range

```bash
sudo tcpdump -i eth0 'net 192.168.1.0/24' -c 10
```

---

## 💾 Task 4: Saving Captured Traffic to Files

### 💾 Subtask 4.1 — Save Packets to a File

#### 🪜 Step 1: Create a directory for capture files

```bash
mkdir ~/tcpdump_captures
cd ~/tcpdump_captures
```

#### 🪜 Step 2: Capture and save to a PCAP file

```bash
sudo tcpdump -i eth0 -w capture_all.pcap -c 50
```

---

### 💾 Subtask 4.2 — Save Specific Traffic Types

#### 🪜 Step 1: Capture HTTP traffic and save

```bash
sudo tcpdump -i eth0 port 80 -w http_traffic.pcap -c 20
```

#### 🪜 Step 2: Capture ICMP traffic

```bash
# 🏓 Generate ICMP traffic first
ping -c 5 8.8.8.8 &
sudo tcpdump -i eth0 icmp -w icmp_traffic.pcap -c 10
```

---

### 💾 Subtask 4.3 — Read Captured Files

#### 🪜 Step 1: Read the captured file

```bash
tcpdump -r capture_all.pcap
```

#### 🪜 Step 2: Read with filters applied

```bash
tcpdump -r capture_all.pcap tcp
```

#### 🪜 Step 3: Read with verbose output

```bash
tcpdump -r http_traffic.pcap -v
```

---

## 🛡️ Task 5: Analyzing Traffic for Security Incidents

### ⚠️ Subtask 5.1 — Generate Test Traffic

#### 🪜 Step 1: Create a traffic generation script

```bash
cat > generate_traffic.sh << 'EOF'
#!/bin/bash

echo "🚦 Generating test network traffic..."

# 🌐 Generate HTTP requests
curl -s http://httpbin.org/get > /dev/null &

# 🔍 Generate DNS queries
nslookup google.com > /dev/null &
nslookup facebook.com > /dev/null &

# 🏓 Generate ICMP traffic
ping -c 3 8.8.8.8 > /dev/null &

# 🔐 Generate SSH-like traffic (connection attempts)
timeout 2 telnet 127.0.0.1 22 > /dev/null 2>&1 &

echo "✅ Traffic generation started..."
wait
echo "✅ Traffic generation completed."
EOF

chmod +x generate_traffic.sh
```

---

### ⚠️ Subtask 5.2 — Capture and Analyze Suspicious Activity

#### 🪜 Step 1: Start capturing all traffic in the background

```bash
sudo tcpdump -i eth0 -w security_analysis.pcap -c 100 &
TCPDUMP_PID=$!
```

#### 🪜 Step 2: Run the traffic generator

```bash
./generate_traffic.sh
```

#### 🪜 Step 3: Stop tcpdump

```bash
sudo kill $TCPDUMP_PID
```

---

### ⚠️ Subtask 5.3 — Analyze the Captured Traffic

#### 🪜 Step 1: Analyze all captured traffic

```bash
tcpdump -r security_analysis.pcap
```

#### 🪜 Step 2: Look for DNS queries

```bash
tcpdump -r security_analysis.pcap port 53
```

#### 🪜 Step 3: Look for HTTP traffic

```bash
tcpdump -r security_analysis.pcap port 80
```

#### 🪜 Step 4: Look for SSH connection attempts

```bash
tcpdump -r security_analysis.pcap port 22
```

---

### ⚠️ Subtask 5.4 — Identify Potential Security Issues

#### 🪜 Step 1: Detect SYN packets (potential port scanning)

```bash
tcpdump -r security_analysis.pcap 'tcp[tcpflags] & tcp-syn != 0'
```

#### 🪜 Step 2: Detect failed connections (RST packets)

```bash
tcpdump -r security_analysis.pcap 'tcp[tcpflags] & tcp-rst != 0'
```

#### 🪜 Step 3: Detect large packets (potential data exfiltration)

```bash
tcpdump -r security_analysis.pcap 'greater 1000'
```

---

## 🔬 Task 6: Advanced Filtering and Analysis

### 🔬 Subtask 6.1 — Time-Based Analysis

#### 🪜 Step 1: Capture traffic with timestamps

```bash
sudo tcpdump -i eth0 -tttt -c 10
```

---

### 🔬 Subtask 6.2 — Protocol Analysis Script

#### 🪜 Step 1: Create a comprehensive analysis script

```bash
cat > analyze_traffic.sh << 'EOF'
#!/bin/bash

PCAP_FILE="$1"

if [ -z "$PCAP_FILE" ]; then
    echo "Usage: $0 <pcap_file>"
    exit 1
fi

echo "📊 === Traffic Analysis Report ==="
echo "📁 File: $PCAP_FILE"
echo "📅 Generated on: $(date)"
echo

echo "📦 === Total Packets ==="
tcpdump -r "$PCAP_FILE" | wc -l

echo
echo "📈 === Protocol Distribution ==="
echo "🔵 TCP Packets:"
tcpdump -r "$PCAP_FILE" tcp 2>/dev/null | wc -l

echo "🟡 UDP Packets:"
tcpdump -r "$PCAP_FILE" udp 2>/dev/null | wc -l

echo "🟢 ICMP Packets:"
tcpdump -r "$PCAP_FILE" icmp 2>/dev/null | wc -l

echo
echo "🎯 === Top Destination Ports ==="
tcpdump -r "$PCAP_FILE" -n 2>/dev/null | grep -oE 'dpt:[0-9]+' | sort | uniq -c | sort -nr | head -5

echo
echo "🌐 === Unique Hosts ==="
tcpdump -r "$PCAP_FILE" -n 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | sort | uniq | head -10
EOF

chmod +x analyze_traffic.sh
```

#### 🪜 Step 2: Run the analysis

```bash
./analyze_traffic.sh security_analysis.pcap
```

---

### 🔬 Subtask 6.3 — Create Security Monitoring Filters

#### 🪜 Step 1: Create a security monitoring script

```bash
cat > security_monitor.sh << 'EOF'
#!/bin/bash

INTERFACE="eth0"
DURATION=60

echo "🛡️ Starting security monitoring on $INTERFACE for $DURATION seconds..."

# 🔍 Monitor for potential port scans
echo "🔎 Monitoring for potential port scans..."
timeout $DURATION sudo tcpdump -i $INTERFACE -c 20 \
  'tcp[tcpflags] & tcp-syn != 0 and tcp[tcpflags] & tcp-ack == 0' \
  -w port_scan_attempts.pcap &

# 🌐 Monitor for DNS queries
echo "🌐 Monitoring DNS queries..."
timeout $DURATION sudo tcpdump -i $INTERFACE -c 20 'port 53' -w dns_queries.pcap &

# 📦 Monitor for large data transfers
echo "📦 Monitoring for large packets..."
timeout $DURATION sudo tcpdump -i $INTERFACE -c 20 'greater 1500' -w large_packets.pcap &

wait

echo "✅ Security monitoring completed. Check .pcap files for analysis."
EOF

chmod +x security_monitor.sh
```

---

## 🚨 Task 7: Practical Security Incident Analysis

### 🚨 Subtask 7.1 — Simulate a Security Scenario

#### 🪜 Step 1: Create an incident simulation script

```bash
cat > simulate_incident.sh << 'EOF'
#!/bin/bash

echo "⚠️ Simulating network security incident..."

# 🌐 Simulate normal web browsing
curl -s http://httpbin.org/user-agent > /dev/null &

# 🔐 Simulate multiple SSH connection attempts (brute force-like)
for i in {1..5}; do
    timeout 1 telnet 127.0.0.1 22 > /dev/null 2>&1 &
done

# 🔍 Simulate DNS queries to multiple domains
for domain in google.com facebook.com github.com stackoverflow.com; do
    nslookup $domain > /dev/null &
done

# 📤 Simulate file transfer
dd if=/dev/zero bs=1024 count=100 2>/dev/null | nc -l 8080 &
sleep 1
timeout 2 nc 127.0.0.1 8080 < /dev/null > /dev/null 2>&1

wait
echo "✅ Simulation completed."
EOF

chmod +x simulate_incident.sh
```

---

### 🚨 Subtask 7.2 — Capture the Incident

#### 🪜 Step 1: Start capturing before the simulation

```bash
sudo tcpdump -i eth0 -w incident_capture.pcap -c 200 &
TCPDUMP_PID=$!
```

#### 🪜 Step 2: Run the simulation

```bash
./simulate_incident.sh
```

#### 🪜 Step 3: Stop the capture

```bash
sleep 5
sudo kill $TCPDUMP_PID
```

---

### 🚨 Subtask 7.3 — Analyze the Incident

#### 🪜 Step 1: Count total packets captured

```bash
echo "1️⃣ Total packets captured:"
tcpdump -r incident_capture.pcap 2>/dev/null | wc -l
```

#### 🪜 Step 2: Review SSH connection attempts

```bash
echo "2️⃣ Connection attempts to SSH (port 22):"
tcpdump -r incident_capture.pcap port 22 -c 10
```

#### 🪜 Step 3: Review DNS activity

```bash
echo "3️⃣ DNS resolution activities:"
tcpdump -r incident_capture.pcap port 53 -c 10
```

#### 🪜 Step 4: Review HTTP activity

```bash
echo "4️⃣ HTTP activities:"
tcpdump -r incident_capture.pcap port 80 -c 10
```

#### 🪜 Step 5: Check unusual port activity

```bash
echo "5️⃣ Unusual port activities (8080):"
tcpdump -r incident_capture.pcap port 8080 -c 10
```

---

## 📊 Task 8: Creating Custom Monitoring Solutions

### 🖥️ Subtask 8.1 — Build a Network Monitoring Dashboard Script

#### 🪜 Step 1: Create the comprehensive monitoring script

```bash
cat > network_monitor.sh << 'EOF'
#!/bin/bash

INTERFACE="eth0"
LOG_DIR="$HOME/network_logs"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p "$LOG_DIR"

echo "📊 Network Monitoring Dashboard"
echo "================================"
echo "🌐 Interface: $INTERFACE"
echo "📂 Log Directory: $LOG_DIR"
echo "🕐 Start Time: $(date)"
echo

monitor_traffic() {
    local traffic_type="$1"
    local filter="$2"
    local filename="$3"
    
    echo "▶️  Starting $traffic_type monitoring..."
    sudo tcpdump -i "$INTERFACE" "$filter" -w "$LOG_DIR/${filename}_${DATE}.pcap" -c 50 &
    echo "   PID: $!"
}

# 🚀 Start different monitoring sessions
monitor_traffic "🌍 HTTP Traffic"  "port 80"   "http"
monitor_traffic "🔒 HTTPS Traffic" "port 443"  "https"
monitor_traffic "🌐 DNS Traffic"   "port 53"   "dns"
monitor_traffic "🔐 SSH Traffic"   "port 22"   "ssh"
monitor_traffic "🏓 ICMP Traffic"  "icmp"      "icmp"

echo
echo "🚦 Generating test traffic..."
curl -s http://httpbin.org/get > /dev/null &
nslookup google.com > /dev/null &
ping -c 3 8.8.8.8 > /dev/null &

echo "⏳ Waiting for capture completion..."
wait

echo
echo "✅ Monitoring completed. Files saved in $LOG_DIR"
ls -la "$LOG_DIR"
EOF

chmod +x network_monitor.sh
```

---

### 🖥️ Subtask 8.2 — Run the Monitoring Dashboard

#### 🪜 Step 1: Execute the monitoring script

```bash
./network_monitor.sh
```

---

### 🖥️ Subtask 8.3 — Analyze the Results

#### 🪜 Step 1: Create a summary analysis of all captured files

```bash
cat > analyze_all.sh << 'EOF'
#!/bin/bash

LOG_DIR="$HOME/network_logs"

echo "📊 Network Traffic Analysis Summary"
echo "====================================="
echo "📅 Analysis Date: $(date)"
echo

for pcap_file in "$LOG_DIR"/*.pcap; do
    if [ -f "$pcap_file" ]; then
        echo "📁 File: $(basename "$pcap_file")"
        echo "   📦 Packets: $(tcpdump -r "$pcap_file" 2>/dev/null | wc -l)"
        echo "   💾 File Size: $(ls -lh "$pcap_file" | awk '{print $5}')"
        echo "   ---"
    fi
done

echo
echo "🏆 Top 5 most active protocols:"
for pcap_file in "$LOG_DIR"/*.pcap; do
    if [ -f "$pcap_file" ]; then
        tcpdump -r "$pcap_file" -n 2>/dev/null
    fi
done | grep -oE 'TCP|UDP|ICMP' | sort | uniq -c | sort -nr | head -5
EOF

chmod +x analyze_all.sh
```

#### 🪜 Step 2: Run the summary analysis

```bash
./analyze_all.sh
```

---

## 🛠️ Troubleshooting Common Issues

### 🔴 Issue 1: Permission Errors

```bash
# ➕ Add your user to the appropriate group
sudo usermod -a -G wireshark $USER

# 🔑 Or run with sudo
sudo tcpdump -i eth0
```

---

### 🔴 Issue 2: Interface Not Found

```bash
# 🔍 List all available interfaces
ip link show

# ✅ Use the correct interface name in your commands
sudo tcpdump -i <your_interface_name>
```

---

### 🔴 Issue 3: No Packets Captured

```bash
# 🔍 Check if interface is up
ip link show eth0

# 🏓 Generate some traffic
ping -c 3 8.8.8.8
```

---

### 🔴 Issue 4: File Permission Issues

```bash
# 🔑 Change ownership of capture files
sudo chown $USER:$USER *.pcap
```

---

## ✅ Expected Outcomes

After completing this lab, you should have achieved:

| # | Skill Gained |
|---|---|
| 🎯 1 | Installed and configured tcpdump on a Linux system |
| 🎯 2 | Captured packets using various command-line options |
| 🎯 3 | Applied sophisticated filters to isolate specific traffic |
| 🎯 4 | Saved captured data to PCAP files for persistent analysis |
| 🎯 5 | Analyzed network traffic to identify potential security incidents |
| 🎯 6 | Created custom monitoring solutions for different traffic types |
| 🎯 7 | Developed scripts for automated network monitoring |
| 🎯 8 | Built comprehensive analysis workflows for incident response |

---

## 💡 Practical Applications

| 🛠️ Use Case | Description |
|---|---|
| 🔍 Network Troubleshooting | Diagnose connectivity and performance issues |
| 🚨 Incident Detection | Identify suspicious patterns in real time |
| 📋 Compliance Monitoring | Create audit trails of network communications |
| 🔬 Forensic Analysis | Deep-dive investigation of captured traffic |

---

## 🏁 Conclusion

In this comprehensive lab, you have successfully learned how to use **tcpdump** for network monitoring and security analysis:

| ✅ Achievement | Impact |
|---|---|
| 📦 Packet Capture | Mastered various capture options and output formats |
| 🎯 Traffic Filtering | Applied protocol, port, host, and complex filters |
| 💾 File Management | Saved and replayed PCAP captures for analysis |
| 🛡️ Security Analysis | Detected SYN scans, RST floods, and large transfers |
| 🤖 Automation | Built reusable monitoring and analysis scripts |

> ⚡ **Why This Matters:** Network monitoring with tcpdump is a **fundamental skill** for system administrators, security professionals, and network engineers. These skills are directly applicable to real-world security incident response, network troubleshooting, and compliance monitoring.

---

<div align="center">

![Tcpdump](https://img.shields.io/badge/Tcpdump-Packet_Capture-0078D4?style=for-the-badge&logo=wireshark&logoColor=white)
![Security](https://img.shields.io/badge/Network-Security_Monitoring-red?style=for-the-badge&logo=shield&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-System_Admin-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Open Source](https://img.shields.io/badge/Open_Source-❤️-red?style=for-the-badge)

*Monitor Everything. Miss Nothing. 🔭*

</div>
