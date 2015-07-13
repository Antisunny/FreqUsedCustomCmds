# Deploy Profile on Login
> 在Ubuntu 14.04.4可以正确使用, 其他操作系统环境没有试

* trigger: 用户plant是公共用户。大家都知道密码，而且是有root权限的，然后ssh发现不通，后来发现真个/home/plant目录被格式化了，所有的配置文件啦，隐藏文件啦，.config .cache 等目录都莫名其妙的没有啦，后来才知道是newbee运行了`rm -rf ~`了，真是服了，不论怎么样反正也恢复不了，补救呗。我把所有的配置文件，所有的问题都解决了，但是
* problem: 每次ssh登陆，都不会自动load .bash*中的配置，没有都要`source .bashrc`来复原，真的很烦
* solution: 然后发现有一个文件是该用户没有的`.profile`，拷贝了一份过来发现，额，可以用了 
```bash
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
```