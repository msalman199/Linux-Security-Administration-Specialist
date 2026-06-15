# 🔐 File Ownership and Permissions 

<p align="center">
  <img src="https://img.shields.io/badge/Linux-Ubuntu%2020.04-E95420?style=for-the-badge&logo=ubuntu&logoColor=white">
  <img src="https://img.shields.io/badge/Bash-Scripting-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white">
  <img src="https://img.shields.io/badge/Linux-Permissions-FCC624?style=for-the-badge&logo=linux&logoColor=black">
  <img src="https://img.shields.io/badge/Security-ACL-blue?style=for-the-badge&logo=securityscorecard&logoColor=white">
</p>

---

# 📖 Overview

This lab provides hands-on experience with Linux file ownership, permissions, user/group access control, and security best practices. Students will learn how to manage access rights using `chmod`, `chown`, `chgrp`, `umask`, and Access Control Lists (ACLs).

---

# 🎯 Objectives

By the end of this lab, students will be able to:

* Understand Linux file permission concepts and numeric notation
* Use `chmod` command to modify file and directory permissions
* Use `chown` command to change ownership
* Configure and apply `umask` settings
* Implement Access Control Lists (ACLs)
* Troubleshoot permission-related issues

---

# 📋 Prerequisites

Before starting this lab, students should have:

* Basic Linux command line knowledge
* Understanding of file system navigation
* Familiarity with `touch` and `mkdir`
* Understanding of Linux users and groups
* Sudo privileges

---

# ☁️ Lab Environment

### Al Nafi Cloud Machine

The lab is performed on a pre-configured Linux machine containing:

* Ubuntu Linux
* Bash Shell
* ACL Utilities
* Sudo Access
* Standard Linux Administration Tools

---

# 🚀 Lab Setup

## Create Lab Directory

```bash
mkdir ~/lab4_permissions
cd ~/lab4_permissions

touch file1.txt file2.txt secret.txt
mkdir testdir1 testdir2

echo "This is a test file" > file1.txt
echo "Confidential data" > secret.txt
```

## Create Test Script

```bash
cat > test_script.sh << 'EOF'
#!/bin/bash
echo "Hello from test script!"
date
EOF
```

## Verify Structure

```bash
ls -la
```

---

# 🔑 Task 1: Change File Permissions with chmod

---

## 📌 Understanding Permissions

Permission Types:

| Permission | Meaning |
| ---------- | ------- |
| r          | Read    |
| w          | Write   |
| x          | Execute |

User Categories:

| Symbol | Meaning |
| ------ | ------- |
| u      | Owner   |
| g      | Group   |
| o      | Others  |
| a      | All     |

---

## 🔍 View Current Permissions

```bash
ls -l

stat -c "%a %n" *

echo "drwxrwxrwx = directory with full permissions"
echo "-rw-r--r-- = file permissions"
```

---

## ✏️ Symbolic Mode

```bash
chmod u+x test_script.sh

chmod go-w file1.txt

chmod u=rw,g=r,o=r file2.txt

chmod a+rx testdir1

ls -l
```

---

## 🔢 Numeric Mode

```bash
chmod 755 test_script.sh

chmod 644 file1.txt

chmod 600 secret.txt

chmod 777 testdir2

ls -l

stat -c "%a %n" *
```

---

## 🔄 Recursive Permissions

```bash
mkdir -p testdir1/subdir1/subdir2

touch testdir1/file_in_dir.txt
touch testdir1/subdir1/nested_file.txt

chmod -R 755 testdir1

find testdir1 -exec ls -ld {} \;
```

---

# 👤 Task 2: Set File Ownership with chown

---

## 🔍 View Ownership Information

```bash
ls -l

ls -n

whoami

groups

id
```

---

## 👥 Create Test Group

```bash
sudo groupadd testgroup

sudo usermod -a -G testgroup $USER

groups $USER
```

---

## 🔄 Change Ownership

```bash
sudo chown :testgroup file1.txt

sudo chown $USER:testgroup file2.txt

sudo chown -R $USER:testgroup testdir1

ls -l

ls -ld testdir1
```

---

## 🏷️ Change Group Ownership

```bash
sudo chgrp testgroup secret.txt

sudo chgrp -R testgroup testdir2

ls -l
```

---

# 🛡️ Task 3: Practice umask and ACL Configurations

---

## 🔒 Understanding umask

View Current umask:

```bash
umask

umask -S
```

Create Test Files:

```bash
touch umask_test1.txt

ls -l umask_test1.txt
```

Restrictive umask:

```bash
umask 077

touch umask_test2.txt

ls -l umask_test2.txt
```

Less Restrictive:

```bash
umask 022

touch umask_test3.txt

ls -l umask_test3.txt
```

Compare Results:

```bash
ls -l umask_test*.txt
```

---

## ⚙️ Permanent umask Configuration

```bash
grep -n umask ~/.bashrc

cp ~/.bashrc ~/.bashrc.backup

echo "" >> ~/.bashrc
echo "# Custom umask setting for lab" >> ~/.bashrc
echo "umask 027" >> ~/.bashrc

tail -3 ~/.bashrc
```

---

# 🔐 Access Control Lists (ACL)

---

## Install / Verify ACL Support

```bash
getfacl --version
```

