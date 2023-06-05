Action=$1

case $Action in
start)
echo "starting RabbitMQ Service"
;;
stop)
echo "Stopping the RabbitMQ Service"
;;
restart)
echo "Restarting the RabbitMQ Service"
;;
*) # it includes everything  & like default in switch case
echo "Possible values are start or stop or restart"
;;
esac