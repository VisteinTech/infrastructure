#!/bin/bash

SONARSERVER="https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.8.zip"

#check for java
java -version

if [ $? -eq 0 ]
then
	echo "java is installed"
else
	echo "Installing Java"
	sudo yum install java-11-openjdk-devel -y
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
chown -R sonar:sonar /opt/sonarqube/
chmod -R 775 /opt/sonarqube/

sudo -u sonar /opt/sonarqube/bin/linux-x86-64/sonar.sh start


#configuring sonarqube as a service
# sudo ln /opt/sonarqube/bin/linux-x86-64/sonar.sh /etc/init.d/sonar



# cat <<EOT> /etc/init.d/sonar
# WRAPPER_CMD="/opt/sonarqube/bin/linux-x86-64/wrapper"
# WRAPPER_CONF="/opt/sonarqube/conf/wrapper.conf"
# PIDDIR="/opt/sonarqube/"
# EOT

# #Enable Sonar Service
# systemctl enable sonar
# systemctl start sonar