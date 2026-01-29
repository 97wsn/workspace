#!/bin/zsh

#公共服务发现
# curl https://discovery.etcd.io/new?size=3


curl http://127.0.0.1:2379/health
curl http://127.0.0.1:2479/health
curl http://127.0.0.1:2579/health

#metrics
#curl http://127.0.0.1:2579/metrics

echo "\n"

#查询etcd版本
etcdctl version
# 查询集群列表
etcdctl member list
# 删除所有键
etcdctl del --prefix /

etcdctl --endpoints=127.0.0.1:2379 put mykey hello
etcdctl --endpoints=127.0.0.1:2379 put mykey hello-new
etcdctl --endpoints=127.0.0.1:2479 put mykey2 hello2

etcdctl --endpoints=127.0.0.1:2479 get mykey
etcdctl --endpoints=127.0.0.1:2579 get mykey
#仅读取键的值
etcdctl get mykey --print-value-only
# 读取前缀开头的键 并将结果限制为2个
etcdctl get --prefix --limit=2 mykey
# 访问key的某一个历史版本
etcdctl get --prefix --rev=2 mykey

#监听键的变化(阻塞)
#etcdctl watch mykey
# 监听前缀固定的键(阻塞)
#etcdctl watch --prefix mysql

# 以json格式输出信息
etcdctl get mykey -w=json

#正如我们之前提到的，etcd 会保留版本信息，以便应用程序可以读取键的历史版本。
#但是，为了避免累积过多的历史记录，对历史版本进行压缩至关重要。
#压缩后，etcd 会删除历史版本，从而释放资源供将来使用。所有早于压缩版本的数据都将失效。
#etcdctl compact 5




# 租约
#应用程序可以授予 etcd 集群中密钥的租约。当密钥附加到租约时，
#其生命周期与租约的生命周期绑定，而租约的生命周期又由生存时间 (TTL) 控制。
#每个租约都有一个最小生存时间 (TTL) 值，该值由应用程序在授予租约时指定。租约的实际 TTL 值至少为最小 TTL，
#并由 etcd 集群自动选择。一旦租约的 TTL 到期，租约即失效，所有附加的密钥都将被删除。
# etcdctl lease grant 60 此命令会生成一个租约id
LEASE_ID=$(etcdctl lease grant 5 | awk '{print $2}')
echo ${LEASE_ID}
etcdctl put --lease=${LEASE_ID} foo bar
etcdctl get foo # 5s后 此键就查询不到了

# 获取租约信息
etcdctl lease timetolive ${LEASE_ID}
etcdctl lease timetolive --keys ${LEASE_ID}

# 租约自动续期
#etcdctl lease keep-alive ${LEASE_ID}