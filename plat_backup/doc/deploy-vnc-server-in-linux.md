## VNC Server Config in Linux Environment
- The default Desktop:unity for Ubuntu is not supported for realvnc remote connection
  - `KDE` (kubuntu), `LXDE`(lubuntu), `Xfce`(xubuntu) supported
  - if default Ubuntu version(without leading l-, x-, k-) is installed, access [here](.) for help
### installation
- download the vnc server file from [realvnc official](http://www.realvnc.com/download/vnc/latest/)
  - Linux: Debian(Ubuntu and -based)-compatible [32bit](http://www.realvnc.com/download/get/1715/) [64bit](http://www.realvnc.com/download/get/1716/)
  - Linux: Red Hat(Fodera, CentOS)-compatible [32bit](http://www.realvnc.com/download/get/1717/) [64bit](http://www.realvnc.com/download/get/1718/)
  - if it's the first time you download file from realvnc (no cookies) then email address should be provided before downloading
- `tar -zxvf VNC-5.2.3-Linux-x64-DEB.tar.gz` uncompress it, 2 files will appear
  - one is the Viewer installer wrapper for debain-compatible OS
  - anther is Server deployment installer
- `gdebi VNC-5.2.3-Linux-x64-DEB/VNC-Server-5.2.3-Linux-x64.deb`
  - `gdebi` is a powerful software manager and installer for Debain-compatible OS
  - has been installed in `Server Plat.`
- OK, VNC installation finished
### configuration
- run `vncserver` in CommandLine
- `mv .vnc/xstartup .vnc/xstartup.default && vim .vnc/xstartup`
```bash
#!/bin/sh
DESKTOP_SESSION=kde-plasma
export DESKTOP_SESSION
startkde
vncserver-virtual -kill $DISPLAY
```
  - 1st you should access xsessions to check
  ![xsessions](../sources/xsessions.png)
  - The 1st line session name is not fixed, but proper name suggested
  - the 3rd line should be in accordance with that from the ficture above
- `:wq` and run `vncserver` again
- Now you can access the Server or Host from PC with Viewer
**Addition**
### Licensing
- WHJRK-UXY7V-Q34M9-CZU8L-8KGFA
  - expired at March 28, 2035
  ![key-support](../sources/vnc-key-support.png)



**Reference**
1. [VNC Server in Virtual Mode appears to hang or you see a grey screen because a desktop environment cannot be loaded](https://support.realvnc.com/Knowledgebase/Article/View/345/0/)
2. [Ubuntu 12.04 VNC server 5.0.x [RealVNC] 的配置和使用](http://blog.chinaunix.net/uid-12084847-id-3508474.html)
3. [远程桌面连接工具VNC——license Key](http://blog.sina.com.cn/s/blog_4ba5b45e0102e6dq.html)