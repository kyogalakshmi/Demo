COMPONENT=mongodb
LOGFILE = "/tmp/$COMPONENT.log"
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

echo -n "Configuring the $COMPONENT repo : "
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "Installing $COMPONENT : "
yum install -y $COMPONENT-org     &>> "/tmp/$COMPONENT.log"
stat $?

echo -n "Starting $COMPONENT : "
sudo systemctl enable mongod      &>> "/tmp/$COMPONENT.log"
sudo systemctl start mongod       &>> "/tmp/$COMPONENT.log"
stat $?

echo -n "Enabling the DB Visisbility : "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "Starting $COMPONENT : "
sudo systemctl enable mongod      &>> "/tmp/$COMPONENT.log"
sudo systemctl start mongod       &>> "/tmp/$COMPONENT.log"
stat $?

echo -n "Downloading the $COMPONENT schema : "
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT Schema :"
cd /tmp
unzip mongodb.zip &>> "/tmp/$COMPONENT.log"
stat $?

echo -n "Injecting the Schema : "
cd mongodb-main
mongo < catalogue.js 
mongo < users.js 
stat $?

# *************************Note*****************
# Bash : to comment & un comment :
# ctrl + / (forward slash)
