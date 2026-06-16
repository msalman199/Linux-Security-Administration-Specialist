# 🔐 SSH Security and Key Management

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![SSH](https://img.shields.io/badge/SSH-Secure_Shell-4D4D4D?style=for-the-badge&logo=openssh&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Security](https://img.shields.io/badge/Security-Hardening-red?style=for-the-badge&logo=shield&logoColor=white)
![OpenSSH](https://img.shields.io/badge/OpenSSH-Key_Management-000000?style=for-the-badge&logo=openssh&logoColor=white)

> 🛡️ A comprehensive hands-on lab covering **SSH key-based authentication**, **server hardening**, and **ssh-agent key management** — essential skills for securing Linux systems in production environments.

---

## 🎓 Learning Objectives

By the end of this lab, you will be able to:

- ✅ Configure and implement **SSH key-based authentication** for secure remote access
- ✅ Harden SSH server configurations by **disabling root login** and changing default ports
- ✅ Manage SSH keys effectively using **ssh-agent** for secure key handling
- ✅ Understand SSH security best practices and their practical implementation
- ✅ Troubleshoot common SSH configuration issues

---

## 🔧 Prerequisites

| Requirement | Details |
|---|---|
| 💻 CLI Knowledge | Basic Linux command-line operations |
| 📝 Text Editor | Familiarity with `nano`, `vim`, or `gedit` |
| 🔒 Permissions | Knowledge of file permissions and ownership |
| 🌐 Networking | Understanding of network ports and services |
| 👤 User Management | Basic knowledge of user accounts in Linux |

---

## 🖥️ Lab Environment

> 🚀 **Al Nafi** provides ready-to-use Linux cloud machines. Click **Start Lab** to access your pre-configured environment — no VM setup required!

| Detail | Info |
|---|---|
| 🖥️ System | Single Linux machine |
| 🛠️ Tools | All pre-installed |
| ☁️ Platform | Al Nafi Cloud |

---

## 🗝️ Task 1: Set Up Key-Based Authentication for SSH

### 🔑 Subtask 1.1 — Generate SSH Key Pair

> 📌 First, we'll create a new SSH key pair for secure authentication.

#### 🪜 Step 1: Check for existing SSH keys

```bash
ls -la ~/.ssh/
```

#### 🪜 Step 2: Generate a new SSH key pair (RSA 4096-bit)

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

#### 🪜 Step 3: Follow the prompts

```
📂 Press Enter to accept the default file location → /home/username/.ssh/id_rsa
🔏 Enter a strong passphrase when prompted (recommended)
✅ Confirm the passphrase
```

#### 🪜 Step 4: Verify key generation

```bash
ls -la ~/.ssh/
```

> ✅ You should see two files:
>
> | File | Type |
> |---|---|
> | `id_rsa` | 🔴 Private Key — keep this secret! |
> | `id_rsa.pub` | 🟢 Public Key — share this freely |

---

### 🔑 Subtask 1.2 — Set Up Key-Based Authentication

#### 🪜 Step 1: Create a second user account to test SSH authentication

```bash
sudo useradd -m -s /bin/bash testuser
sudo passwd testuser
```

#### 🪜 Step 2: Switch to the testuser account

```bash
sudo su - testuser
```

#### 🪜 Step 3: Create the `.ssh` directory for testuser

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
```

#### 🪜 Step 4: Exit back to your original user

```bash
exit
```

#### 🪜 Step 5: Copy your public key to testuser's authorized_keys

```bash
sudo cp ~/.ssh/id_rsa.pub /home/testuser/.ssh/authorized_keys
sudo chown testuser:testuser /home/testuser/.ssh/authorized_keys
sudo chmod 600 /home/testuser/.ssh/authorized_keys
```

---

### 🔑 Subtask 1.3 — Test Key-Based Authentication

#### 🪜 Step 1: Test SSH connection using keys

```bash
ssh -i ~/.ssh/id_rsa testuser@localhost
```

> 💡 If prompted for the passphrase, enter it — you should log in **without a password**.

#### 🪜 Step 2: Exit the SSH session

```bash
exit
```

---

## 🛡️ Task 2: Harden SSH Configurations

### 🔒 Subtask 2.1 — Backup Original SSH Configuration

#### 🪜 Step 1: Create a backup of the original config

```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
```

#### 🪜 Step 2: View the current configuration

```bash
sudo cat /etc/ssh/sshd_config | grep -E "^[^#]"
```

---

### 🔒 Subtask 2.2 — Disable Root Login

#### 🪜 Step 1: Edit the SSH configuration file

```bash
sudo nano /etc/ssh/sshd_config
```

#### 🪜 Step 2: Disable root login

```bash
PermitRootLogin no
```

#### 🪜 Step 3: Add additional security settings

```bash
# 🔑 Disable password authentication (force key-based auth)
PasswordAuthentication no
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys

# 🚫 Disable empty passwords
PermitEmptyPasswords no

# 🖥️ Disable X11 forwarding if not needed
X11Forwarding no

# ⏱️ Set login grace time
LoginGraceTime 60

# 🔢 Maximum authentication attempts
MaxAuthTries 3

# 👥 Allow specific users only
AllowUsers testuser yourusername
```

---

### 🔒 Subtask 2.3 — Change SSH Port

#### 🪜 Step 1: Find the Port line and change it

```bash
Port 2222
```

> 💾 Save and exit: `Ctrl+X` → `Y` → `Enter` (for nano)

---

### 🔒 Subtask 2.4 — Apply Configuration Changes

#### 🪜 Step 1: Test the configuration for syntax errors

```bash
sudo sshd -t
```

#### 🪜 Step 2: Restart the SSH service

```bash
sudo systemctl restart sshd
```

#### 🪜 Step 3: Verify the service is running

```bash
sudo systemctl status sshd
```

#### 🪜 Step 4: Check if SSH is listening on the new port

```bash
sudo netstat -tlnp | grep :2222
```

---

### 🔒 Subtask 2.5 — Test Hardened SSH Configuration

#### 🪜 Step 1: Test SSH connection on the new port

```bash
ssh -p 2222 -i ~/.ssh/id_rsa testuser@localhost
```

#### 🪜 Step 2: Verify root login is disabled (this should fail ❌)

```bash
ssh -p 2222 root@localhost
```

#### 🪜 Step 3: Exit the test session

```bash
exit
```

---

## 🤖 Task 3: Manage SSH Keys with ssh-agent

### 🧰 Subtask 3.1 — Start and Configure ssh-agent

#### 🪜 Step 1: Start ssh-agent in the background

```bash
eval "$(ssh-agent -s)"
```

#### 🪜 Step 2: Verify ssh-agent is running

```bash
echo $SSH_AGENT_PID
ps aux | grep ssh-agent
```

---

### 🧰 Subtask 3.2 — Add SSH Keys to ssh-agent

#### 🪜 Step 1: Add your private key to ssh-agent

```bash
ssh-add ~/.ssh/id_rsa
```

> 🔏 Enter your passphrase when prompted.

#### 🪜 Step 2: List keys currently managed by ssh-agent

```bash
ssh-add -l
```

#### 🪜 Step 3: Test SSH connection without entering passphrase

```bash
ssh -p 2222 testuser@localhost
```

> ✅ You should now connect **without being prompted** for the passphrase.

#### 🪜 Step 4: Exit the SSH session

```bash
exit
```

---

### 🧰 Subtask 3.3 — Create SSH Agent Startup Script

#### 🪜 Step 1: Create the startup script

```bash
nano ~/.ssh/ssh-agent-startup.sh
```

#### 🪜 Step 2: Add the following content

```bash
#!/bin/bash

# 🤖 SSH Agent startup script
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "🚀 Initializing new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo "✅ succeeded"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add ~/.ssh/id_rsa;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
```

#### 🪜 Step 3: Make the script executable

```bash
chmod +x ~/.ssh/ssh-agent-startup.sh
```

#### 🪜 Step 4: Add to your shell profile

```bash
echo "source ~/.ssh/ssh-agent-startup.sh" >> ~/.bashrc
```

---

### 🧰 Subtask 3.4 — Advanced SSH Key Management

#### 🪜 Step 1: Generate additional SSH keys for different purposes

```bash
# 🐙 GitHub key (Ed25519 — modern & secure)
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_github -C "github_key"

# 🖥️ Server key (RSA 4096-bit)
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_server -C "server_key"
```

#### 🪜 Step 2: Create SSH config file for key management

```bash
nano ~/.ssh/config
```

#### 🪜 Step 3: Add configuration for different hosts

```bash
# 🌐 Default configuration
Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentitiesOnly yes

# 🖥️ Local server configuration
Host localhost
    HostName localhost
    Port 2222
    User testuser
    IdentityFile ~/.ssh/id_rsa

# 🐙 GitHub configuration example
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_github

# ☁️ Server configuration example
Host myserver
    HostName localhost
    Port 2222
    User testuser
    IdentityFile ~/.ssh/id_rsa_server
```

#### 🪜 Step 4: Set proper permissions

```bash
chmod 600 ~/.ssh/config
```

---

### 🧰 Subtask 3.5 — Test Advanced Key Management

#### 🪜 Step 1: Add all keys to ssh-agent

```bash
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/id_ed25519_github
ssh-add ~/.ssh/id_rsa_server
```

#### 🪜 Step 2: List all loaded keys

```bash
ssh-add -l
```

#### 🪜 Step 3: Test connection using SSH config

```bash
ssh localhost
```

#### 🪜 Step 4: Remove a specific key from agent

```bash
ssh-add -d ~/.ssh/id_ed25519_github
```

#### 🪜 Step 5: Remove all keys from agent

```bash
ssh-add -D
```

---

## ✅ Verification and Testing

### 🔍 Security Verification Checklist

#### 🪜 Step 1: Verify SSH hardening settings

```bash
sudo sshd -T | grep -E "(permitrootlogin|passwordauthentication|port|maxauthtries)"
```

#### 🪜 Step 2: Check SSH service status

```bash
sudo systemctl status sshd
sudo ss -tlnp | grep :2222
```

#### 🪜 Step 3: Test security measures

```bash
# ❌ This should FAIL (root login disabled)
ssh -p 2222 root@localhost

# ✅ This should WORK (key-based auth)
ssh -p 2222 testuser@localhost
```

#### 🪜 Step 4: Verify ssh-agent functionality

```bash
ssh-add -l
echo $SSH_AGENT_PID
```

---

## 🛠️ Troubleshooting Common Issues

### 🔴 Issue 1: Permission Denied (publickey)

```bash
# 🔍 Check and fix file permissions
ls -la ~/.ssh/
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/authorized_keys
```

---

### 🔴 Issue 2: SSH Agent Not Working

```bash
# 🔄 Kill existing agents and restart
pkill ssh-agent

# 🚀 Start new agent
eval "$(ssh-agent -s)"

# ➕ Add keys
ssh-add ~/.ssh/id_rsa
```

---

### 🔴 Issue 3: Connection Refused on New Port

```bash
# 🔍 Check if SSH is listening
sudo netstat -tlnp | grep :2222

# 🔥 Check and update firewall settings
sudo ufw status
sudo ufw allow 2222/tcp

# 🔄 Restart SSH service
sudo systemctl restart sshd
```

---

### 🔴 Issue 4: Configuration Syntax Errors

```bash
# 🧪 Test configuration syntax
sudo sshd -t

# 🔁 Restore backup if needed
sudo cp /etc/ssh/sshd_config.backup /etc/ssh/sshd_config
```

---

## 💡 Security Best Practices Summary

| # | Best Practice |
|---|---|
| 🔑 1 | Always use **key-based authentication** instead of passwords |
| 🚫 2 | **Disable root login** via SSH |
| 🔢 3 | **Change default SSH port** to reduce automated attacks |
| 🔏 4 | Use **strong passphrases** for SSH keys |
| 🔄 5 | Regularly **rotate SSH keys** and remove unused ones |
| 👁️ 6 | **Monitor SSH logs** for suspicious activity |
| 🤖 7 | Use **ssh-agent** to manage keys securely |
| 📂 8 | Set **appropriate file permissions** for all SSH files |
| 👥 9 | Limit user access with the **AllowUsers** directive |
| ⬆️ 10 | Keep **SSH software updated** regularly |

---

## 🏁 Conclusion

In this lab, you have successfully implemented comprehensive SSH security measures including:

| ✅ Achievement | Description |
|---|---|
| 🔑 Key-Based Auth | Eliminates password-based vulnerabilities |
| 🛡️ SSH Hardening | Disables root login and changes default ports |
| 🤖 Key Management | Uses ssh-agent for secure and convenient key handling |

These security implementations are crucial for protecting Linux systems in production environments. SSH is often the **primary entry point** for system administration, making its security configuration one of the most important aspects of Linux system hardening.

> ⚠️ **Remember:** Regularly review and update your SSH configurations, monitor access logs, and follow the **principle of least privilege** when granting SSH access to users.

---

<div align="center">

![SSH](https://img.shields.io/badge/SSH-Secure_Shell-4D4D4D?style=for-the-badge&logo=openssh&logoColor=white)
![Security](https://img.shields.io/badge/Security-Hardening-red?style=for-the-badge&logo=shield&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-System_Admin-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Open Source](https://img.shields.io/badge/Open_Source-❤️-red?style=for-the-badge)

*Stay Secure, Stay Sharp! 🔐*

</div>
