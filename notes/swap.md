# How to Disable swap in Linux
Why this note: Disabling swap helpful especially when it comes to Kubernetes Deployment

#swap #linux #disable

### **Step 1: Temporarily Disable Swap**

Before making permanent changes, it's a good idea to turn off swap temporarily to prevent any issues during the process.

```bash
sudo swapoff -a
```

---

### **Step 2: Edit the `/etc/fstab` File**

The `/etc/fstab` file contains information about disk partitions and filesystems that should be mounted at boot time, including swap.

Open the file with a text editor using root privileges. You can use `nano`, `vim`, or any editor you're comfortable with. Here, I'll use `nano`:

```bash
sudo nano /etc/fstab
```

---

### **Step 3: Locate the Swap Entry**

In the `/etc/fstab` file, look for a line that defines the swap partition or swap file. It typically looks like one of the following:

- For a swap partition:

  ```
  UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx none swap sw 0 0
  ```

- For a swap file:

  ```
  /swapfile none swap sw 0 0
  ```

---

### **Step 4: Comment Out the Swap Entry**

Disable the swap entry by commenting it out. This prevents the system from activating swap during boot.

Add a `#` at the beginning of the swap line:

- For a swap partition:

  ```bash
  #UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx none swap sw 0 0
  ```

- For a swap file:

  ```bash
  #/swapfile none swap sw 0 0
  ```

---

### **Step 5: Save and Close the File**

- **If using `nano`:**
  - Press `Ctrl + O` to save the changes.
  - Press `Enter` to confirm the filename.
  - Press `Ctrl + X` to exit the editor.

- **If using `vim`:**
  - Press `Esc` to ensure you're in command mode.
  - Type `:wq` and press `Enter` to write changes and quit.

---

### **Step 6: Verify Swap is Disabled**

**Option A: Reboot the System**

Reboot your system to apply the changes:

```bash
sudo reboot
```

**Option B: Verify Without Rebooting**

If you prefer not to reboot immediately, you can verify that swap is disabled:

1. **Check Active Swap Spaces:**

   ```bash
   sudo swapon --show
   ```

   This command should produce no output if swap is disabled.

2. **Confirm Swap Status:**

   ```bash
   free -h
   ```

   Look at the `Swap` line; it should show total, used, and free swap as `0B`.

---

### **Optional: Remove Swap File or Partition (If Applicable)**

If you have a swap file and want to delete it to free up disk space:

- **Delete the Swap File:**

  ```bash
  sudo rm /swapfile
  ```

- **For Swap Partitions:**

  If you used a dedicated swap partition and wish to repurpose it, you'll need to modify your disk partitions using a tool like `fdisk` or `gparted`. **Be cautious** when modifying disk partitions to avoid data loss.

---

### **Summary**

By commenting out the swap entry in `/etc/fstab` and turning off swap with `swapoff -a`, you've disabled swap both temporarily and permanently. The system will no longer activate swap at boot.

---

### **Notes and Considerations**

- **System Performance:** Ensure your system has sufficient RAM to operate without swap. Disabling swap on a system with limited memory can lead to application failures or system instability if the RAM becomes fully utilized.

- **Kubernetes and Swap:** Disabling swap is often recommended for Kubernetes nodes to ensure proper resource management and performance.

- **Re-enabling Swap:** If you need to re-enable swap in the future, simply uncomment the swap line in `/etc/fstab` and activate swap:

  ```bash
  sudo swapon -a
  ```

---
