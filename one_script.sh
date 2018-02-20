#!/bin/bash

###output function
echo_green () {
    green=`tput setaf 2`
    reset=`tput sgr0`
    word=$1

    echo $green $word $reset
}

echo_red () {
    red=`tput setaf 1`
    reset=`tput sgr0`
    word=$1

    echo $red $word $reset
}

echo_green "### One Script Shall Install Them All ###"
echo_green "### Start Add PPA and do upgrade first###"
sudo apt-get update
sudo add-apt-repository ppa:ondrej/php -y
sudo add-apt-repository ppa:webupd8team/java -y
##sudo apt-get -y upgrade

echo_green "### Update ###"
sudo apt-get update

echo_green "### Install zsh ###"
sudo apt-get -qy install terminator
sudo apt-get -qy install zsh
sudo chsh -s $(which zsh)
echo_green "### Install CURL & Oh My Zsh! ###"
sudo apt-get -y install curl wget
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo_green "### Install PHP ###"
sudo apt-get -qy install php \
    php-mysql \
    php-soap \
    php-mbstring \
    php-mcrypt \
    php-mongodb \
    php-cli \
    php-xml \
    php-zip \
    php-tokenizer \
    php-pdo \

echo_green "### Install Composer ###"
EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo_red "ERROR: Invalid installer signature"
    rm composer-setup.php
    echo 1
fi

php composer-setup.php --quiet
RESULT=$?
rm composer-setup.php
echo $RESULT

echo_green "### Install GIT ###"
sudo apt-get -y install git

echo_green "### Install python & python3 ###"
sudo apt-get -y install python-pip python-dev python3-pip python3-dev python-software-properties

echo_green "### Install debconf-utils ###"
sudo apt-get -y install debconf-utils

echo_green "### Install thefuck ###"
sudo pip install psutil thefuck

echo_green "### Install htop ###"
sudo apt-get -y install htop

echo_green "### Install NodeJs ###"
sudo apt-get -y install nodejs

echo_green "### Install VIM ###"
sudo apt-get -y install vim

echo_green "### Install JAVA 8 ###"
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-installer

echo_green "### Install Angular CLI ###"
sudo npm install -g @angular/cli

echo_green "### Install Docker ###"
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

echo_green "### Install Docker Compose 1.16.0 ###"
sudo curl -L https://github.com/docker/compose/releases/download/1.16.0-rc1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo_red "### If docker-compose install commad not work , try sudo -i "
echo_red " $ curl -L https://github.com/docker/compose/releases/download/1.16.0-rc1/docker-compose-\`uname -s\`-\`uname -m\` > /usr/local/bin/docker-compose"
echo_red " $ chmod +x /usr/local/bin/docker-compose "
echo_red " $ exit "
