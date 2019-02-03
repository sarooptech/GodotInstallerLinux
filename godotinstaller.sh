#!/bin/sh
# This is Simple Godot Engine Installer Script

# Variable Declarations

INSTALL_DIR="$HOME/Godot/" # To ceate version directory and install perticular version

VERSION="" # For sttoring selected version

MACHINE_TYPE=`uname -m`

BIT=""

DESKTOP_ENTRY_PATH=".local/share/applications"

DESKTOP_ENTRY="[Desktop Entry]
Type=Application
Name=Godot VERSION
Icon=$HOME/Godot/icon.png
Exec="$HOME/Godot/Godot_vVERSION-stable_x11.BIT"
Comment=Game Engine
Categories=Development;IDE;
Terminal=false
StartupWMClass=Godot"

ICON="$HOME/Godot/icon.png"
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
}

#Function for downloading latest beta
function downloadbeta(){
	checkbit
	echo "Downloading Godot Using wget"
	wget -P $INSTALL_DIR "https://downloads.tuxfamily.org/godotengine/3.1/beta3/Godot_v3.1-beta3_x11.$BIT.zip"

	downloadicon

	echo "Generating Desktp Entry"
	NEW_ENTRY=`echo "${DESKTOP_ENTRY//VERSION/$VERSION}"`
	NEW_ENTRY=`echo "${NEW_ENTRY//stable/beta3}"`
	echo "${NEW_ENTRY//BIT/$BIT}" >> "$HOME/Desktop/Godot_v$VERSION-beta3_x11.$BIT.desktop"
}

#Function for downloading ICON
function downloadicon(){
	if [ -f "$ICON" ]; then
		echo "Icon Already Exist"
	else
		echo "Downloading Icon"
		wget -P $INSTALL_DIR "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Godot_icon.svg/2000px-Godot_icon.svg.png"
		cd "$INSTALL_DIR"
		mv "2000px-Godot_icon.svg.png" "icon.png"
		cd		
	fi
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
	NEW_ENTRY=`echo "${DESKTOP_ENTRY//VERSION/$VERSION}"`

	echo "Checking if Downoad Directory Exist"
	if [ -d "$DESKTOP_ENTRY_PATH" ]; then
		echo "Making Desktop Entry Under Development Section of Your Application Menu"
		echo "${NEW_ENTRY//BIT/$BIT}" >> "$DESKTOP_ENTRY_PATH/Godot_v$VERSION-stable_x11.$BIT.desktop"		
	else
		echo "Local Applications Folder Not Found"
		echo "Making Desktop Entry on Your Desktop"
		echo "${NEW_ENTRY//BIT/$BIT}" >> "$HOME/Desktop/Godot_v$VERSION-stable_x11.$BIT.desktop"
	fi
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
	(4) Install All 3 Versions
	(0) Back to Main Menu"
	read -p "Enter Selection[1,2,3,4,0] >"

	if [[ $REPLY =~ ^[0-4]$ ]]; then

		if [[ $REPLY == 0 ]]; then
			main
		fi

		if [[ $REPLY == 1 ]]; then
			VERSION="3.0.6"
			downloadcommands
		fi

		if [[ $REPLY == 2 ]]; then
			VERSION="2.1.5"
			downloadcommands
		fi
		if [[ $REPLY == 3 ]]; then
			VERSION="3.1"
			echo "Downloading $BIT bit Version of Godot $VERSION"
			downloadbeta
			decompress
			cleanup
		fi

		if [[ $REPLY == 4 ]]; then
			echo "Downloading All $BIT bit Version of Godot"
			VERSION="3.0.6"
			download
			downloadicon
			decompress
			makedesktopentry
			cleanup
			VERSION="2.1.5"
			download
			decompress
			makedesktopentry
			cleanup
			VERSION="3.1"
			downloadbeta
			decompress
			cleanup
		fi
	else
		echo "Invalid Entry"
	fi
}

function downloadcommands(){
	echo "Downloading $BIT bit Version of Godot $VERSION"
			download
			decompress
			downloadicon
			makedesktopentry
			cleanup
}

#For CHecking System Architecture
function checkbit(){
	if [ ${MACHINE_TYPE} == 'x86_64' ]; then
		BIT="64"
	else
		BIT="32"
	fi
}

#For Cleaning Installation Files
function cleanup(){
	rm $INSTALL_DIR*.zip
}

# Running Script Calling Main Function
main