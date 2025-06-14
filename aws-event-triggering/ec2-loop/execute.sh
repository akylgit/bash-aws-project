#!/bin/bash

echo "===== Hostname: $(hostname) ====="
echo "===== Date: $(date) ====="

echo ""
echo "=== 🔧 System Health ==="

# 1. Check memory usage
echo ">> Memory usage:"
free -h
echo ""

# 2. Check disk usage (root + mounted)
echo ">> Disk usage:"
df -h -x tmpfs -x devtmpfs
echo ""

# 3. Check CPU load
echo ">> CPU load:"
uptime
echo ""

# 4. Top memory-consuming processes
echo ">> Top 5 memory-consuming processes:"
ps aux --sort=-%mem | head -n 6
echo ""

# 5. Top CPU-consuming processes
echo ">> Top 5 CPU-consuming processes:"
ps aux --sort=-%cpu | head -n 6
echo ""

# 6. System uptime
echo ">> Uptime:"
uptime -p
echo ""

echo "=== 🔐 Security & Access ==="

# 7. Active SSH sessions
echo ">> Active SSH logins:"
who
echo ""

# 8. Recent login attempts (last 5)
echo ">> Recent logins:"
last -n 5
echo ""

# 9. Failed login attempts (if log available)
echo ">> Failed login attempts:"
grep "Failed password" /var/log/auth.log 2>/dev/null | tail -n 5
echo ""

echo "=== 📦 Services & Processes ==="

# 10. Failed systemd services
echo ">> Failed systemd services:"
systemctl --failed || echo "systemctl not available"
echo ""

# 11. Nginx status (optional)
echo ">> Nginx status:"
systemctl is-active nginx 2>/dev/null || echo "Nginx not installed"
echo ""

# 12. Docker status (optional)
echo ">> Docker status:"
systemctl is-active docker 2>/dev/null || echo "Docker not installed"
echo ""

echo "=== 🌐 Network & Connectivity ==="

# 13. Check network interfaces
echo ">> IP addresses:"
ip a | grep inet
echo ""

# 14. DNS resolution check
echo ">> DNS test:"
dig +short google.com || nslookup google.com || echo "DNS resolution failed"
echo ""

# 15. Ping gateway or external site
echo ">> Ping test (8.8.8.8):"
ping -c 2 8.8.8.8
echo ""

echo "=== ⏰ Time & Sync ==="

# 16. Time settings
echo ">> Time and NTP status:"
timedatectl
echo ""

echo "=== 📁 Scheduled Jobs ==="

# 17. Crontab for current user
echo ">> Crontab entries (current user):"
crontab -l 2>/dev/null || echo "No crontab for current user"
echo ""

echo "===== ✅ End of Daily Health Check for $(hostname) ====="

