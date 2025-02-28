## 创建虚拟内存
-   sudo fallocate -l 12G /yxfile
-   sudo dd if=/dev/zero of=/yxfile bs=1024 count=12682912

        以上命令将创建12GB的虚拟内存。如果要自定义大小，把第一行的12G替换为你所需的大小，第二行的count改成所需GB*1024*1024的值例如12GB=12*1024*1024=12582912


## swap赋权限
-   sudo chmod 600 /yxfile

## 格式化分区
-   sudo mkswap /yxfile

## 启用分区
-   sudo swapon /yxfile

## 分区自启动
-   echo "/yxfile swap swap defaults 0 0" | sudo tee -a /etc/fstab
-   sudo sysctl -w vm.swappiness=100
-   vim /etc/sysctl.conf

        按insert、end，这样会跳转到第一行vm.swappiness = 0 的结尾，把0改成100后，按esc，输入：wq，回车。

        输入reboot等待重启完成

-   输入cat /proc/sys/vm/swappiness
-   显示100说明配置成功
-   输入free -h
-   第二行显示swap 12Gi used 0B free 12Gi
-   说明虚拟内存开启成功

        以上为开服务端的前期准备工作：设置虚拟内存，设置swappiiness=100，意思是积极使用虚拟内存，不要等物理内存爆了再用

## 创建用户名为steam
-   sudo useradd -m steam

## 设置steam用户的密码
-   sudo passwd steam

## sudo apt update
-   之后无脑y和ok

-   sudo apt-get install lib32gcc-s1
-   su - steam//sudo -iu steam
-   mkdir ~/Steam && cd ~/Steam
-   curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
-   ./steamcmd.sh
-   login anonymous
-   app_update 2394010 validate
-   quit
-   cd /home/steam/Steam/steamapps/common/PalServer/
-   ./PalServer.sh

        显示四个绿色succeeded说明运行成功

-   ctrl+c

## 注册为服务
-   以root用户权限在/etc/systemd/system/目录下创建一个服务文件，取名为palw.service。

        [Unit]
        Description=Palworld Server
        After=network.target

        [Service]
        User=steam
        Group=steam
        Type=simple
        ExecStart=/home/steam/Steam/steamapps/common/PalServer/PalServer.sh
        Restart=on-failure

        [Install]
        WantedBy=multi-user.target
---
    After=network.target：当自启动时，在网络服务就绪后再启动该服务

    User 和 Group：运行该服务的用户和组，此处应为steam。

    可通过groups xxx查看用户名所在的组

    ExecStart：服务器运行脚本

    Restart=on-failure：当启动失败时重试

- 保存后退出编辑，执行以下命令

        sudo systemctl daemon-reload
        sudo systemctl enable palw.service

- 这样，就可以让游戏服务器在开机后自动启动了。可以用以下几条指令控制服务：

        开启：		    sudo systemctl start palw.service
        关闭：		    sudo systemctl stop palw.service
        重启：		    sudo systemctl restart palw.service
        查看运行状态:   sudo systemctl status palw.service

#### 设置定时执行脚本
- vim /etc/crontab

        一分钟一次ram.sh

-   ** *  *    * * *   root    /home/steam/Steam/steamapps/common/PalServer/**shfiles/ram.sh > /dev/null

        一小时一次bsave.sh

-   0  */1  * * *   root    /home/steam/Steam/steamapps/common/PalServer/shfiles/bsave.sh > /dev/null

        > /dev/null 2>&1表示运行不输出任何内容 > /dev/null表示只输出错误内容

#### 查看日志
- cat /var/log/syslog
- systemctl restart syslog

#### cron日志输出
- vim /etc/rsyslog.conf
- cron.*	/var/log/cron.log