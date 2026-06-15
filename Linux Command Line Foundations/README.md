# 🐧 Linux Command Line Foundations

<div align="center">

# 🚀 Linux Command Line Foundations

### Linux Basics • File Management • Directory Navigation • Text Editing

![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge\&logo=ubuntu)
![Terminal](https://img.shields.io/badge/Terminal-Command%20Line-black?style=for-the-badge)
![Bash](https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge\&logo=gnu-bash)
![Editor](https://img.shields.io/badge/Editor-Vim%20%26%20Nano-blue?style=for-the-badge)
![Administration](https://img.shields.io/badge/System-Administration-orange?style=for-the-badge)
![Learning](https://img.shields.io/badge/Level-Beginner-green?style=for-the-badge)

</div>

---

# 📖 Project Overview

The **Linux Command Line Foundations** project is designed to introduce students to the fundamental concepts and practical skills required to work efficiently in a Linux environment.

This hands-on lab focuses on directory navigation, file management, text editing, and essential terminal operations that form the foundation of Linux system administration, cybersecurity, DevOps, and cloud computing careers.

Through practical exercises, students gain confidence using the Linux command line and develop the skills necessary to manage files, directories, and system resources effectively.

---

# 🎯 Purpose of This Project

The purpose of this project is to build a strong foundation in Linux command-line operations and prepare students for advanced Linux administration and cybersecurity training.

This project helps learners:

* 🐧 Understand Linux operating system fundamentals
* 📂 Navigate the Linux file system confidently
* 📁 Create, manage, copy, move, and delete files
* 📝 Edit text files using nano and vim editors
* ⚙️ Learn command syntax and command-line efficiency
* 🔍 Explore Linux directory structures
* 💻 Build practical terminal skills for real-world environments
* 🚀 Prepare for advanced Linux administration topics
* 🔐 Establish foundational skills for cybersecurity learning
* ☁️ Develop knowledge applicable to cloud and DevOps environments

---

# 🎓 Learning Objectives

By completing this project, students will be able to:

### 📂 Directory Navigation

* Navigate the Linux file system
* Understand absolute and relative paths
* Identify the current working directory
* Explore system directories

### 📁 File Management

* Create files and directories
* Copy files and folders
* Move and rename files
* Delete files safely

### 📝 Text Editing

* Create and edit files using Nano
* Create and edit files using Vim
* Save, modify, and manage text files
* Compare file contents

### ⚙️ Linux Terminal Operations

* Execute Linux commands effectively
* Understand command options and syntax
* Manage file permissions
* Perform basic troubleshooting

---

# 🛠️ Technologies & Tools

| Category         | Technologies      |
| ---------------- | ----------------- |
| Operating System | Ubuntu Linux      |
| Shell            | Bash              |
| Terminal         | Linux CLI         |
| Text Editors     | Nano, Vim         |
| File Management  | cp, mv, rm, touch |
| Navigation       | pwd, cd, ls       |
| Search Utilities | find              |
| Comparison Tools | diff              |
| System Utilities | du, wc            |

---

# 📂 Project Structure

```text
lab_practice/
│
├── documents/
│   ├── my_first_file.txt
│   ├── advanced_file.txt
│   ├── system_config.txt
│   └── system_config_backup.txt
│
├── images/
│
├── scripts/
│
├── documents_backup/
│
└── lab_summary.txt
```

---

# 🚀 Task 1 — Directory Navigation Mastery

## 🎯 Objective

Learn how to move efficiently through the Linux file system.

### Check Current Directory

```bash
pwd
```

### List Directory Contents

```bash
ls
```

### Detailed Listing

```bash
ls -l
```

### Show Hidden Files

```bash
ls -la
```

### Navigate to Root Directory

```bash
cd /
```

### Navigate to Home Directory

```bash
cd ~
```

### Create New Directory

```bash
mkdir lab_practice
```

### Navigate into Directory

```bash
cd lab_practice
```

---

# 📁 Task 2 — File Management Operations

## 🎯 Objective

Create, copy, move, rename, and delete files and directories.

### Create Files

```bash
touch sample.txt
```

### Create Multiple Files

```bash
touch file1.txt file2.txt file3.txt
```

### Copy Files

```bash
cp sample.txt sample_backup.txt
```

### Copy File to Directory

```bash
cp sample.txt documents/
```

### Copy Directory

```bash
cp -r documents documents_backup
```

### Move File

```bash
mv move_test.txt images/
```

### Rename File

```bash
mv sample_backup.txt renamed_sample.txt
```

### Delete File

```bash
rm delete_me.txt
```

### Delete Directory

```bash
rm -r temp_directory
```

### Interactive Delete

```bash
rm -i careful_delete.txt
```

---

# 📝 Task 3 — Text Editing with Nano

## 🎯 Objective

Learn beginner-friendly text editing.

### Create File

```bash
nano my_first_file.txt
```

### Save File

```text
Ctrl + O
Enter
```

### Exit Nano

```text
Ctrl + X
```

### View File Content

```bash
cat my_first_file.txt
```

---

# ✨ Task 4 — Text Editing with Vim

## 🎯 Objective

Learn advanced text editing techniques.

### Create File

```bash
vim advanced_file.txt
```

### Enter Insert Mode

```text
i
```

### Return to Normal Mode

```text
Esc
```

### Save File

```text
:w
```

### Quit Vim

```text
:q
```

### Save and Quit

```text
:wq
```

### Quit Without Saving

```text
:q!
```

---

# 🔍 Task 5 — File Comparison & Configuration Management

## 🎯 Objective

Compare and manage text-based configuration files.

### Create Configuration File

```bash
nano system_config.txt
```

### Create Backup

```bash
cp system_config.txt system_config_backup.txt
```

### Compare Files

```bash
diff system_config.txt system_config_backup.txt
```

---

# 🧪 Verification & Testing

## Display Created Files

```bash
find . -type f -name "*.txt"
```

## Count Files

```bash
find . -type f | wc -l
```

## Check Disk Usage

```bash
du -sh .
```

## Display Directory Structure

```bash
find .
```

---

# 🔧 Troubleshooting Guide

## Permission Denied Error

### Check Permissions

```bash
ls -l filename
```

### Modify Permissions

```bash
chmod 644 filename
```

---

## File Not Found Error

### Verify Current Directory

```bash
pwd
```

### List Available Files

```bash
ls -la
```

---

## Vim Issues

### Exit Without Saving

```text
:q!
```

### Save and Exit

```text
:wq
```

---

## Navigation Problems

### Use Absolute Path

```bash
cd ~/lab_practice/documents
```

---

# 💡 Key Linux Commands Learned

| Command | Purpose                    |
| ------- | -------------------------- |
| pwd     | Display current directory  |
| ls      | List files and directories |
| cd      | Change directory           |
| mkdir   | Create directory           |
| touch   | Create file                |
| cp      | Copy files                 |
| mv      | Move/Rename files          |
| rm      | Delete files               |
| nano    | Edit files                 |
| vim     | Advanced file editing      |
| cat     | Display file contents      |
| diff    | Compare files              |
| find    | Search files               |
| du      | Disk usage                 |
| wc      | Count lines/files          |

---

# 🎓 Skills Developed

After completing this project, students gain practical experience in:

### 🐧 Linux Fundamentals

* File system navigation
* Command-line operations
* Directory management

### 📁 File Management

* File creation
* File organization
* Backup procedures

### 📝 Text Editing

* Nano editor proficiency
* Vim editor fundamentals
* Configuration file editing

### ⚙️ System Administration Basics

* Linux command usage
* File permissions
* Troubleshooting techniques

---

# 💼 Career Relevance

This project builds foundational skills for:

* 🐧 Linux Administrator
* 🔐 Security Analyst
* ☁️ Cloud Engineer
* ⚙️ DevOps Engineer
* 💻 System Administrator
* 🚨 SOC Analyst
* 🌐 Network Administrator
* 🔍 Cybersecurity Professional

---

# 🏆 Project Outcome

By completing this project, I developed essential Linux command-line skills and gained practical experience navigating file systems, managing files and directories, editing text files, and using core Linux utilities.

These foundational skills serve as the building blocks for advanced Linux administration, security hardening, automation scripting, cloud computing, and cybersecurity operations.

---

# 📚 What I Learned

✅ Linux File System Navigation

✅ Directory Management

✅ File Creation & Manipulation

✅ Nano Text Editor

✅ Vim Text Editor

✅ Command Syntax & Options

✅ Basic Troubleshooting

✅ Linux Administration Fundamentals

✅ Real-World Terminal Usage

---

<div align="center">

## ⭐ Building Strong Linux Foundations for Security & System Administration

### Linux • Security • Automation • Cloud • DevOps

</div>
