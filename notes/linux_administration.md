---
# SSH Knowhow

#ssh #windows #ubuntu #keypair #copy

### Copying SSH Key Pair from Windows to Ubuntu Server

#### Step-by-Step Commands:

1. **Generate the SSH Key Pair:**
   ```bash
   ssh-keygen -t rsa -b 4096
   ```
   - This creates a 4096-bit RSA key pair.
   - The public key will be saved as `id_rsa.pub` in the `~/.ssh` directory by default.

2. **Copy the Public Key to the Ubuntu Server:**
   ```bash
   type $HOME\.ssh\id_rsa.pub | ssh username@serverA "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
   ```
   - This command pipes the contents of the public key to the Ubuntu server.
   - It appends the public key to the `authorized_keys` file in `~/.ssh`, allowing passwordless SSH.

3. **Verify the Public Key:**
   ```bash
   type $HOME\.ssh\id_rsa.pub
   ```
   - Displays the contents of the `id_rsa.pub` file to confirm its creation.

4. **Connect to the Ubuntu Server:**
   ```bash
   ssh username@serverA
   ```
   - You should now be able to log in without a password if the key was copied correctly.

#### Notes:
- Replace `username` with your actual username on the Ubuntu server.
- Replace `serverA` with the server's IP address or hostname.

---
# sysctl in Linux

**sysctl** is a powerful utility in Linux that allows you to view and modify kernel parameters at runtime. These parameters control various aspects of the kernel's operation, such as networking behavior, virtual memory management, and system security settings. By using `sysctl`, administrators can fine-tune the system's performance and behavior without the need to reboot.

### How sysctl Works

The Linux kernel exposes its tunable parameters via the **`/proc/sys/`** virtual filesystem. Each parameter is represented as a file within this directory hierarchy. The `sysctl` command provides a convenient interface to read and write these parameters.

### Basic Usage

#### Viewing Kernel Parameters

To display the value of a specific kernel parameter, you can use:

```bash
sysctl variable_name
```

For example, to view the value of the `net.ipv4.ip_forward` parameter:

```bash
sysctl net.ipv4.ip_forward
```

Alternatively, you can read the value directly from the corresponding file:

```bash
cat /proc/sys/net/ipv4/ip_forward
```

#### Modifying Kernel Parameters

To change the value of a kernel parameter at runtime:

```bash
sysctl -w variable_name=value
```

For example, to enable IP forwarding:

```bash
sysctl -w net.ipv4.ip_forward=1
```

You can also write directly to the file:

```bash
echo 1 > /proc/sys/net/ipv4/ip_forward
```

However, using `sysctl` is generally preferred because it handles type conversions and validation.

### Making Changes Persistent

Changes made with `sysctl` or by writing to `/proc/sys/` files are temporary and will be reset after a reboot. To make changes persistent across reboots, you need to add them to the **`/etc/sysctl.conf`** file or place configuration files in the **`/etc/sysctl.d/`** directory.

For example, to persistently enable IP forwarding, add the following line to `/etc/sysctl.conf`:

```bash
net.ipv4.ip_forward = 1
```

After editing the file, apply the changes with:

```bash
sysctl -p
```

### Commonly Tuned Parameters

#### Networking

- **`net.ipv4.ip_forward`**: Enables IP forwarding between network interfaces.
- **`net.core.somaxconn`**: Defines the maximum number of connections that can be queued for acceptance.
- **`net.ipv4.tcp_syncookies`**: Enables SYN cookies to protect against SYN flood attacks.

#### Virtual Memory

- **`vm.swappiness`**: Controls the tendency of the kernel to swap memory pages.
- **`vm.dirty_ratio`**: The percentage of system memory that can be filled with "dirty" pages before writing to disk.

#### File System

- **`fs.file-max`**: Specifies the maximum number of file handles that the kernel can allocate.
- **`fs.inotify.max_user_watches`**: Limits the number of file watches per user for `inotify`.

### Security Considerations

Modifying kernel parameters can significantly impact system behavior and security. For example:

- Disabling certain network protections might expose the system to attacks.
- Incorrect memory settings could lead to system instability.

Always ensure that you understand the implications of changing a parameter and, if possible, test changes in a controlled environment before applying them to production systems.

### Scripting with sysctl

`sysctl` can be used within scripts to automate system configuration. For example, a script to optimize network settings might include:

```bash
#!/bin/bash
sysctl -w net.core.rmem_max=26214400
sysctl -w net.core.wmem_max=26214400
sysctl -w net.ipv4.tcp_rmem="4096 87380 26214400"
sysctl -w net.ipv4.tcp_wmem="4096 16384 26214400"
```

### Additional Options

- **`sysctl -a`**: Lists all available kernel parameters and their current values.
- **`sysctl -p /path/to/file`**: Loads sysctl settings from a specified file.

### Summary

`sysctl` is an essential tool for Linux system administration, providing dynamic control over kernel parameters. It enables real-time tuning and configuration adjustments without requiring system restarts, facilitating efficient management of system performance and behavior.

**References**

- `man sysctl`: The manual page provides detailed information about usage and options.
- **Linux Kernel Documentation**: Offers in-depth explanations of various kernel parameters.
