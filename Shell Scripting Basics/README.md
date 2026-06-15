# 🐚 Shell Scripting Basics 
### Linux Security & Administration Specialist

<p align="center">

![Linux](https://img.shields.io/badge/Linux-Ubuntu_E34F26?style=for-the-badge&logo=ubuntu&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-Scripting-121011?style=for-the-badge&logo=gnubash&logoColor=white)
![Shell](https://img.shields.io/badge/Shell-Automation-green?style=for-the-badge)
![CLI](https://img.shields.io/badge/Linux-Command_Line-blue?style=for-the-badge)
![Security](https://img.shields.io/badge/System-Administration-red?style=for-the-badge)
![Automation](https://img.shields.io/badge/Automation-Tasks-orange?style=for-the-badge)

</p>

---

# 📖 Overview

This lab introduces the fundamentals of Linux Shell Scripting using Bash. Students will learn how to create executable scripts, use variables, implement conditional statements, utilize loops, and automate common Linux administration tasks.

Shell scripting is one of the most important skills for Linux administrators and cybersecurity professionals because it enables automation, consistency, and efficient management of systems.

---

# 🎯 Objectives

By the end of this lab, students will be able to:

✅ Understand shell scripting fundamentals

✅ Create and execute Bash scripts

✅ Work with variables and user input

✅ Implement conditional statements

✅ Use for loops and while loops

✅ Automate repetitive administrative tasks

✅ Create backup and reporting scripts

✅ Apply scripting best practices

---

# 📋 Prerequisites

Before starting this lab, students should have:

- Basic Linux command-line knowledge
- File system navigation skills
- Understanding of Linux file permissions
- Familiarity with text editors
- Knowledge of basic Linux commands
- Understanding of input/output redirection

---

# ☁️ Lab Environment

### Al Nafi Cloud Machine

Pre-configured Ubuntu Linux environment containing:

- Ubuntu Linux
- Bash Shell
- Nano
- Vim
- Gedit
- Linux Utilities

No additional setup is required.

---

# 📁 Create Working Directory

```bash
mkdir ~/shell_scripts
cd ~/shell_scripts
```

---

# 🚀 Task 1 – Shell Scripting Fundamentals

---

## 📝 Subtask 1.1 – Hello World Script

Create the script:

```bash
nano hello_world.sh
```

### Code

```bash
#!/bin/bash
# This is my first shell script
# Author: Your Name
# Date: Today's Date

echo "Hello, World!"
echo "Welcome to Shell Scripting!"
```

### Make Executable

```bash
chmod +x hello_world.sh
```

### Execute

```bash
./hello_world.sh
```

### Expected Output

```text
Hello, World!
Welcome to Shell Scripting!
```

---

## 🔤 Subtask 1.2 – Variables Demonstration

Create:

```bash
nano variables_demo.sh
```

### Code

```bash
#!/bin/bash
# Variables demonstration script

NAME="John Doe"
AGE=25
CURRENT_DATE=$(date)
CURRENT_USER=$(whoami)
HOME_DIR=$HOME

echo "=== Personal Information ==="
echo "Name: $NAME"
echo "Age: $AGE"
echo "Current User: $CURRENT_USER"
echo "Home Directory: $HOME_DIR"
echo "Current Date: $CURRENT_DATE"

echo ""
echo "Please enter your favorite color:"
read FAVORITE_COLOR

echo "Your favorite color is: $FAVORITE_COLOR"
```

### Run

```bash
chmod +x variables_demo.sh
./variables_demo.sh
```

---

## ⚙️ Subtask 1.3 – Conditional Statements

Create:

```bash
nano conditions_demo.sh
```

### Code

```bash
#!/bin/bash
# Conditional statements demonstration

echo "=== File and Directory Checker ==="
echo "Enter a file or directory path:"
read PATH_INPUT

if [ -e "$PATH_INPUT" ]; then

    echo "Path exists!"

    if [ -f "$PATH_INPUT" ]; then

        echo "It's a regular file."

        FILE_SIZE=$(stat -c%s "$PATH_INPUT")

        echo "File size: $FILE_SIZE bytes"

        if [ -r "$PATH_INPUT" ]; then
            echo "File is readable."
        else
            echo "File is not readable."
        fi

    elif [ -d "$PATH_INPUT" ]; then

        echo "It's a directory."

        FILE_COUNT=$(ls -1 "$PATH_INPUT" | wc -l)

        echo "Number of items in directory: $FILE_COUNT"

    fi

else

    echo "Path does not exist!"
    echo "Would you like to create it? (y/n)"
    read CREATE_CHOICE

    if [ "$CREATE_CHOICE" = "y" ] || [ "$CREATE_CHOICE" = "Y" ]; then

        echo "Creating directory..."
        mkdir -p "$PATH_INPUT"
        echo "Directory created successfully!"

    else

        echo "No action taken."

    fi

fi
```

### Execute

```bash
chmod +x conditions_demo.sh
./conditions_demo.sh
```

---

## 🔍 Subtask 1.4 – Advanced Conditional Logic

Create:

```bash
nano number_checker.sh
```

### Code

```bash
#!/bin/bash
# Advanced conditional logic demonstration

echo "=== Number Analysis Tool ==="

echo "Enter a number:"
read NUMBER

if ! [[ "$NUMBER" =~ ^-?[0-9]+$ ]]; then
    echo "Error: Please enter a valid integer!"
    exit 1
fi

echo "Analyzing number: $NUMBER"

if [ "$NUMBER" -gt 0 ]; then
    echo "Number is positive"
elif [ "$NUMBER" -lt 0 ]; then
    echo "Number is negative"
else
    echo "Number is zero"
fi

if [ $((NUMBER % 2)) -eq 0 ]; then
    echo "Number is even"
else
    echo "Number is odd"
fi

if [ "$NUMBER" -ge 1 ] && [ "$NUMBER" -le 10 ]; then
    echo "Number is between 1 and 10"
elif [ "$NUMBER" -ge 11 ] && [ "$NUMBER" -le 100 ]; then
    echo "Number is between 11 and 100"
else
    echo "Number is outside range 1-100"
fi

if [ "$NUMBER" -gt 0 ] && [ $((NUMBER % 5)) -eq 0 ]; then
    echo "Number is positive and divisible by 5"
fi
```

### Run

```bash
chmod +x number_checker.sh
./number_checker.sh
```

---

# 🔁 Task 2 – Loops in Shell Scripts

---

## 🔄 Subtask 2.1 – For Loop Examples

Create:

```bash
nano for_loop_demo.sh
```

### Code

```bash
#!/bin/bash

echo "=== Basic For Loop Examples ==="

echo "Counting from 1 to 5:"
for i in {1..5}; do
    echo "Count: $i"
done

echo ""

echo "Programming Languages:"
for language in "Python" "Bash" "JavaScript" "Java" "C++"; do
    echo "- $language"
done

echo ""

echo "Files in Current Directory:"
for file in *.sh; do
    if [ -f "$file" ]; then
        echo "Script file: $file"
    fi
done

echo ""

echo "Even Numbers:"
for ((i=2; i<=10; i+=2)); do
    echo "$i"
done
```

### Run

```bash
chmod +x for_loop_demo.sh
./for_loop_demo.sh
```

---

## 🔁 Subtask 2.2 – While Loop Examples

Create:

```bash
nano while_loop_demo.sh
```

### Code

```bash
#!/bin/bash

echo "=== While Loop Examples ==="

counter=5

while [ $counter -gt 0 ]; do
    echo "T-minus $counter"
    counter=$((counter - 1))
    sleep 1
done

echo "Blast off!"

cat > sample_data.txt << EOF
Apple
Banana
Cherry
Date
Elderberry
EOF

while IFS= read -r line
do
    echo "Fruit: $line"
done < sample_data.txt

choice=""

while [ "$choice" != "4" ]
do
    echo "1. Show Date"
    echo "2. Show User"
    echo "3. Show Directory"
    echo "4. Exit"

    read choice

    case $choice in
        1) date ;;
        2) whoami ;;
        3) pwd ;;
        4) echo "Goodbye!" ;;
        *) echo "Invalid Option" ;;
    esac

done
```

### Run

```bash
chmod +x while_loop_demo.sh
./while_loop_demo.sh
```

---

## 🔂 Subtask 2.3 – Nested Loops

Create:

```bash
nano nested_loops.sh
```

### Code

```bash
#!/bin/bash

echo "Multiplication Table"

for i in {1..5}
do
    for j in {1..5}
    do
        printf "%4d" $((i*j))
    done
    echo
done

echo ""

echo "Pattern"

for i in {1..5}
do
    for j in $(seq 1 $i)
    do
        echo -n "$j "
    done
    echo
done
```

### Run

```bash
chmod +x nested_loops.sh
./nested_loops.sh
```

---

# 🤖 Task 3 – Automation with Shell Scripts

---

## 📊 Subtask 3.1 – System Information Report

Create:

```bash
nano system_info.sh
```

### Code

```bash
#!/bin/bash

REPORT_FILE="system_report_$(date +%Y%m%d_%H%M%S).txt"

echo "System Information Report" > "$REPORT_FILE"
echo "Generated: $(date)" >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"
echo "Hostname: $(hostname)" >> "$REPORT_FILE"
echo "Operating System: $(lsb_release -d | cut -f2)" >> "$REPORT_FILE"
echo "Kernel: $(uname -r)" >> "$REPORT_FILE"
echo "CPU Cores: $(nproc)" >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"
echo "Memory Information" >> "$REPORT_FILE"
free -h >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"
echo "Disk Usage" >> "$REPORT_FILE"
df -h >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"
echo "Network Interfaces" >> "$REPORT_FILE"
ip addr >> "$REPORT_FILE"

echo "Report Generated Successfully"
```

### Run

```bash
chmod +x system_info.sh
./system_info.sh
```

---

## 📂 Subtask 3.2 – File Management Automation

Create:

```bash
nano file_manager.sh
```

### Code

```bash
#!/bin/bash

WORK_DIR="$HOME/file_management_demo"

mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

mkdir -p documents images archives scripts temp

for i in {1..5}
do
    touch document_$i.txt
    touch image_$i.jpg
    touch archive_$i.zip
    touch script_$i.sh
done

mv *.txt documents/ 2>/dev/null
mv *.jpg images/ 2>/dev/null
mv *.zip archives/ 2>/dev/null
mv *.sh scripts/ 2>/dev/null

echo "File Organization Complete"

find .
```

### Run

```bash
chmod +x file_manager.sh
./file_manager.sh
```

---

## 💾 Subtask 3.3 – Backup Automation

Create:

```bash
nano backup_automation.sh
```

### Code

```bash
#!/bin/bash

SOURCE_DIR="$HOME/shell_scripts"
BACKUP_DIR="$HOME/backups/backup_$(date +%Y%m%d_%H%M%S)"

mkdir -p "$BACKUP_DIR"

cp -r "$SOURCE_DIR"/* "$BACKUP_DIR/" 2>/dev/null

echo "Backup Completed"
echo "Backup Location: $BACKUP_DIR"

find "$BACKUP_DIR"
```

### Run

```bash
chmod +x backup_automation.sh
./backup_automation.sh
```

---

# 🛠 Troubleshooting

## ❌ Permission Denied

```bash
chmod +x script_name.sh
```

---

## ❌ Command Not Found

```bash
which command_name
```

Install missing package if required.

---

## ❌ Infinite Loop

Verify loop condition and counter updates.

---

## ❌ File Not Found

```bash
pwd
ls -la
```

Verify file path exists.

---

# 🏆 Skills Gained

✅ Shell Script Development

✅ Variables & User Input

✅ Conditional Statements

✅ For Loops & While Loops

✅ Nested Loop Logic

✅ Linux Automation

✅ System Information Collection

✅ File Management Automation

✅ Backup Automation

✅ Debugging & Troubleshooting

---

# 🎓 Purpose of This Project

The purpose of this project is to build a strong foundation in Linux shell scripting and automation. System administrators and cybersecurity professionals rely heavily on shell scripts to automate repetitive tasks, monitor systems, manage files, generate reports, and perform backups efficiently.

This lab prepares students for:

- Linux System Administration
- Security Operations
- DevOps Automation
- Cloud Infrastructure Management
- Cybersecurity Engineering

By completing this project, students gain practical experience creating real-world automation solutions that improve productivity, reduce manual effort, and support secure Linux environments.

---

# 📜 Conclusion

This lab successfully demonstrated the fundamentals of Linux Shell Scripting. Through hands-on exercises, students learned how to create executable Bash scripts, use variables, implement conditional logic, utilize loops, and automate administrative tasks.

The skills gained from this project form a critical foundation for advanced Linux administration, security automation, DevOps workflows, and enterprise system management.

🚀 Continue expanding these scripts with functions, arrays, logging, scheduling (cron jobs), and advanced error handling to become a proficient Linux Automation Engineer.
