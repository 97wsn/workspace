# mac开发工具

##  homebrew
下载地址： https://brew.sh/

常用命令：

```

查看brew版本：brew -v
更新brew版本：brew update 
本地软件库列表：brew list
查看软件库版本：brew list --versions
查找软件包：brew search xxx （xxx为要查找软件的关键词）
更新某个软件包 brew upgrade xxx
安装软件包：brew install xxx （xxx为软件包名称）
卸载软件包：brew uninstall xxx
安装软件：brew cask install xxx（xxx为软件名称）
卸载软件：brew cask uninstall xxx
显示软件内容信息  brew info xxx
用浏览器打开  brew home 会打开安装界面
清理软件的旧版 brew cleanup xxx
如果你的homebre没有办法正常工作 可以执行brew doctor来开启homebrew自带的检查
brew list 软件名 查看软件安装目录


```


## iterm2
下载地址： https://iterm2.com/index.html

常用命令：https://www.cnblogs.com/liqiangchn/p/14280203.html



```
Command +N
新建windows
Command +w
关闭windows
Command +Enter
全屏 再按一次还原
Command + Option + e
展示所有窗口

Command + t
新建标签

Command + 数字 或者 Command + 左/右方向
切换标签

Command + Shift + h
历史剪切板

Command+f
即可完成搜索，搜索后，通过Tab 或者 Tab + Shift可向右或向左扩大选中范围，完成复制。

Command + ;
历史命令提示

Command + Option + b
非常有意思的功能，像录屏一样，记录过去一段时间内窗口显示的内容。
前进/后退：左右箭头/鼠标拖动进度条**
退出回放：esc

Command + r 或者 ctrl + l
清屏
Ctrl + u
清除当前行
Ctrl + d
删除当前光标的字符
Ctrl + h
删除光标之前的字符
Ctrl + w
删除光标之前的单词
Ctrl + k
删除到文件末尾
Ctrl + a
光标移动到行首
Ctrl + e
光标移动到行位



```




## ohmyzsh
下载地址： https://ohmyz.sh/

常用插件：
zsh-syntax-highlighting  zsh-autosuggestions



```

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


 git clone git://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


```

vim .zshrc 加上如下配置

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source .zshrc即可生效







