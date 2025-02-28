#!/bin/bash

#服务名字，创建时的那个
SERVICE="palw.service"

#最大允许内存，单位kb。这个数字给swap留了500M空闲内存
MAX_MEMORY=12170908

#Log文件存储位置
LOG_FILE="/home/steam/Steam/steamapps/common/PalServer/shfiles/logs/ram.log"

#获取当前时间
CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')

#检查服务是否正在运行，没有则启动服务
if ! systemctl is-active --quiet $SERVICE; then
	echo "$CURRENT_TIME: The $SERVICE is not running. Starting the service." >> $LOG_FILE
	systemctl start $SERVICE
	echo "$CURRENT_TIME: The $SERVICE has been started. Exiting script." >> $LOG_FILE
	exit 0
fi

searchName=PalServer-Linux

pids=$(ps -ef | grep ${searchName} |grep -v grep |awk '{print $2}')

#获取vmswap内存数
MEMORY_USAGE=$(cat /proc/$pids/status | grep VmSwap|awk '{print $2}')

#获取总内存数
#MEMORY_USAGE=$(ps -C PalServer-Linux -o rss=|awk '{sum+=$1}END{print sum}')

echo $pids

echo "$CURRENT_TIME: Memory (Limit: $MAX_MEMORY KB,Used: $MEMORY_USAGE KB). Don't restart.">> $LOG_FILE

#检查占用内存是否超过规定内存
if [ $MEMORY_USAGE -gt $MAX_MEMORY ]; then
	echo "$CURRENT_TIME: Memory (Limit: $MAX_MEMORY KB,Used: $MEMORY_USAGE KB). Restarting the service.">> $LOG_FILE
	systemctl restart $SERVICE
fi
