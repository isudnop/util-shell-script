#!/bin/bash

###output function
output_green () {
    green=`tput setaf 2`
    reset=`tput sgr0`
    word=$1
    
    echo $green $word $reset
}

output_red () {
    red=`tput setaf 1`
    reset=`tput sgr0`
    word=$1
    
    echo $red $word $reset
}

output_green "### One script by Noppadol M. ###"
output_green "### Start Add PPA and do upgrade first###"
sudo apt-get update
sudo add-apt-repository ppa:ondrej/php
##sudo apt-get -y upgrade

output_green "### Update ###"
sudo apt-get update

output_green "### Install zsh ###"
sudo apt-get -y install terminator
sudo apt-get -y install zsh
sudo chsh -s $(which zsh)
output_green "### Install CURL & Oh My Zsh! ###"
sudo apt-get -y install curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

output_green "### Install PHP ###"
sudo apt-get -y install php php-mysql php-soap php-mbstring php-mcrypt php-mongodb
sudo apt-get -y install wget

output_green "### Install Composer ###"
EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 output_red "ERROR: Invalid installer signature"
    rm composer-setup.php
    echo 1
fi

php composer-setup.php --quiet
RESULT=$?
rm composer-setup.php
echo $RESULT

output_green "### Install GIT ###"
sudo apt-get -y install git

output_green "### Install python ###"
sudo apt-get -y install python-pip python-dev

output_green "### Install thefuck ###"
sudo pip install psutil thefuck

output_green "### Install htop ###"
sudo apt-get -y install htop

output_green "### Install Docker ###"
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get -y install docker-ce
