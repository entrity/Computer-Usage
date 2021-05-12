# Troubleshooting systemd / systemctl

* Check journalctl, e.g. `journalctl -u sidekiq -rn 20`
* Check the systemd service file (e.g. `/usr/lib/systemd/system/sidekiq.service`) for `StandardOutput` and `StandardError`, and view their outputs in search of error messages. For instance, if `StandardError=syslog`, view `/var/log/syslog`.
