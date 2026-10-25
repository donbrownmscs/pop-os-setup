# About
# -----

# This is a set of scripts that help me set up my Pop!_OS machines
# with development tools, some configurations and some other software
# (for example, discord is included).

# Learn more / source: https://github.com/DaniGuardiola/pop-os-setup/

# Usage
# -----

# Method 1 (simplest, recommended)

# Use the downloader (this script):
# $ source <(wget -qO - pop-os.daniguardio.la)

# Method 2 (advanced)

# See instructions: https://github.com/DaniGuardiola/pop-os-setup/

echo -e "\nWelcome to the Pop!_OS setup script by Dani Guardiola"
echo -e "-----------------------------------------------------\n"

echo -e "Source code: https://gist.github.com/DaniGuardiola/def024b7571e8cda4d2043cf50872e1e/"
echo -e "Instructions: http://pop-os.daniguardiola.me/\n\n"

read -p "Press enter to proceed (or ctrl + c to abort)..."
echo

# sudo cache
sudo echo

echo -e "\n> Downloading Pop!_OS install scripts...\n"

cd /tmp
rm -rf pop-os-setup pop-os-setup.zip
wget -O pop-os-setup.zip https://github.com/donbrownmscs/pop-os-setup/archive/refs/heads/main.zip
unzip -q -d pop-os-setup/ pop-os-setup.zip
cd pop-os-setup/pop-os-setup-main/

read -p "Do you want to customize the components to install? y/n " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "\nAn editor will be opened with the component list file. Edit it,"
    echo -e "save the file and close the editor to continue.\n"
    read -p "Press enter to proceed (or ctrl + c to abort)..."
    echo -e "\nWaiting for editor to be closed..."
    gedit components.sh
fi

echo -e "\n\n> Executing Pop!_OS install scripts..."

./run.sh

# load ~/.bashrc
source ~/.bashrc
