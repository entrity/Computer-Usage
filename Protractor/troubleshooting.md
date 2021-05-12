# Troubleshooting Protractor / ChromeDriver

## This version of ChromeDriver only supports Chrome version ...

If you get an error along the lines of `This version of ChromeDriver only supports Chrome version...`:

1. Check your ChromeDriver version: `webdriver-manager status`. I had success with the following:
```bash
user@workstation:~/insureio$ PATH="$PATH:node_modules/protractor/bin/"
user@workstation:~/insureio$ webdriver-manager status
[11:56:12] I/status - selenium standalone version available: 3.141.59 [last]
[11:56:12] I/status - chromedriver version available: 80.0.3987.106 [last]
[11:56:12] I/status - geckodriver version available: v0.26.0 [last]
[11:56:12] I/status - android-sdk is not present
[11:56:12] I/status - appium is not present
user@workstation:~/insureio$ webdriver-manager clean # Remove existing webdrivers
user@workstation:~/insureio$ webdriver-manager update --versions.chrome=80.0.3987.106
```

2. Check your installed version of google chrome. Do you have a recent version? If not, it may be worth downloading and installing the latest version, then runing the update again:
```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo yum localinstall google-chrome-stable_current_x86_64.rpm
webdriver-manager update
# And then restart the webdriver-manager's server (if running)
```
