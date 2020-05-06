```bash
# List D-Bus session services
qdbus
# List D-Bus system services
qdbus --system

# List service methods (using gdbus)
gdbus introspect [-s|-e] -d $SERVICE -o $PATH
# List service methods (using dbus-send)
dbus-send [--system|--session] --type=method_call --print-reply --dest=$SERVICE $PATH org.freedesktop.DBus.Introspectable.Introspect
# e.g.
gdbus introspect -e -d org.gnome.ScreenSaver -o /org/gnome/ScreenSaver
dbus-send --system --type=method_call --print-reply --dest=org.gnome.DisplayManager /org/gnome/DisplayManager  org.freedesktop.DBus.Introspectable.Introspect

# Call method (using gdbus)
gdbus call [-y|-e] -d $SERVICE -o $PATH -m $METHOD
# Call method (using dbus-send)
dbus-send [--system|--session] --type=method_call --print-reply --dest=$SERVICE $PATH $METHOD
# e.g.
gdbus call -e -d org.gnome.ScreenSaver -o /org/gnome/ScreenSaver -m org.gnome.ScreenSaver.GetActive
dbus-send --session --type=method_call --print-reply --dest=org.gnome.ScreenSaver /org/gnome/ScreenSaver org.gnome.ScreenSaver.GetActive
```
