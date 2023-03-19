#!/bin/bash

SONARSERVER="https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.8.zip"

#check for java
java -version

if [ $? -eq 0 ]
then
	echo "java is installed"
else
	echo "Installing Java"
	sudo yum install java-1.8.0-openjdk.x86_64 -y
fi

if [ -e "/opt/sonarqube"]
then
	echo "Directory exists"
else
	echo "setting up directory for sonarqube"
	#creating system user for sonarQube
	sudo mkdir /opt/sonarqube
	useradd -m -U -d /opt/sonarqube/ sonar
	sudo echo "sonar ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/sonar
fi
	

cd /opt


#install packages
sudo yum install wget unzip -y

#download sonar server
sudo wget $SONARSERVER

#unziping zipped package
sudo unzip /opt/sonarqube-*.zip

#move files
sudo mv /opt/sonarqube-*/* /opt/sonarqube/

#cleaning folder/zipped package
sudo rm -rf sonarqube-*


#setting ownership and permissions
chown -R sonar:sonar /opt/sonarqube/sonarqube-*/
chmod -R 775 /opt/sonarqube/sonarqube-*/

#configuring sonarqube as a service
sudo ln /opt/sonarqube/sonarqube-*/bin/linux-x86-64/sonar.sh /etc/init.d/sonar

cat <<EOT> /etc/init.d/sonar
SONAR_HOME=/opt/sonarqube PLATFORM=linux-x86-64
WRAPPER_CMD="${SONAR_HOME}/bin/${PLATFORM}/wrapper"
WRAPPER_CONF="${SONAR_HOME}/conf/wrapper.conf"
PIDDIR="/opt/sonarqube/"
EOT
#Enable Sonar Service
systemctl enable sonar
systemctl start sonar