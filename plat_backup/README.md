## VNC Remote Desktop Mannual
- user: plant, raylee, liuyuhao has the full access to anything in Server Plat. (added into group `sudo`)
- Warnings should be sent to users via email or message before reboot or shutdown
- vnc-related processes should not be killed without warning
- a new remote desktop will be created every time you input `vncserver` in the CommandLine
  - `vncserver -kill :n` n is the RemoteDesktopIndex, should be used when RemoteDesktop:n is no longer used (Recommended)
    - Resources locked for RemoteDesktop:n will not be free if not killed, a waste of computing resources
  - The RemoteDesktop Index is given in the last line every time you input `vncserver` in the CommandLine
  ```text
  VNC(R) Server 5.2.3 (r8648) 64-bit (Jan 28 2015 15:47:49)
  Copyright (C) 2002-2015 RealVNC Ltd.
  VNC is a registered trademark of RealVNC Ltd in the U.S. and in other
  countries.
  Protected by UK patent 2481870; US patent 8760366.
  See http://www.realvnc.com for information on VNC.
  For third party acknowledgements see:
  http://www.realvnc.com/products/vnc/documentation/5.2/acknowledgements.txt

  If a desktop environment fails to load for this virtual desktop, please see:
  http://www.realvnc.com/kb-345
  Running applications in /home/raylee/.vnc/xstartup

  VNC Server catchphrase: "Denmark except giro. Ladder joker truck."
               signature: 9d-68-7f-36-2d-17-71-fa

  Log file is /home/raylee/.vnc/plant-PowerEdge-T620:3.log
  New desktop is plant-PowerEdge-T620:3 (10.157.14.13:3)
  ```
IF YOU ARE INTERESTED IN HOW TO DEPLOY REALVNC SERVER IN LINUX, ACCESS [HERE](./doc/deploy-vnc-server-in-linux.md)