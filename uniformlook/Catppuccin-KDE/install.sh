#!/bin/sh

# Syntax <Flavour = 1-4 > <Accent = 1-14> <WindowDec = 1/2> <Debug = aurorae/global/color/splash/cursor>

check_command_exists() {
  command_name="${*}"

  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "Error: Dependency '$command_name' is not met."
    echo "Exiting.."
    exit 1
  fi
}

check_command_exists "wget"
check_command_exists "sed"
check_command_exists "unzip"
check_command_exists "lookandfeeltool"

COLORDIR="${XDG_DATA_HOME:-$HOME/.local/share}/color-schemes"
AURORAEDIR="${XDG_DATA_HOME:-$HOME/.local/share}/aurorae/themes"
LOOKANDFEELDIR="${XDG_DATA_HOME:-$HOME/.local/share}/plasma/look-and-feel"
CURSORDIR="${XDG_DATA_HOME:-$HOME/.local/share}/icons"

echo "Creating theme directories.."
mkdir -p "$COLORDIR" "$AURORAEDIR" "$LOOKANDFEELDIR" "$CURSORDIR"
mkdir ./dist

# Fast install
FLAVOUR=1
DEBUGMODE="$4"

clear

GLOBALTHEMENAME="Catppuccin-Mocha-Mauve"

BuildColorscheme() {
    # Add Metadata & Replace Accent in colors file
    sed "s/--accentColor/203,166,247/g; s/--flavour/Mocha/g; s/--accentName/Mauve/g" ./Resources/Base.colors > ./dist/base.colors
    # Hydrate Dummy colors according to Pallet
    ./Installer/color-build.sh -f "Mocha" -o ./dist/Catppuccin"MochaMauve".colors -s ./dist/base.colors
}

