# 📦 Managing Packages with APT / YUM

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Ubuntu](https://img.shields.io/badge/Ubuntu_22.04_LTS-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![CentOS](https://img.shields.io/badge/CentOS_Stream_9-262577?style=for-the-badge&logo=centos&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)

> 🎯 A hands-on lab guide covering software package management on Linux systems using **APT** (Ubuntu/Debian) and **YUM/DNF** (Red Hat/CentOS), complete with automation scripts, repository management, and maintenance best practices.

---

## 🎓 Learning Objectives

By the end of this lab, you will be able to:

- ✅ Install, upgrade, and remove software packages using **APT** and **YUM/DNF**
- ✅ Configure package repositories and manage repository sources
- ✅ Create automated package management scripts
- ✅ Troubleshoot common package management issues
- ✅ Implement system maintenance best practices

---

## 🔧 Prerequisites

| Requirement | Details |
|---|---|
| 💻 CLI Knowledge | Basic Linux command-line familiarity |
| 🔒 Permissions | Understanding of file permissions and `sudo` access |
| 📝 Text Editor | Familiarity with `nano` or `vim` |
| 👤 Access | Root or `sudo` access to a Linux system |

---

## 🖥️ Lab Environment

This lab uses **Al Nafi cloud machines** with pre-configured Linux environments.

> 🚀 Click **Start Lab** to access either environment:

| Environment | Package Manager |
|---|---|
| 🟠 Ubuntu 22.04 LTS | APT |
| 🔵 CentOS Stream 9 | DNF / YUM |

Both environments include full `sudo` access and internet connectivity.

---

## 📋 Task 1: Basic Package Operations

### 🔍 Subtask 1.1 — Identify Your Package Manager

#### 🪜 Step 1: Check your distribution

```bash
cat /etc/os-release
```

#### 🪜 Step 2: Verify available package manager

```bash
which apt || which dnf || which yum
```

---

### 🟠 Subtask 1.2 — Package Operations with APT (Ubuntu/Debian)

![APT](https://img.shields.io/badge/APT-Package_Manager-E95420?style=flat-square&logo=ubuntu&logoColor=white)

#### 🪜 Step 1: Update package repository cache

```bash
sudo apt update
```

#### 🪜 Step 2: Search and install packages

```bash
# 🔎 Search for a package
apt search htop

# 📄 View package details
apt show htop

# 📥 Install package
sudo apt install htop -y
```

#### 🪜 Step 3: Verify installation

```bash
dpkg -l | grep htop
htop  # Press 'q' to quit
```

#### 🪜 Step 4: Install multiple packages

```bash
sudo apt install curl wget tree vim -y
```

#### 🪜 Step 5: Upgrade and remove packages

```bash
# ⬆️ Upgrade all packages
sudo apt upgrade -y

# ⬆️ Upgrade specific package
sudo apt install --only-upgrade htop

# 🗑️ Remove package (keep config)
sudo apt remove tree

# 🗑️ Remove package and config
sudo apt purge tree

# 🧹 Remove unused dependencies
sudo apt autoremove -y
```

---

### 🔵 Subtask 1.3 — Package Operations with YUM/DNF (Red Hat/CentOS)

![DNF](https://img.shields.io/badge/DNF-Package_Manager-262577?style=flat-square&logo=centos&logoColor=white)
![YUM](https://img.shields.io/badge/YUM-Package_Manager-EE0000?style=flat-square&logo=redhat&logoColor=white)

#### 🪜 Step 1: Update package cache

```bash
sudo dnf update -y
# OR for older systems
sudo yum update -y
```

#### 🪜 Step 2: Search and install packages

```bash
# 🔎 Search for package
dnf search htop

# 📄 View package information
dnf info htop

# 📥 Install package
sudo dnf install htop -y
```

#### 🪜 Step 3: Verify installation

```bash
rpm -qa | grep htop
htop  # Press 'q' to quit
```

#### 🪜 Step 4: Install multiple packages

```bash
sudo dnf install curl wget tree vim -y
```

#### 🪜 Step 5: Remove packages

```bash
# 🗑️ Remove package
sudo dnf remove tree -y

# 🧹 Remove unused dependencies
sudo dnf autoremove -y

# 🧹 Clean cache
sudo dnf clean all
```

---

### 📜 Subtask 1.4 — Create Package Status Checker

#### 🪜 Step 1: Create the checker script

```bash
nano package_checker.sh
```

#### 🪜 Step 2: Add starter template

```bash
#!/bin/bash

# 📦 Package Status Checker
# TODO: Complete the functions below

check_package() {
    local package_name=$1
    
    # TODO: Implement package check for APT systems
    # Hint: Use dpkg -l and grep
    
    # TODO: Implement package check for RPM systems
    # Hint: Use rpm -qa and grep
    
    # TODO: Print status message
}

get_package_count() {
    # TODO: Count total installed packages
    # APT: Use dpkg -l | grep ^ii | wc -l
    # RPM: Use rpm -qa | wc -l
}

# Main execution
echo "=== Package Status Checker ==="
echo "Date: $(date)"

# TODO: Check these packages
packages=("htop" "curl" "wget" "vim")

# TODO: Loop through packages and check status

# TODO: Display total package count
```

#### 🪜 Step 3: Make executable and test

```bash
chmod +x package_checker.sh
./package_checker.sh
```

---

## 🗂️ Task 2: Repository Management

### 🟠 Subtask 2.1 — APT Repository Configuration

#### 🪜 Step 1: View current repositories

```bash
cat /etc/apt/sources.list
ls -la /etc/apt/sources.list.d/
```

#### 🪜 Step 2: Backup configuration

```bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
```

#### 🪜 Step 3: Add a new repository (example)

```bash
# 🔑 Add repository key
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

# ➕ Add repository source
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# 🔄 Update package list
sudo apt update
```

#### 🪜 Step 4: Create repository checker script

```bash
nano repo_checker.sh
```

```bash
#!/bin/bash

# 🏥 Repository Health Checker
# TODO: Complete this script

check_repo_health() {
    # TODO: Test repository connectivity
    # Hint: Use apt update or dnf check-update
    
    # TODO: Report success or failure
}

list_repositories() {
    # TODO: List all enabled repositories
    # APT: Parse /etc/apt/sources.list
    # DNF/YUM: Use dnf repolist or yum repolist
}

# TODO: Implement main logic
```

---

### 🔵 Subtask 2.2 — YUM/DNF Repository Configuration

#### 🪜 Step 1: View repository configuration

```bash
dnf repolist
ls -la /etc/yum.repos.d/
```

#### 🪜 Step 2: Add EPEL repository

```bash
sudo dnf install epel-release -y
dnf repolist | grep epel
```

#### 🪜 Step 3: Create custom repository file

```bash
sudo nano /etc/yum.repos.d/custom.repo
```

```ini
[custom-repo]
name=Custom Repository
baseurl=https://example.com/repo/
enabled=1
gpgcheck=1
gpgkey=https://example.com/repo/RPM-GPG-KEY
```

#### 🪜 Step 4: Verify repository

```bash
dnf repolist all | grep custom
```

---

## 🤖 Task 3: Package Automation Scripts

### ⚙️ Subtask 3.1 — Create Package Management Automation

#### 🪜 Step 1: Create automation script

```bash
nano package_automation.sh
```

#### 🪜 Step 2: Add starter template

```bash
#!/bin/bash

# 🤖 Package Management Automation
# Students: Complete the TODO sections

set -e

# 🎨 Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

log() {
    echo -e "[$(date '+%H:%M:%S')] $1"
}

detect_package_manager() {
    # TODO: Detect if system uses apt, dnf, or yum
    # Set PKG_MANAGER variable
    # Set UPDATE_CMD, INSTALL_CMD, REMOVE_CMD variables
}

update_repositories() {
    log "Updating repositories..."
    # TODO: Execute update command based on package manager
}

install_packages() {
    local packages=("$@")
    # TODO: Loop through packages and install each
    # TODO: Log success or failure for each package
}

remove_packages() {
    local packages=("$@")
    # TODO: Loop through packages and remove each
}

install_dev_tools() {
    # TODO: Define list of development tools
    # APT: build-essential, git, curl, wget, vim
    # DNF/YUM: gcc, gcc-c++, make, git, curl, wget, vim
    
    # TODO: Call install_packages function
}

system_maintenance() {
    # TODO: Update repositories
    # TODO: Clean package cache
    # TODO: Remove unused dependencies
}

show_menu() {
    echo "=== 📦 Package Automation Tool ==="
    echo "1. 🔄 Update repositories"
    echo "2. 🛠️  Install dev tools"
    echo "3. 📥 Install custom packages"
    echo "4. 🗑️  Remove packages"
    echo "5. 🧹 System maintenance"
    echo "6. 🚪 Exit"
}

main() {
    detect_package_manager
    
    while true; do
        show_menu
        read -p "Select option: " choice
        
        # TODO: Implement case statement for menu options
        # TODO: Handle each menu choice appropriately
    done
}

# TODO: Call main function
```

#### 🪜 Step 3: Make executable and test

```bash
chmod +x package_automation.sh
./package_automation.sh
```

---

### 🕐 Subtask 3.2 — Create Automated Update Script

#### 🪜 Step 1: Create update script

```bash
nano auto_update.sh
```

#### 🪜 Step 2: Add template

```bash
#!/bin/bash

# 🕐 Automated Update Script
# Can be scheduled with cron

LOGFILE="/var/log/auto_update.log"
LOCKFILE="/tmp/auto_update.lock"

log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | sudo tee -a "$LOGFILE"
}

# TODO: Check if lock file exists (prevent concurrent runs)

# TODO: Create lock file

# TODO: Detect package manager

# TODO: Update package lists/repositories

# TODO: Perform package upgrades

# TODO: Clean up unused packages and cache

# TODO: Remove lock file

# TODO: Log completion message
```

#### 🪜 Step 3: Test the script

```bash
chmod +x auto_update.sh
sudo ./auto_update.sh
sudo cat /var/log/auto_update.log
```

---

### 📊 Subtask 3.3 — Create Package Inventory Script

#### 🪜 Step 1: Create inventory script

```bash
nano package_inventory.sh
```

#### 🪜 Step 2: Add template

```bash
#!/bin/bash

# 📊 Package Inventory Script

OUTPUT_DIR="inventory_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"

create_package_list() {
    # TODO: Export list of installed packages
    # APT: Use dpkg -l | grep ^ii
    # RPM: Use rpm -qa
    
    # TODO: Save to $OUTPUT_DIR/installed_packages.txt
}

create_system_summary() {
    # TODO: Gather system information
    # - Hostname
    # - OS version
    # - Kernel version
    # - Total packages
    # - Disk usage
    # - Memory info
    
    # TODO: Save to $OUTPUT_DIR/system_summary.txt
}

check_security_updates() {
    # TODO: Check for available security updates
    # APT: apt list --upgradeable | grep security
    # DNF: dnf updateinfo list security
    
    # TODO: Save to $OUTPUT_DIR/security_updates.txt
}

create_restore_script() {
    # TODO: Create a script that can reinstall packages
    # Read from installed_packages.txt
    # Generate install commands
    
    # TODO: Save to $OUTPUT_DIR/restore_packages.sh
    # TODO: Make it executable
}

# Main execution
echo "📦 Creating package inventory..."

# TODO: Call all functions
# TODO: Display summary of created files
```

#### 🪜 Step 3: Run and examine output

```bash
chmod +x package_inventory.sh
./package_inventory.sh
ls -la inventory_*/
```

---

## ✅ Expected Outcomes

After completing this lab, you should have:

| # | Outcome |
|---|---|
| 🎯 1 | Successfully installed and removed packages using your system's package manager |
| 🎯 2 | Configured and managed package repositories |
| 🎯 3 | Created functional automation scripts for package management |
| 🎯 4 | Generated system inventory reports |
| 🎯 5 | Understanding of differences between APT and YUM/DNF |

---

## 🛠️ Troubleshooting Tips

### 🔴 Issue 1: Package Manager Lock

**Symptoms:** Error about `dpkg`/`yum` being locked

```bash
# 🟠 APT systems
sudo rm /var/lib/dpkg/lock*
sudo dpkg --configure -a
sudo apt update

# 🔵 YUM/DNF systems
sudo rm /var/run/yum.pid
sudo dnf clean all
```

---

### 🔴 Issue 2: Repository Connection Failures

**Symptoms:** Cannot fetch repository metadata

```bash
# 🌐 Check internet connectivity
ping -c 3 8.8.8.8

# 🧹 Clear cache and retry
sudo apt clean && sudo apt update   # APT
sudo dnf clean all && sudo dnf update  # DNF

# 📄 Check repository URLs in configuration files
```

---

### 🔴 Issue 3: Dependency Conflicts

**Symptoms:** Package installation fails due to dependencies

```bash
# 🟠 APT: Fix broken dependencies
sudo apt --fix-broken install

# 🔵 DNF: Check what's blocking
dnf deplist <package-name>

# 🔁 Force reinstall if needed
sudo apt install --reinstall <package>   # APT
sudo dnf reinstall <package>             # DNF
```

---

### 🔴 Issue 4: Disk Space Issues

**Symptoms:** `No space left on device`

```bash
# 💾 Check disk usage
df -h

# 🧹 Clean package cache
sudo apt clean       # APT
sudo dnf clean all   # DNF

# 🗑️ Remove old kernels (careful!)
sudo apt autoremove  # APT
```

---

## 🏁 Conclusion

This lab covered essential package management operations for both **APT** and **YUM/DNF** systems. You learned to install, upgrade, and remove packages, manage repositories, and create automation scripts. These skills are fundamental for Linux system administration and will help you maintain secure, up-to-date systems efficiently.

---

## 💡 Key Takeaways

| 💡 | Insight |
|---|---|
| 🤖 | Package managers automate software installation and dependency resolution |
| 🔒 | Regular updates are critical for security and stability |
| 📜 | Automation scripts reduce manual effort and errors |
| 🗂️ | Repository management ensures access to required software |
| 🔄 | Both APT and YUM/DNF follow similar concepts with different syntax |

---

## 🚀 Next Steps

- ⏰ Schedule automated updates using **cron**
- 📋 Create custom package lists for different server roles
- 🌐 Explore advanced repository management (mirrors, proxies)
- 💾 Practice disaster recovery using package inventories

---

<div align="center">

![Linux](https://img.shields.io/badge/Linux-System_Administration-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Open Source](https://img.shields.io/badge/Open_Source-❤️-red?style=for-the-badge)

*Happy Learning! 🎓*

</div>
