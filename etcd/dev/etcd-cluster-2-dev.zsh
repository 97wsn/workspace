#!/bin/zsh

TOKEN=token-01
CLUSTER_STATE=new
NAME_1=etcd-01
NAME_2=etcd-02
NAME_3=etcd-03
HOST_1=127.0.0.1
HOST_2=127.0.0.1
HOST_3=127.0.0.1
PORT_API_1=2379
PORT_PEER_1=2380
PORT_API_2=2479
PORT_PEER_2=2480
PORT_API_3=2579
PORT_PEER_3=2580

CLUSTER=${NAME_1}=http://${HOST_1}:${PORT_PEER_1},${NAME_2}=http://${HOST_2}:${PORT_PEER_2},${NAME_3}=http://${HOST_3}:${PORT_PEER_3}

# For every machine
THIS_NAME=${NAME_2}
THIS_IP=${HOST_2}
THIS_PORT_API=${PORT_API_2}
THIS_PORT_PEER=${PORT_PEER_2}
# 用于杀死进程
lsof -i:2479 | awk '{print $2}' | grep -v "PID" | uniq | xargs kill -9

# --enable-v2 支持v2接口，可以省略
# --data-dir 数据存储目录，可以省略
# --name 节点名称，必须
# --initial-advertise-peer-urls  数据在集群内进行交互的url，必须
# --listen-peer-urls  集群节点之间通信监听的url，必须
# --advertise-client-urls 客户通过该地址与本member交互信息，可以省略
# --listen-client-urls 监听客户端请求的url，必须
# --initial-cluster 初始启动的集群配置，必须
# --initial-cluster-state 初始化集群状态，取值为new和existing，可以省略
# --initial-cluster-token 集群初始化token，可以省略
etcd  --data-dir=data.${THIS_NAME} --name ${THIS_NAME} \
        --initial-advertise-peer-urls http://${THIS_IP}:${THIS_PORT_PEER} --listen-peer-urls http://${THIS_IP}:${THIS_PORT_PEER} \
        --advertise-client-urls http://${THIS_IP}:${THIS_PORT_API} --listen-client-urls http://${THIS_IP}:${THIS_PORT_API} \
        --initial-cluster ${CLUSTER} \
        --initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}