Create ACL Test Files

```bash
touch acl_test1.txt acl_test2.txt

echo "ACL test content" > acl_test1.txt
```

View ACL

```bash
getfacl acl_test1.txt
```

Assign ACL

```bash
setfacl -m u:$USER:rw acl_test1.txt

setfacl -m g:testgroup:r acl_test1.txt
```

Create ACL Directory

```bash
mkdir acl_testdir

setfacl -d -m u:$USER:rwx acl_testdir

setfacl -d -m g:testgroup:rx acl_testdir
```

Verify ACL

```bash
getfacl acl_test1.txt

getfacl acl_testdir
```

Create File with Inherited ACL

```bash
touch acl_testdir/inherited_file.txt

getfacl acl_testdir/inherited_file.txt
```

---

## 🔧 Advanced ACL Operations

```bash
setfacl -x u:$USER acl_test1.txt

setfacl -b acl_test2.txt

setfacl -m u:$USER:rw acl_test2.txt

getfacl acl_test2.txt | setfacl --set-file=- acl_test1.txt

getfacl acl_test1.txt

getfacl acl_test2.txt

setfacl -m m:r acl_test1.txt

getfacl acl_test1.txt
```

---

# 🌐 Scenario 1: Web Server Permissions

```bash
mkdir -p ~/webserver/{public_html,logs,config}

touch ~/webserver/public_html/index.html
touch ~/webserver/logs/access.log
touch ~/webserver/config/server.conf

chmod 755 ~/webserver
chmod 755 ~/webserver/public_html
chmod 644 ~/webserver/public_html/index.html
chmod 755 ~/webserver/logs
chmod 644 ~/webserver/logs/access.log
chmod 700 ~/webserver/config
chmod 600 ~/webserver/config/server.conf

find ~/webserver -exec ls -ld {} \;
```

---

# 🤝 Scenario 2: Shared Directory Setup

```bash
mkdir ~/shared_project

chmod 775 ~/shared_project

sudo chgrp testgroup ~/shared_project

chmod +t ~/shared_project

chmod g+s ~/shared_project

ls -ld ~/shared_project

touch ~/shared_project/team_file.txt

ls -l ~/shared_project/
```

---

# 🔍 Troubleshooting Commands

## Find Specific Permissions

```bash
find ~/lab4_permissions -perm 644
```

## Find Files Owned By User

```bash
find ~/lab4_permissions -user $USER
```

## Find SUID / SGID Files

```bash
find ~/lab4_permissions -perm /6000
```

## Find Orphan Files

```bash
find ~/lab4_permissions -nouser -o -nogroup
```

## Display ACL Files

```bash
find ~/lab4_permissions -exec getfacl {} \; 2>/dev/null
```

---

# ✅ Verification Script

```bash
cat > permission_test.sh << 'EOF'
#!/bin/bash

echo "=== File Permissions Lab Verification ==="

echo
echo "1. Testing chmod:"
ls -l file*.txt test_script.sh

echo
echo "2. Testing ownership:"
ls -l | grep testgroup

echo
echo "3. Testing umask:"
ls -l umask_test*.txt

echo
echo "4. Testing ACL:"
getfacl acl_test1.txt | head -10

echo
echo "5. Testing shared directory:"
ls -ld ~/shared_project

echo
echo "6. Current umask:"
umask

echo
echo "=== Verification Complete ==="
EOF

chmod +x permission_test.sh

./permission_test.sh
```

---

# 🧹 Cleanup

```bash
read -p "Do you want to clean up lab files? (y/n): " cleanup

if [[ $cleanup == "y" || $cleanup == "Y" ]]; then
    cd ~

    rm -rf ~/lab4_permissions
    rm -rf ~/webserver
    rm -rf ~/shared_project

    if [[ -f ~/.bashrc.backup ]]; then
        mv ~/.bashrc.backup ~/.bashrc
    fi

    sudo groupdel testgroup 2>/dev/null

    echo "Lab cleanup completed."
else
    echo "Lab files preserved."
fi
```

---

# 📊 Skills Learned

✅ Linux File Permissions

✅ Symbolic & Numeric chmod

✅ File Ownership Management

✅ Group Ownership Management

✅ Recursive Permission Changes

✅ umask Configuration

✅ Access Control Lists (ACL)

✅ Shared Directory Security

✅ Web Server Permission Hardening

✅ Troubleshooting Permission Issues

---

# 🎓 Why This Lab Matters

File permissions and ownership are core Linux security concepts. Every Linux administrator must understand how to:

* Protect sensitive files
* Secure services and applications
* Configure multi-user environments
* Implement least-privilege access
* Prevent unauthorized access

These skills are fundamental for:

* Linux System Administration
* Security Operations (SOC)
* DevOps Engineering
* Cloud Administration
* Cybersecurity Roles

---

# 🏆 Conclusion

In this lab, you successfully learned how to manage Linux file ownership and permissions using industry-standard administrative tools.

You practiced:

* chmod
* chown
* chgrp
* umask
* ACLs
* Shared directory security
* Web server security configurations

These skills form a critical foundation for advanced Linux administration, security hardening, and the **Al Razzaq Linux Security & Administration Specialist** certification path.

🚀 Keep practicing with real-world permission scenarios to build confidence and expertise in Linux system security.