BuildSplashScreen() {
    MANTLECOLOR="#181825"

    # Hydrate Dummy colors according to Pallet
    FLAVOURNAME="Mocha" ./Installer/color-build.sh -s ./Resources/splash-screen/contents/splash/images/busywidget.svg -o ./dist/"Catppuccin-Mocha-Mauve-splash"/contents/splash/images/_busywidget.svg
    # Replace Accent in colors file
    sed "s/REPLACE--ACCENT/203,166,247/g" ./dist/"Catppuccin-Mocha-Mauve-splash"/contents/splash/images/_busywidget.svg > ./dist/"Catppuccin-Mocha-Mauve-splash"/contents/splash/images/busywidget.svg
    # Cleanup temporary file
    rm ./dist/"Catppuccin-Mocha-Mauve-splash"/contents/splash/images/_busywidget.svg

    # Hydrate Dummy colors according to Pallet (QML file)
    sed -e s/REPLACE--MANTLE/"$MANTLECOLOR"/g ./Resources/splash-screen/contents/splash/Splash.qml > ./dist/"Catppuccin-Mocha-Mauve-splash"/contents/splash/Splash.qml
    # Add CTP Logo
    if [ "$FLAVOUR" -ne 4 ]; then
        cp ./Resources/splash-screen/contents/splash/images/Logo.png ./dist/"Catppuccin-Mocha-Mauve-splash"/contents/splash/images/Logo.png
    else
        cp ./Resources/splash-screen/contents/splash/images/Latte_Logo.png ./dist/"Catppuccin-Mocha-Mauve-splash"/contents/splash/images/Logo.png
    fi
    #sed "s/--accentName/Mauve/g; s/--flavour/Mocha/g" ./Resources/splash-screen/metadata.desktop > ./dist/"Catppuccin-Mocha-Mauve-splash"/metadata.desktop
	#sed "s/--accentName/Mauve/g; s/--flavour/Mocha/g" ./Resources/splash-screen/metadata.json > ./dist/"Catppuccin-Mocha-Mauve-splash"/metadata.json
    mkdir ./dist/"Catppuccin-Mocha-Mauve-splash"/contents/previews
    cp ./Resources/splash-previews/"Mocha".png ./dist/"Catppuccin-Mocha-Mauve-splash"/contents/previews/splash.png
    # cp ./Resources/splash-previews/"Mocha".png ./dist/"Catppuccin-Mocha-Mauve-splash"/contents/previews/preview.png
    cp -r ./dist/"Catppuccin-Mocha-Mauve-splash"/contents/splash/ "$LOOKANDFEELDIR"/"Catppuccin-Mocha-Mauve"/contents/
    cp -r ./dist/"Catppuccin-Mocha-Mauve-splash"/contents/previews/* "$LOOKANDFEELDIR"/"Catppuccin-Mocha-Mauve"/contents/previews/
}

InstallAuroraeTheme() {
	# Prepare Aurorae Theme Folder
	cp -r ./Resources/Aurorae/Catppuccin"Mocha"-"Classic" ./dist/
    if [ "$FLAVOUR" -eq 4 ]; then
		cp ./Resources/Aurorae/Common/CatppuccinLatte-"Classic"rc ./dist/Catppuccin"Mocha"-"Classic"/Catppuccin"Mocha"-"Classic"rc
	else
		cp ./Resources/Aurorae/Common/Catppuccin-"Classic"rc ./dist/Catppuccin"Mocha"-"Classic"/Catppuccin"Mocha"-"Classic"rc
	fi

	echo "Installing Aurorae Theme..."
	cp -r ./dist/Catppuccin"Mocha"-"Classic"/ "$AURORAEDIR"
}

InstallGlobalTheme() {
    # Prepare Global Theme Folder
    cp -r ./Resources/LookAndFeel/Catppuccin-"Mocha"-Global ./dist/"Catppuccin-Mocha-Mauve"
    mkdir -p ./dist/"Catppuccin-Mocha-Mauve-splash"/contents/splash/images

    # Hydrate Metadata with Pallet + Accent Info
    sed "s/--accentName/Mauve/g; s/--flavour/Mocha/g; s/--StoreAuroraeNo/2135228/g" ./Resources/LookAndFeel/metadata.desktop > ./dist/Catppuccin-"Mocha"-"Mauve"/metadata.desktop
	sed "s/--accentName/Mauve/g; s/--flavour/Mocha/g; s/--StoreAuroraeNo/2135228/g" ./Resources/LookAndFeel/metadata.json > ./dist/Catppuccin-"Mocha"-"Mauve"/metadata.json

    # Modify 'defaults' to set the correct Aurorae Theme
    sed "s/--accentName/Mauve/g; s/--flavour/Mocha/g; s/--aurorae/__aurorae__svg__CatppuccinMocha-Classic/g" ./Resources/LookAndFeel/defaults > ./dist/Catppuccin-"Mocha"-"Mauve"/contents/defaults

    # Install Global Theme.
    # This refers to the QDBusConnection: error: could not send signal to service error
    # Which has had no effect in our testing on the working of this Installer.

    cat <<EOF

 WARNING: There might be some errors that might not affect the installer at all during this step, Please advise.

EOF
    sleep 1
    echo "Installing Global Theme.."
    (
        cd ./dist || exit
        tar -cf "Catppuccin-Mocha-Mauve".tar.gz "Catppuccin-Mocha-Mauve"
        kpackagetool6 -i "Catppuccin-Mocha-Mauve".tar.gz
        cp -r "Catppuccin-Mocha-Mauve" "$LOOKANDFEELDIR"
    )

    # Build SplashScreen
    echo "Building SplashScreen.."
    BuildSplashScreen
}

InstallColorscheme() {
    echo "Building Colorscheme.."

    # Generate Color scheme
    BuildColorscheme

    # Install Colorscheme
    echo "Installing Colorscheme.."
    mv ./dist/Catppuccin"MochaMauve".colors "$COLORDIR"
}

GetCursor() {
    # Fetches cursors
    echo "Downloading Catppuccin Cursors from Catppuccin/cursors..."
    sleep 2
    wget -q -P ./dist https://github.com/catppuccin/cursors/releases/download/v0.2.0/Catppuccin-"Mocha"-"Mauve"-Cursors.zip
    wget -q -P ./dist https://github.com/catppuccin/cursors/releases/download/v0.2.0/Catppuccin-"Mocha"-Dark-Cursors.zip
    (
        cd ./dist || exit
        unzip -q Catppuccin-"Mocha"-"Mauve"-Cursors.zip
        unzip -q Catppuccin-"Mocha"-Dark-Cursors.zip
    )
}

InstallCursor() {
    GetCursor
    sudo cp ./dist/Catppuccin-"Mocha"-"Mauve"-Cursors /usr/share/icons
    sudo cp ./dist/Catppuccin-"Mocha"-Dark-Cursors /usr/share/icons
    mv ./dist/Catppuccin-"Mocha"-"Mauve"-Cursors "$CURSORDIR"
    mv ./dist/Catppuccin-"Mocha"-Dark-Cursors "$CURSORDIR"
}

# Syntax <Flavour> <Accent> <WindowDec> <Debug = aurorae/global/color/splash/cursor>
case "$DEBUGMODE" in
    "")
        CONFIRMATION=y
        clear
        ;;
	aurorae)
		InstallAuroraeTheme
		exit
		;;
    global)
        InstallGlobalTheme
        exit
        ;;
    color)
        BuildColorscheme
        exit
        ;;
    splash)
        # Prepare Global Theme Folder
        GLOBALTHEMENAME="Catppuccin-Mocha-Mauve"

        cp -r ./Resources/LookAndFeel/Catppuccin-"Mocha"-Global ./dist/"Catppuccin-Mocha-Mauve"
        mkdir -p ./dist/"Catppuccin-Mocha-Mauve"/contents/splash/images

        BuildSplashScreen
        ;;
    cursor) GetCursor ;;
    *) echo "Invalid Debug Mode" ;;
esac

if [ "$CONFIRMATION" = "Y" ] || [ "$CONFIRMATION" = "y" ]; then
	# Build and Install Aurorae Theme
    InstallAuroraeTheme

    # Build and Install Global Theme
    InstallGlobalTheme

    # Build Colorscheme
    InstallColorscheme

    echo "Installing Catppuccin Cursor theme.."
    InstallCursor

    # Cleanup
    echo "Cleaning up.."
	  rm -r ./dist

    lookandfeeltool -a "Catppuccin-Mocha-Mauve"
    clear
    # Some legacy apps still look in ~/.icons
    cat <<EOF
The cursors will fully apply once you log out
You may want to run the following in your terminal if you notice any inconsistencies for the cursor theme:
ln -s ~/.local/share/icons/ ~/.icons
EOF
else
    echo "Exiting.."
fi
