#!/bin/bash 

# Global Variables 
LOG=/tmp/stack.log
G="\e[32m"
R="\e[31m"
N="\e[0m"
APPUSER=student 
TOMCAT_VERSION=8.5.49

# Functions
HEAD() {
  echo -e "\n\t\t\e[1;4;33m$1\e[0m\n"
}

STATUS_CHECK() {
  if [ $1 -eq 0 ]; then 
    echo -e "$2 -- ${G}SUCCESS${N}"
  else 
    echo -e "$2 -- ${R}FAILURE${N}"
    exit 1 
  fi 
}

## Web Server Installation 
HEAD "WEB SERVER SETUP"
yum install nginx -y &>>$LOG 
STATUS_CHECK $? "Nginx Server Installation\t"

rm -rf  /usr/share/nginx/html/* &>>$LOG 
STATUS_CHECK $? "Remove old Web Content\t\t"
cd /usr/share/nginx/html
curl -s https://studentapi-cit.s3-us-west-2.amazonaws.com/studentapp-frontend.tar.gz | tar -xz
STATUS_CHECK $? "Download New Web Content\t"

sed -i -e '/location \/student/,+3 d' -e '/^        error_page 404/ i \\t location /student { \n\t\tproxy_pass http://localhost:8080/student;\n\t}\n' /etc/nginx/nginx.conf
STATUS_CHECK $? "Update Configuration File\t"

systemctl enable nginx &>>$LOG
systemctl restart nginx &>>$LOG 
STATUS_CHECK "$?" "Starting Nginx Service\t\t"

## App Server Setup  

HEAD "APP SERVER SETUP"
yum install java -y &>>$LOG 
STATUS_CHECK $? "Installing Java"

id $APPUSER &>>$LOG 
if [ $? -ne 0 ]; then 
  useradd $APPUSER 
  STATUS_CHECK $? "Add Application User"
fi 

cd /home/$APPUSER 
curl -s http://apachemirror.wuchna.com/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz | tar -xz
STATUS_CHECK $? "Download Tomcat"

cd /home/$APPUSER/apache-tomcat-${TOMCAT_VERSION} 
curl -s https://s3-us-west-2.amazonaws.com/studentapi-cit/student.war -o webapps/student.war
STATUS_CHECK $? "Download StudentApp Application"

cd /home/$APPUSER/apache-tomcat-${TOMCAT_VERSION} 
curl -s https://s3-us-west-2.amazonaws.com/studentapi-cit/mysql-connector.jar -o lib/mysql-connector.jar
STATUS_CHECK $? "Download MySQL JDBC Driver"

sed -i -e '/TestDB/ d' -e '/\/Context/ i <Resource name="jdbc/TestDB" auth="Container" type="javax.sql.DataSource" maxTotal="100" maxIdle="30" maxWaitMillis="10000" username="student" password="student1" driverClassName="com.mysql.jdbc.Driver" url="jdbc:mysql://{DBSERVER-IPADDRESS}:3306/studentapp"/>' conf/context.xml 
STATUS_CHECK $? "Add JDBC Configuration"

chown $APPUSER:$APPUSER /home/$APPUSER -R 

curl -s -o /etc/init.d/tomcat https://s3-us-west-2.amazonaws.com/studentapi-cit/tomcat-init 
chmod +x /etc/init.d/tomcat
STATUS_CHECK $? "Download Tomcat INIT Script"

systemctl daemon-reload &>>$LOG 
STATUS_CHECK $? "Reload Systemd Daemon"

systemctl restart tomcat
STATUS_CHECK $? "Start Tomcat Service"
