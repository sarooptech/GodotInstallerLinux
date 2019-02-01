#!/bin/sh
# This is Simple Godot Engine Installer Script

# Variable Declarations

MACHINE_TYPE=`uname -m`

INSTALL_DIR="$HOME/Godot/"

DESKTOP_ENTRY="[Desktop Entry]
Type=Application
Name=Godot VERSION
Icon=$HOME/Godot/icon.png
Exec="$HOME/Godot/VERSION/Godot_vVERSION-stable_x11.BIT"
Comment=Game Engine
Categories=Development;IDE;
Terminal=false
StartupWMClass=Godot"

VERSION=""
BIT=""
#-----------------------------------------

echo -e "\e[36mWelcome to Godot Installer
\e[32mClick 1: \e[39mTo Install Godot
\e[32mClick 2: \e[39mTo Uninstall Godot
\e[32mClick 0: \e[39mTo Exit"
read -p "Enter selection [1,2,0] > "

if [[ $REPLY =~ ^[0-2]$ ]]; then
	if [[ $REPLY == 0 ]]; then
		echo "Exiting Godot Installer"
		exit
	fi

	if [[ $REPLY == 1 ]]; then
		echo "Select Godot Godot Version To Install"
		echo "(1) Godot 3.0.6 - Stable (Prefered)"
		echo "(2) Godot 2.1.5 - Old Stable"
		echo "(3) Godot 3.1 - Latest Beta Release"
		echo "(4) Install Export Templates"
		echo "(0) Back to Main Menu"
		read -p "Enter Selection[1,2,3,0] >"
		if [[ $REPLY =~ ^[0-4]$ ]]; then

			if [[ $REPLY == 0 ]]; then
				echo "Back to Main Menu Command"
			fi

			if [[ $REPLY == 1 ]]; then

				VERSION="3.0.6"

				echo "Downloading and Installing Godot 3.0.6"

				if [ ! -d "$INSTALL_DIR" ]; then

					echo "Installation Directory Does not exitst."
					echo "Creating Installation Directory in home directory of current user"
					mkdir $HOME/Godot
					mkdir $HOME/Godot/3.0.6

					if [ ${MACHINE_TYPE} == 'x86_64' ]; then

						BIT="64"

						echo "Downloading 64bit Version of Godot"
						wget -P $HOME/Godot/3.0.6 https://downloads.tuxfamily.org/godotengine/3.0.6/Godot_v3.0.6-stable_x11.64.zip

						echo "Downloading Icon"
						wget -P $HOME/Godot/ https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Godot_icon.svg/2000px-Godot_icon.svg.png
						mv $HOME/Godot/2000px-Godot_icon.svg.png $HOME/Godot/icon.png

					else

						BIT="32"

						echo "Downloading 32bit Version of Godot"
						wget -P $HOME/Godot/3.0.6 https://downloads.tuxfamily.org/godotengine/3.0.6/Godot_v3.0.6-stable_x11.32.zip

						echo "Downloading Icon"
						wget -P $HOME/Godot/ https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Godot_icon.svg/2000px-Godot_icon.svg.png
						mv $HOME/Godot/2000px-Godot_icon.svg.png $HOME/Godot/icon.png

					fi

					unzip $HOME/Godot/3.0.6/*.zip -d $HOME/Godot/3.0.6/

                    echo "Deleting Downloaded Package"
                    rm $HOME/Godot/3.0.6/*.zip

                    echo "Generating Desktp Entry"
                    DESKTOP_ENTRY=`echo "${DESKTOP_ENTRY//VERSION/$VERSION}"`
                    echo "${DESKTOP_ENTRY//BIT/$BIT}" >> Godot_v$VERSION-stable_x11.$BIT.desktop
                    #.local/share/applications/Godot_

				else
					echo "Installation Directory exitst."

					if [ ! -d "$HOME/Godot/3.0.6/" ]; then
						mkdir $HOME/Godot/3.0.6

						if [ ${MACHINE_TYPE} == 'x86_64' ]; then

							BIT="64"

							echo "Downloading 64bit Version of Godot"
							wget -P $HOME/Godot/3.0.6 https://downloads.tuxfamily.org/godotengine/3.0.6/Godot_v3.0.6-stable_x11.64.zip

							echo "Downloading Icon"
							wget -P $HOME/Godot/ https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Godot_icon.svg/2000px-Godot_icon.svg.png
							mv $HOME/Godot/2000px-Godot_icon.svg.png $HOME/Godot/icon.png

						else

							BIT="32"

							echo "Downloading 32bit Version of Godot"
							wget -P $HOME/Godot/3.0.6 https://downloads.tuxfamily.org/godotengine/3.0.6/Godot_v3.0.6-stable_x11.32.zip

							echo "Downloading Icon"
							wget -P $HOME/Godot/ https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Godot_icon.svg/2000px-Godot_icon.svg.png
							mv $HOME/Godot/2000px-Godot_icon.svg.png $HOME/Godot/icon.png

						fi

						echo "Extracting Package"
						unzip $HOME/Godot/3.0.6/*.zip -d $HOME/Godot/3.0.6/

						echo "Deleting Downloaded Package"
						rm $HOME/Godot/3.0.6/*.zip

						echo "Generating Desktp Entry"
						DESKTOP_ENTRY=`echo "${DESKTOP_ENTRY//VERSION/$VERSION}"`
						echo "${DESKTOP_ENTRY//BIT/$BIT}" >> Godot_v$VERSION-stable_x11.$BIT.desktop
						#.local/share/applications/Godot_


					else
						if [ ! -f "$HOME/Godot/3.0.6/Godot_v3.0.6-stable_x11.64.zip" ] || [ ! -f"$HOME/Godot/3.0.6/Godot_v3.0.6-stable_x11.64.zip" ]; then
							echo "Godot 3.0.6 is already installed in your system"
						else
							echo "Something Went Wrong"

						fi
					fi
				fi
			fi

			if [[ $REPLY == 2 ]]; then
				echo "Downloading and Installing Godot 2.1.5"
			fi

			if [[ $REPLY == 3 ]]; then
				echo "Downloading and Installing Godot 3.1 Beta"
			fi

			if [[ $REPLY == 4 ]]; then
				echo "Downloading and Installing Godot Export Templates"
			fi
		else
			echo "Invalid Entry" >&2
		fi
	else
		echo "Invalid entry, Retry" >&2
	fi
	exit
fi
if [[ $REPLY == 2 ]]; then
	echo "Uninstall Godot Commands"
	exit
fi

else
	echo "Invalid entry." >&2
	exit
fi
