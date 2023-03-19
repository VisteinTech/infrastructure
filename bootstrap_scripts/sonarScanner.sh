#!/bin/bash

#change directory to /opt
cd /opt

# download packages
sudo yum install wget unzip -y

#check for java
java -version

if [ $? -eq 0 ]
then
	echo "Java is installed"
else
	echo "Installing Java"
	sudo yum install java-1.8.0-openjdk-devel.x86_64 -y
fi


#downloaad sonar scanner
sudo wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip

#unziping downloaded package
sudo unzip sonar-scanner-cli-3.3.0.1492-linux.zip

#cleaning downloaded zip package
sudo rm -rf sonar-scanner-cli-3.3.0.1492-linux.zip

#/opt/sonar-scanner-cli-3.3.0.1492-linux/bin

#exporting enviromental variables to /etc/environment
echo "export SONAR_SCANNER_HOME=/opt/sonar-scanner-3.3.0.1492-linux" >> /etc/profile
echo 'export PATH=$PATH:$SONAR_SCANNER_HOME/bin' >> /etc/profile

#refreshing the environment file
source /etc/profile

#displaying sonar-scanner version
sonar-scanner -v

