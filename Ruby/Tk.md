# Tk

A gui gem.

## Installation
cf. https://saveriomiroddi.github.io/Installing-ruby-tk-bindings-gem-on-ubuntu/
cf. https://www.ruby-forum.com/t/building-ext-tk-on-ubuntu-14-04/231470/5

```bash
# Install the required version of the (development) libraries:
sudo apt-get install tcl8.6-dev tk8.6-dev
# Ruby extensions are written in C, and they follow the typical steps of a C program build: configuration and compile.
# The gem installation takes care of both, however, on Ubuntu, the Tcl/Tk library files are not found:
# The workaround, originally found in a Ruby forum is to symlink the libraries to the paths where the extension expects them to be:
sudo ln -s /usr/lib/x86_64-linux-gnu/tcl8.6/tclConfig.sh /usr/lib/
sudo ln -s /usr/lib/x86_64-linux-gnu/tk8.6/tkConfig.sh /usr/lib/
sudo ln -s /usr/lib/x86_64-linux-gnu/libtcl8.6.so.0 /usr/lib/
sudo ln -s /usr/lib/x86_64-linux-gnu/libtk8.6.so.0 /usr/lib/
# After this, the gem will install without any problem!:
gem install tk
```
