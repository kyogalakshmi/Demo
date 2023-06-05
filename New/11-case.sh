Action=$1

case $Action in
start)
echo -e "\e[32m starting RabbitMQ Service \e[0m"
;;
stop)
echo -e "\e[31m Stopping the RabbitMQ Service\e[0m"
;;
restart)
echo "Restarting the RabbitMQ Service"
;;
*) # it includes everything  & like default in switch case
echo "Possible values are start or stop or restart"
;;
esac