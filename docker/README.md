# docker

##  官网地址： https://docs.docker.com/get-started/




## mac安装docker
https://docs.docker.com/desktop/setup/install/mac-install/


## 常用命令

```
#docker 
查看docker客户端所有命令选项
#docker container prune
清理掉所有处于终止状态的容器。
#docker  指令 --help
查看此指令的使用方法


#docker version
显示docker版本信息
#docker info
显示docker 系统信息,包括镜像和容器数

#docker import [OPTIONS] file|URL|- [REPOSITORY[:TAG]]
OPTIONS说明：
-c :应用docker 指令创建镜像；
-m :提交时的说明文字；
从归档文件中创建镜像

#docker images [OPTIONS] [REPOSITORY[:TAG]]
OPTIONS说明：
-a :列出本地所有的镜像（含中间映像层，默认情况下，过滤掉中间映像层）；
--digests :显示镜像的摘要信息；
-f :显示满足条件的镜像；
--format :指定返回值的模板文件；
--no-trunc :显示完整的镜像信息；
-q :只显示镜像ID。
列出本地镜像

#docker rmi [OPTIONS] IMAGE [IMAGE...]
OPTIONS说明：
-f :强制删除；
--no-prune :不移除该镜像的过程镜像，默认移除；
删除本地一个或多个镜像

#docker tag 镜像id 镜像原名:新的标签名
设置镜像标签


#docker build [OPTIONS] PATH | URL | -
OPTIONS说明：
--build-arg=[] :设置镜像创建时的变量；
--cpu-shares :设置 cpu 使用权重；
--cpu-period :限制 CPU CFS周期；
--cpu-quota :限制 CPU CFS配额；
--cpuset-cpus :指定使用的CPU id；
--cpuset-mems :指定使用的内存 id；
--disable-content-trust :忽略校验，默认开启；
-f :指定要使用的Dockerfile路径；
--force-rm :设置镜像过程中删除中间容器；
--isolation :使用容器隔离技术；
--label=[] :设置镜像使用的元数据；
-m :设置内存最大值；
--memory-swap :设置Swap的最大值为内存+swap，"-1"表示不限swap；
--no-cache :创建镜像的过程不使用缓存；
--pull :尝试去更新镜像的新版本；
--quiet, -q :安静模式，成功后只输出镜像 ID；
--rm :设置镜像成功后删除中间容器；
--shm-size :设置/dev/shm的大小，默认值是64M；
--ulimit :Ulimit配置。
--squash :将 Dockerfile 中所有的操作压缩为一层。
--tag, -t: 镜像的名字及标签，通常 name:tag 或者 name 格式；可以在一次构建中为一个镜像设置多个标签。
--network: 默认 default。在构建期间设置RUN指令的网络模式
使用dockerfile创建镜像
例如：使用指定路径的dockerfile创建镜像
docker build -f  ./api/kuaishou-api/Dockerfile .


#docker history [OPTIONS] IMAGE
OPTIONS说明：
-H :以可读的格式打印镜像大小和日期，默认为true；
--no-trunc :显示完整的提交记录；
-q :仅列出提交记录ID。
查看指定镜像的创建历史

#docker save [OPTIONS] IMAGE [IMAGE...]
OPTIONS 说明：
-o :输出到的文件。
将指定镜像保存成 tar 归档文件
#docker load [OPTIONS]
OPTIONS 说明：
--input , -i : 指定导入的文件，代替 STDIN。
--quiet , -q : 精简输出信息。
导入使用 docker save 命令导出的镜像。
# docker export
docker save保存的是镜像（image），docker export保存的是容器（container）
 
 #docker login 
登录需要输入用户名和密码，登录成功后，我们就可以从 docker hub 上拉取自己账号下的全部镜像
#docker logout
退出 docker hub 
#docker pull [OPTIONS] NAME[:TAG|@DIGEST]
OPTIONS说明：
-a :拉取所有 tagged 镜像
--disable-content-trust :忽略镜像的校验,默认开启
从镜像仓库中拉取或者更新指定镜像
#docker push 镜像名称:标签
推送镜像到镜像仓库
#docker search [OPTIONS] TERM
OPTIONS说明：
--automated :只列出 automated build类型的镜像；
--no-trunc :显示完整的镜像描述；
-f <过滤条件>:列出收藏数不小于指定值的镜像。
从镜像仓库查找镜像




#docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
OPTIONS说明：
-a :提交的镜像作者；
-c :使用Dockerfile指令来创建镜像；
-m :提交时的说明文字；
-p :在commit时，将容器暂停。
从容器创建一个新的镜像。
#docker cp 
用于容器与主机之间的数据拷贝
#docker diff [OPTIONS] CONTAINER
检查容器里文件结构的更改。



#docker ps [OPTIONS]
[OPTIONS]：
-a :显示所有的容器，包括未运行的。
-f :根据条件过滤显示的内容。
--format :指定返回值的模板文件。
-l :显示最近创建的容器。
-n :列出最近创建的n个容器。
--no-trunc :不截断输出。
-q :静默模式，只显示容器编号。
-s :显示总的文件大小。
获取容器列表



#docker inspect [OPTIONS] NAME|ID [NAME|ID...]
OPTIONS说明：
-f :指定返回值的模板文件。
-s :显示总的文件大小。
--type :为指定类型返回JSON。
查看 Docker 的底层信息。它会返回一个 JSON 文件记录着 Docker 容器的配置和状态信息
#docker top [OPTIONS] CONTAINER [ps OPTIONS]
查看容器中运行的进程信息，支持 ps 命令参数。
#docker attach 容器id
进入容器内部，退出后，会导致容器停止
#docker events [OPTIONS]
OPTIONS说明：
-f ：根据条件过滤事件；
--since ：从指定的时间戳后显示所有事件;
--until ：流水时间显示到指定的时间为止；
从服务器获取实时事件
#docker logs [OPTIONS] CONTAINER
OPTIONS说明：
-f : 跟踪日志输出
--since :显示某个开始时间的所有日志
-t : 显示时间戳
--tail :仅列出最新N条容器日志
获取容器的日志
#docker wait 容器
阻塞运行直到容器停止，然后打印出它的退出代码。
#docker export [OPTIONS] CONTAINER
OPTIONS说明：
-o :将输入内容写到文件。
将文件系统作为一个tar归档文件导出到STDOUT。
#docker port [OPTIONS] CONTAINER [PRIVATE_PORT[/PROTO]]
列出指定的容器的端口映射，或者查找将PRIVATE_PORT NAT到面向公众的端口。


#docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
[OPTIONS]：
-d, --detach=false， 指定容器运行于前台还是后台，默认为false
-i, --interactive=false， 打开STDIN，用于控制台交互
-t, --tty=false， 分配tty设备，该可以支持终端登录，默认为false
-P, --publish-all=false， 指定容器暴露的端口 随机端口映射，容器内部端口随机映射到主机的端口
-p, --publish=[]， 指定容器暴露的端口，指定端口映射，格式为：主机(宿主)端口:容器端口
--restart="no"， 指定容器停止后的重启策略:
no：容器退出时不重启
on-failure：容器故障退出（返回值非零）时重启
always：容器退出时总是重启
创建一个新的容器（container）
#docker  start 容器id
启动一个已停止的容器
#docker  stop 容器id
停止容器
#docker restart 容器id
重启容器
#docker kill [OPTIONS] CONTAINER [CONTAINER...]
OPTIONS说明：
-s :向容器发送一个信号
杀掉一个运行中的容器。
#docker rm [OPTIONS] CONTAINER [CONTAINER...]
OPTIONS说明：
-f :通过 SIGKILL 信号强制删除一个运行中的容器。
-l :移除容器间的网络连接，而非容器本身。
-v :删除与容器关联的卷。
删除容器
#docker pause 容器
暂停容器中所有的进程。
#docker unpause 容器
恢复容器中所有的进程。
#docker create 镜像
创建一个新的容器但不启动它
#docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
OPTIONS说明：
-d :分离模式: 在后台运行
-i :即使没有附加也保持STDIN 打开
-t :分配一个伪终端
进入容器内部，退出后，不会导致容器停止

例如：
docker exec -it 容器id  /bin/bash 或/bin/sh

进入后：
通过exit命令退出


```