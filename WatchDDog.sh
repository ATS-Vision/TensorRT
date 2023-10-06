#!/bin/bash

# 设置设备权限
echo "12" | sudo -S chmod 777 /dev/ttyUSB0

while true; do
    # 进入项目目录并编译程序
    cd /home/aiit/Desktop/ATS_Tensorrt/build
 #   make -j6

    # 在子 shell 中启动 run 程序，并获取退出状态
    (./run)
    exit_status=$?

    if [ $exit_status -ne 0 ]; then
        echo "Error detected. Restarting..."
        sleep 1
    else
        # 如果没有检测到错误，则退出循环
        break
    fi
done
 
