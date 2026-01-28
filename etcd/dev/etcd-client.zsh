#!/bin/zsh


curl http://127.0.0.1:2379/health
curl http://127.0.0.1:2479/health
curl http://127.0.0.1:2579/health

#metrics
#curl http://127.0.0.1:2579/metrics

echo "\n"

etcdctl member list

etcdctl --endpoints=127.0.0.1:2379 put mykey hello2

etcdctl --endpoints=127.0.0.1:2479 get mykey
etcdctl --endpoints=127.0.0.1:2579 get mykey


#公共服务发现
# curl https://discovery.etcd.io/new?size=3