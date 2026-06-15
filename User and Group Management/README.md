# 👥 User and Group Management 

### Linux Security & Administration Specialist

<p align="center">

![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge\&logo=ubuntu\&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-Scripting-black?style=for-the-badge\&logo=gnubash\&logoColor=white)
![System Administration](https://img.shields.io/badge/System-Administration-blue?style=for-the-badge)
![Security](https://img.shields.io/badge/Linux-Security-red?style=for-the-badge)
![User Management](https://img.shields.io/badge/User-Management-green?style=for-the-badge)
![Group Management](https://img.shields.io/badge/Group-Management-orange?style=for-the-badge)

</p>

---

# 📖 Overview

User and Group Management is a fundamental Linux administration skill that enables administrators to control system access, implement security policies, and manage resources effectively.

In this lab, students learn how to create, modify, and delete user accounts, manage groups, assign permissions, configure account policies, perform auditing, and implement security best practices in Linux environments.

---

# 🎯 Objectives

By the end of this lab, you will be able to:

✅ Create user accounts using `useradd`

✅ Modify users using `usermod`

✅ Delete users using `userdel`

✅ Create and manage groups using `groupadd` and `groupdel`

✅ Add users to groups using `usermod -aG`

✅ Understand Linux account databases

✅ Implement account security policies

✅ Audit and verify user configurations

---

# 📋 Prerequisites

Before starting this lab, students should have:

* Basic Linux command line knowledge
* Understanding of Linux permissions
* Familiarity with Nano or Vim
* Sudo privileges
* Basic Linux file structure understanding

---

# ☁️ Lab Environment

### Al Nafi Cloud Machine

The lab runs on a pre-configured Linux environment.

Included:

* Ubuntu 20.04 LTS / CentOS 8
* Sudo access
* User management utilities
* Network connectivity
* System administration tools

---

# 🏗️ Task 1 – Understanding User and Group Fundamentals

---

## 🔍 Subtask 1.1 – Examine Current User Information

### Check Current User

```bash
whoami
id
```

### View User Database

```bash
cat /etc/passwd
```

### View Group Database

```bash
cat /etc/group
```

### View Shadow Password Database

```bash
sudo cat /etc/shadow
```

---

## 📂 Subtask 1.2 – Understanding Configuration Files

### Analyze passwd Format

```bash
head -5 /etc/passwd

echo "Format: username:password:UID:GID:GECOS:home_directory:shell"
```

### Analyze group Format

```bash
head -5 /etc/group

echo "Format: group_name:password:GID:user_list"
```

---

# 👤 Task 2 – User Account Management

---

## ➕ Subtask 2.1 – Creating Users

### Create Basic User

```bash
sudo useradd john
```

### Verify User

```bash
grep john /etc/passwd
id john
```

### Create User with Options

```bash
sudo useradd -m -s /bin/bash -c "Jane Smith" -G users jane
```

### Create User with Custom Home

```bash
sudo useradd -m -d /home/custom_mike -s /bin/bash mike
```

### Set Passwords

```bash
sudo passwd john
sudo passwd jane
sudo passwd mike
```

### Create System User

```bash
sudo useradd -r -s /bin/false serviceuser
```

---

## ✏️ Subtask 2.2 – Modifying Users

### Change Shell

```bash
sudo usermod -s /bin/zsh john
grep john /etc/passwd
```

### Change Home Directory

```bash
sudo usermod -d /home/john_new -m john

ls -la /home/ | grep john
```

### Change Full Name

```bash
sudo usermod -c "John Doe - Developer" john

grep john /etc/passwd
```

### Lock Account

```bash
sudo usermod -L mike

sudo passwd -S mike
```

### Unlock Account

```bash
sudo usermod -U mike

sudo passwd -S mike
```

### Change UID

```bash
sudo usermod -u 1500 jane

id jane
```

---

## ❌ Subtask 2.3 – Deleting Users

### Delete User

```bash
sudo userdel serviceuser
```

### Delete User and Home Directory

```bash
sudo userdel -r mike
```

### Force Delete User

```bash
sudo userdel -f john
```

---

# 👥 Task 3 – Group Management

---

## ➕ Subtask 3.1 – Creating Groups

### Create Group

```bash
sudo groupadd developers
```

### Verify Group

```bash
grep developers /etc/group

getent group developers
```

### Create Group with GID

```bash
sudo groupadd -g 2000 managers
```

### Create System Group

```bash
sudo groupadd -r systemgroup
```

### View Groups

```bash
grep -E "(developers|managers|systemgroup)" /etc/group
```

---

## 🔗 Subtask 3.2 – Managing Group Membership

### Add User to Group

```bash
sudo usermod -aG developers jane
```

### Verify Membership

```bash
groups jane

id jane
```

### Add User to Multiple Groups

```bash
sudo usermod -aG managers,users jane

groups jane
```

### Create User and Assign Groups

```bash
sudo useradd -m -G developers,users alice

groups alice
```

### Set Primary Group

```bash
sudo usermod -g developers alice

id alice
```

---

## ⚙️ Subtask 3.3 – Advanced Group Management

### Create Project Team

```bash
sudo groupadd project_alpha

sudo useradd -m -G project_alpha bob

sudo useradd -m -G project_alpha carol
```

### Verify Team

```bash
getent group project_alpha
```

### Remove User from Group

```bash
sudo gpasswd -d jane managers

groups jane
```

### Add User Back

```bash
sudo gpasswd -a jane managers

groups jane
```

---

## 🗑️ Subtask 3.4 – Delete Groups

### Attempt Group Deletion

```bash
sudo groupdel developers
```

### Change Primary Group

```bash
sudo usermod -g users alice

sudo groupdel developers
```

### Delete Unused Groups

```bash
sudo groupdel systemgroup

sudo groupdel project_alpha
```

### Verify Deletion

```bash
grep -E "(systemgroup|project_alpha)" /etc/group
```

---

# 🏢 Task 4 – Practical Scenarios

---

## 👨‍💻 Subtask 4.1 – Development Team Setup

### Create Groups

```bash
sudo groupadd webdev
sudo groupadd database
sudo groupadd devops
```

### Create Team Members

```bash
sudo useradd -m -G webdev,users -s /bin/bash sarah

sudo useradd -m -G database,users -s /bin/bash david

sudo useradd -m -G devops,users -s /bin/bash lisa
```

### Set Passwords

```bash
sudo passwd sarah
sudo passwd david
sudo passwd lisa
```

### Shared Directory

```bash
sudo mkdir -p /opt/projects

sudo chgrp webdev /opt/projects

sudo chmod 775 /opt/projects
```

---

## 🔐 Subtask 4.2 – Password Policies

### Configure Password Aging

```bash
sudo chage -M 90 -m 7 -W 14 sarah
```

### Verify Aging

```bash
sudo chage -l sarah
```

### Set Account Expiration

```bash
sudo usermod -e 2024-12-31 david
```

### Verify Status

```bash
sudo chage -l david
```

---

## 🤖 Subtask 4.3 – Bulk User Creation

### Create Script

```bash
cat > create_users.sh << 'EOF'
#!/bin/bash

users=("intern1" "intern2" "intern3")

for user in "${users[@]}"
do
    sudo useradd -m -G users -s /bin/bash "$user"
    echo "Created user: $user"
done
EOF
```

### Execute

```bash
chmod +x create_users.sh

./create_users.sh
```

### Verify

```bash
grep -E "(intern1|intern2|intern3)" /etc/passwd
```

### Assign Temporary Passwords

```bash
for user in intern1 intern2 intern3
do
    echo "$user:temp123" | sudo chpasswd
    sudo chage -d 0 "$user"
done
```

---

# 🛡️ Task 5 – Security and Auditing

---

## 🔒 Subtask 5.1 – Security Checks

### Empty Password Accounts

```bash
sudo awk -F: '($2 == "") {print $1}' /etc/shadow
```

### UID 0 Accounts

```bash
awk -F: '($3 == 0) {print $1}' /etc/passwd
```

### Users with Login Shells

```bash
grep -E "(bash|zsh|sh)$" /etc/passwd
```

### Duplicate UID Check

```bash
cut -d: -f3 /etc/passwd | sort | uniq -d
```

---

## 📊 Subtask 5.2 – Monitoring

### Last Login Information

```bash
lastlog | head -10
```

### Logged In Users

```bash
who

w
```

### Login History

```bash
last | head -10
```

### Failed Logins

```bash
sudo grep "Failed password" /var/log/auth.log | tail -5
```

---

# 🧹 Task 6 – Cleanup

---

## 🗑️ Remove Users

```bash
for user in alice bob carol sarah david lisa intern1 intern2 intern3
do
    sudo userdel -r "$user"
done
```

---

## 🗑️ Remove Groups

```bash
for group in webdev database devops managers
do
    sudo groupdel "$group"
done
```

---

## 🧹 Remove Test Files

```bash
rm -f create_users.sh

sudo rm -rf /opt/projects
```

---

# ✅ Final Verification

### Users with Login Shells

```bash
grep -E "(bash|zsh|sh)$" /etc/passwd | cut -d: -f1
```

### Custom Groups

```bash
awk -F: '($3 > 1000) {print $1}' /etc/group
```

### Verify User

```bash
id jane
```

---

# 🛠️ Troubleshooting

## Permission Denied

```bash
sudo useradd username
```

---

## User Already Exists

```bash
grep username /etc/passwd
```

---

## Cannot Delete Group

```bash
sudo usermod -g users username

sudo groupdel groupname
```

---

## Home Directory Missing

```bash
sudo useradd -m username
```

---

# 🎓 Skills Acquired

✅ User Creation and Management

✅ Group Administration

✅ Password Policies

✅ Account Security

✅ Linux Auditing

✅ Team Resource Management

✅ Bulk User Operations

✅ User Lifecycle Management

✅ Enterprise Linux Administration

---

# 🎯 Purpose of This Project

The purpose of this project is to provide hands-on experience with Linux User and Group Management, one of the most critical responsibilities of a Linux System Administrator.

Through this lab, students learn how to:

* Manage user accounts securely
* Control access to system resources
* Implement least-privilege principles
* Configure password policies
* Organize users into functional groups
* Audit account activity
* Maintain secure multi-user environments

These skills are essential for Linux Administrators, Security Engineers, DevOps Engineers, Cloud Engineers, and SOC Analysts.

---

# 🏆 Conclusion

In this lab, you successfully practiced Linux user and group management from basic account creation to advanced team management and security auditing.

You learned how to:

* Create, modify, and delete users
* Manage groups and memberships
* Configure account policies
* Implement security best practices
* Audit Linux systems
* Troubleshoot user management issues

These practical skills form a core component of Linux Administration and are directly applicable in enterprise, cloud, and cybersecurity environments.

🚀 You are now better prepared for Linux Administration roles and the Linux Security & Administration Specialist certification.
