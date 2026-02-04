
# k9s

```
#k9s info
查看k9s配置文件信息

#k9s
启动k9s  与kubectl相同，k9s启动时读取默认的kubeconfig
如果有多个config文件 可以通过--kubeconfig指定
例如：[root@localhost ~]# k9s --kubeconfig=/srv/.kube/config
#k9s -n pay
进入pay命名空间内

#ctrl+c
退出k9s查看视图


#?
进入k9s之后 按？键可查看所有快捷键操作


#c
复制当前所选(所在)的资源名称


#:pods
输入:pods,按回车回进入以pod为维度的界面
此时按s可进入容器终端

#:deploy
输入:pods,按回车回进入以Deployment为维度的界面,此时按s是修改副本数的
随机选一个 按回车可进入查看pod

#s
进入容器终端命令行

```