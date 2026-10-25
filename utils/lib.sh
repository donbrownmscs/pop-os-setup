# load aliases
shopt -s expand_aliases
touch ~/.bash_aliases
source ~/.bash_aliases

# find absolute path to tmp dir
TMP_DIR=$(pwd)
while [ ! -z "$TMP_DIR" ] && [ ! -f "$TMP_DIR/README.md" ]; do
    TMP_DIR="${TMP_DIR%\/*}"
done
TMP_DIR="$TMP_DIR/tmp"

bashrc () {
    # Idempotently add text to ~/.bashrc
    # $1: section id
    # $2: text to add
    START_LINE_TEXT="# Pop! OS setup script: $1 start"
    END_LINE_TEXT="# $1 end"
        
    START_LINE=$(grep -Fn "$START_LINE_TEXT" ~/.bashrc | cut -f 1 -d ':')
    END_LINE=$(grep -Fn "$END_LINE_TEXT" ~/.bashrc | cut -f 1 -d ':')

    if [[ -z $START_LINE ]]
    then
      echo "Adding $1 section to .bashrc..."
    else
      echo "Replacing $1 section in .bashrc..."
      sed -i.bak -e "$START_LINE,${END_LINE}d" ~/.bashrc
    fi

    echo "$START_LINE_TEXT" >> ~/.bashrc
    echo -e $2 >> ~/.bashrc
    echo "$END_LINE_TEXT" >> ~/.bashrc
}

bash_aliases () {
    # Idempotently add text to ~/.bash_aliases
    # $1: section id
    # $2: text to add
    START_LINE_TEXT="# Pop! OS setup script: $1 start"
    END_LINE_TEXT="# $1 end"
        
    START_LINE=$(grep -Fn "$START_LINE_TEXT" ~/.bash_aliases | cut -f 1 -d ':')
    END_LINE=$(grep -Fn "$END_LINE_TEXT" ~/.bash_aliases | cut -f 1 -d ':')

    if [[ -z $START_LINE ]]
    then
      echo "Adding $1 section to .bash_aliases..."
    else
      echo "Replacing $1 section in .bash_aliases..."
      sed -i.bak -e "$START_LINE,${END_LINE}d" ~/.bash_aliases
    fi

    echo "$START_LINE_TEXT" >> ~/.bash_aliases
    echo -e $2 >> ~/.bash_aliases
    echo "$END_LINE_TEXT" >> ~/.bash_aliases
}

log () {
    # log section name with good formatting
    # $1: string to log
    echo -e "\n\n> $1\n"
}

deb () {
    # download and install a deb file and then fix any broken dependencies with apt install -f
    # $1: deb file URL
    name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    wget -O "$TMP_DIR/$name.deb" $1
    sudo dpkg -i "$TMP_DIR/$name.deb"
    sudo apt install -fy
}

exit-if-installed () {
    # exits the current script if the command exists
    # $1: command to test
    if [ -n "$(command -v $1)" ]; then
        echo "'$1' already exists, skipping..."
        exit 1
    fi
}