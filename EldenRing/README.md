### 法环无缝联机学习版补丁工具:

    https://703.lanzn.com/b00cs6w5ch
    pwd=1234

### 艾尔登法环无缝联机 (Tailscale) 配置指南 

**1. 基础身份配置（两台电脑必须不同）** 

使用联机脚本确保以下配置：  

* **局域网名称 (account_name)**：设为不同的名字（如 Player_A / Player_B）。  

* **SteamID (account_steamid)**：设为不同的 17 位数字（如末位不同即可）。  

* **联机密码 (cooppassword)**：双方必须**完全一致**。 

**2. 核心：解决 Tailscale 搜不到房 (No Sessions Found)** 

由于 Tailscale 不转发广播包，需手动指定 IP：  

* **路径**：游戏目录 \Game\steam_settings\。  

* **操作**：新建文本文件 custom_broadcasts.txt。  

* **内容**：填写**对方**的 Tailscale IP 地址（100.x.x.x）。  

* *注：双方都要执行此操作，填入对方的 IP。* 

**3. 常见现象说明**  

* **YKNX3_CONNECTING 报错**：联机进入时提示 FORMAT ERROR... 是因为局域网环境无法抓取 Steam 玩家昵称导致的 UI 显示 Bug，**不影响实际联机**。  

* **防火墙**：若连不上，请检查 Windows 防火墙是否放行了游戏程序或临时关闭。