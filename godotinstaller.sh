#!/bin/sh
# This is Simple Godot Engine Installer Script

# Variable Declarations

INSTALL_DIR="$HOME/Godot/" # To ceate version directory and install perticular version

VERSION="" # For sttoring selected version

MACHINE_TYPE=`uname -m`

BIT=""

DESKTOP_ENTRY="[Desktop Entry]
Type=Application
Name=Godot VERSION
Icon=$HOME/Godot/icon.png
Exec="$HOME/Godot/Godot_vVERSION-stable_x11.BIT"
Comment=Game Engine
Categories=Development;IDE;
Terminal=false
StartupWMClass=Godot"
#-----------------------------------------
#Function Declerations
function main(){

	checkbit

	echo -e "Welcome to Godot Installer
	(1) To Install Godot
	(2) To Uninstall Godot
	(0) To Exit"

	read -p "Enter selection [0,1,2] > "

	if [[ $REPLY =~ ^[0-2]$ ]]; then
		
		if [[ $REPLY == 0 ]]; then
			echo "Exiting Godot Installer"
			exit
		fi

		if [[ $REPLY == 1 ]]; then
			selectversion
		fi

		if [[ $REPLY == 2 ]]; then
			echo "Here Goes Uninstall Code"
		fi

	# else
	# 	echo "Invalid Entry" >&2
	fi
}

#For Downloading Perticular Godot Version to Godot Directory
function download(){
	ceckbit
	echo "Downloading Godot Using wget"
	wget -P $INSTALL_DIR "https://downloads.tuxfamily.org/godotengine/$VERSION/Godot_v$VERSION-stable_x11.$BIT.zip"
	
	echo "Downloading Icon"
	wget -P $INSTALL_DIR "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Godot_icon.svg/2000px-Godot_icon.svg.png"
	cd "$INSTALL_DIR"
	mv "2000px-Godot_icon.svg.png" "icon.png"
	cd
}

#For checking if if Godot Drectory exist or not
function checkdir(){
	echo "Checking if Downoad Directory Exist"
	if [ ! -d "$INSTALL_DIR" ]; then
		echo "Directory Does Not Exist. Creating One"
		mkdir $HOME/Godot
	else
		echo "Directory Already Exist"
	fi
}

#For Making Desktop Entry
function makedesktopentry(){
	echo "Generating Desktp Entry"
	DESKTOP_ENTRY=`echo "${DESKTOP_ENTRY//VERSION/$VERSION}"`
	echo "${DESKTOP_ENTRY//BIT/$BIT}" >> "$HOME/Desktop/Godot_v$VERSION-stable_x11.$BIT.desktop"
	#.local/share/applications/
}

#For Decompressing Downloaded Zip
function decompress(){
	unzip $HOME/Godot/*.zip -d $HOME/Godot/
}

#For deletind downloaded temp files
function delete(){
	echo "Deletind Zip Files From Installation Directory"
	rm $HOME/Godot/*.zip
}

#Function For selecting Installation Version
function selectversion(){
	echo "Select Godot Version To Install
	(1) Godot 3.0.6 - Stable (Prefered)
	(2) Godot 2.1.5 - Old Stable
	(3) Godot 3.1 - Latest Beta Release
	(4) All Versions
	(0) Back to Main Menu"
	read -p "Enter Selection[1,2,3,0] >"

	if [[ $REPLY =~ ^[0-3]$ ]]; then

		if [[ $REPLY == 0 ]]; then
			main
		fi

		if [[ $REPLY == 1 ]]; then
			VERSION="3.0.6"
			echo "Downloading $BIT bit Version of Godot $VERSION"
			download
			decompress
			makedesktopentry
			cleanup
		fi

		if [[ $REPLY == 2 ]]; then
			VERSION="2.1.5"
			echo "Downloading $BIT bit Version of Godot $VERSION"
			download
			decompress
			makedesktopentry
			cleanup
		fi
		if [[ $REPLY == 3 ]]; then
			VERSION="3.1"
			echo "Downloading $BIT bit Version of Godot $VERSION"
			download
			decompress
			makedesktopentry
			cleanup
		fi

		if [[ $REPLY == 4 ]]; then
			echo "Still Needs some work"
		fi
	else
		echo "Invalid Entry" >&4
	fi
}

#For CHecking System Architecture
function checkbit(){
	if [ ${MACHINE_TYPE} == 'x86_64' ]; then
		BIT="64"
	else
		BIT="32"
	fi
}

function cleanup(){
	rm $INSTALL_DIR*.zip
}

# Running Script Calling Main Function
main