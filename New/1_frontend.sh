#!/bin/bash

# yum install nginx -y
# systemctl enable nginx
# systemctl start nginx

# curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf
COMPONENT=frontend
ID=$(id -u)
if [ $ID -ne 0 ] ; then
  echo -e "\e[31m This is expected to run by a root user with a sudo privelege\e[0m"
  exit 1 
fi
stat(){
if [ $1 -eq 0 ] ; then
  echo -e "\e[32m success \e[0m"
else
  echo -e "\e[31m failure \e[0m"
  fi
}
echo "Installing Nginx :"
yum install nginx -y &>> "/tmp/$COMPONENT.log"
stat $?
  echo -n "Downloading the $COMPONENT component :"
  curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?
echo -n "Performing Cleanup:"
cd /usr/share/nginx/html
rm -rf * &>> "/tmp/$COMPONENT.log"
stat $?

echo -n "Extracting $COMPONENT component"
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

echo -n "Starting $COMPONENT services: "
systemctl enable nginx
systemctl start nginx
stat $?
