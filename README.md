# Godot Installer Linux (On hold currently because of lack of time.)
Shell Script to Install Godot Engine using Terminal.

# Features
* You can Install  **3.1.1 Stable**, **3.0.6 Stable** & **2.1.5 Stable**.
* Option for Installing all 3 versions at a time.
* Automatically generates Desktop entries for Applications Menu.

# Requirements
Almost every tool mentioned below comes preinstalled on every Mejor Linux Distros, If don't then install them using your default package manager.
* Linux
* wget
* unzip
* uname

# How to Install
Open Terminal and run following commands:
```bash
$ git clone https://github.com/samdaiya/GodotInstallerLinux
```
```bash
$ cd GodotInstallerLinux
```
```bash
$ sh godotinstaller.sh
```
Use These two commands if previous command gives an error.
```bash
$ chmod +x godotinstaller.sh
```
```bash
$ ./godotinstaller.sh
```
* To change a Installation path open script and change INSTALL_DIR="YourPathHere".

Now Just Input Installation Choices and hit Enter. That's it.

# Warnings
* I have only tested this script on Manjaro Linux yet. It Should work for other destros like Arch, Debian, Fedora, etc.
* Try it yourself, check if it works and if it's not working then let me know. 

# References
* [Godot Engine][1] - Free and open source 2D and 3D game engine
* [Godot Icon][2] - Wikimedia

[1]: https://godotengine.org
[2]: https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Godot_icon.svg/2000px-Godot_icon.svg.png
