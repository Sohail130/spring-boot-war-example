#!/bin/bash

tomcat_setup(){

yum install java-21 -y

cd /opt

wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.97/bin/apache-tomcat-9.0.97.tar.gz

tar -zvxf apache-tomcat-9.0.97.tar.gz && cd apache-tomcat-9.0.97/bin/ && chmod +x startup.sh && chmod +x shutdown.sh
ln -s /opt/apache-tomcat-9.0.97/bin/startup.sh /usr/local/bin/tomcatup && ln -s /opt/apache-tomcat-9.0.97/bin/shutdown.sh /usr/local/bin/tomcatdown

yum install tomcat9-admin-webapps.noarch -y  && yum install git -y

cp -R /opt/apache-tomcat-9.0.97/conf/tomcat-users.xml /opt/apache-tomcat-9.0.97/conf/tomcat-users.xml.bak

TOMCAT_USERS_FILE="/opt/apache-tomcat-9.0.97/conf/tomcat-users.xml"

# Check if the file exists
if [ ! -f "$TOMCAT_USERS_FILE" ]; then
  echo "Tomcat users file does not exist. Exiting."
  exit 1
fi

# Add the necessary lines before the last </tomcat-users> line
sed -i \'/<\\/tomcat-users>/i \\
<role rolename="manager-gui"/>\\n\\
<role rolename="manager-script"/>\\n\\
<role rolename="manager-jmx"/>\\n\\
<role rolename="manager-status"/>\\n\\
<user username="admin" password="admin" roles="manager-gui,manager-script,manager-jmx,manager-status"/>\\n\\
<user username="deployer" password="deployer" roles="manager-script"/>\\n\\
<user username="tomcat" password="password" roles="manager-gui"/>\' $TOMCAT_USERS_FILE

tomcatup

mkdir /home/ec2-user/jenkins ; chown -R ec2-user:ec2-user /home/ec2-user/jenkins ; chmod 755 /home/ec2-user/jenkins

}


check_tomcat_status() {
    # Checking using 'pgrep' to find the Tomcat process
    if [[ "rpm -q tomcat9 &>/dev/null" &&  "pgrep -f "tomcat" > /dev/null" ]]
    then
        echo "Tomcat is running."
 #       return 1  # Return non-zero if running
    else
        echo "Tomcat is not running."
  #      return 0  # Return zero if not running
  #
  tomcat_setup
    fi
}

check_tomcat_status
