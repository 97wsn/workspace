# k8s

##  官网地址： https://kubernetes.io/zh-cn/docs




## k8s常用命令

### ns
```

# 查看k8s节点（状态Ready）
kubectl get nodes
# 查看当前所有namespace
kubectl get ns

# 1. 创建dev（开发）、prod（生产）命名空间（命令行快速创建）
kubectl create ns dev
kubectl create ns prod

# 2. 查看所有namespace，确认dev/prod创建成功
kubectl get ns

# 3. 查看指定namespace详情（如dev，含标签、资源配额、事件）
kubectl describe ns dev

#  先获取当前使用的context（minikube环境默认context为minikube）
kubectl config current-context
# 输出应为：minikube

# 永久设置该context的默认namespace为dev
kubectl config set-context minikube --namespace=dev
```

### pod
```

1. 直接创建Pod，命名为nginx-pod，使用nginx公有镜像
kubectl run nginx-pod --image=nginx:1.25-alpine --port=80

# 2. 查看dev环境下Pod状态（Pending→ContainerCreating→Running即为正常）
kubectl get pods
# 补充：查看所有命名空间Pod（含kube-system系统Pod）
kubectl get pods -A
# 补充：查看Pod详细信息（IP、镜像、容器、事件，排错核心命令）
kubectl describe pod nginx-pod

# 3. 查看Pod内部日志（验证nginx是否正常启动，核心调试命令）
kubectl logs nginx-pod
# 实时查看日志（类似tail -f，适合排查运行中问题）
kubectl logs -f nginx-pod

# 4. 进入Pod内部容器（交互式终端，模拟在容器内操作）
kubectl exec -it nginx-pod -- /bin/sh
# 容器内操作：查看nginx配置、测试端口，执行完输入exit退出
ps -a
curl 127.0.0.1:80
exit

# 5. 查看Pod的IP地址（K8s集群内唯一IP，供集群内访问）
kubectl get pod nginx-pod -o wide

# 6. 【prod环境】创建Pod，显式指定-n prod
kubectl run nginx-pod-prod --image=nginx:1.25-alpine --port=80 -n prod

# 7. 删除Pod（dev环境）
kubectl delete pod nginx-pod -n dev
# 删除prod环境Pod
kubectl delete pod nginx-pod-prod -n prod

```

## deployment

```
## 创建deployment  副本数为2
kubectl create deployment nginx-deploy --image=nginx:alpine --replicas=2 -n k8s-learn


## 查看Deployment状态（副本数、可用数、更新状态）
kubectl get deploy -o wide


## 查看Deployment详细信息（事件、策略、控制器关联）
kubectl describe deploy nginx-deploy

# 查看Deployment的滚动更新历史（后续更新镜像用）
kubectl rollout history deploy nginx-deploy 

# 扩缩容：修改Pod副本数为4 -n 制定namespace为default的空间下的
kubectl scale deploy nginx-deploy --replicas=4 -n default
 
# 更新镜像：将Nginx升级为1.25-alpine（滚动更新，不中断服务）
kubectl set image deploy nginx-deploy nginx=nginx:1.25-alpine 

# 查看更新进度（验证滚动更新是否完成）
kubectl rollout status deploy nginx-deploy

# 回滚：若更新失败，回滚到上一个版本
kubectl rollout undo deploy nginx-deploy

# 故障自愈能力 手动删除一个由Deployment管理的Pod（替换为你的Pod名称）
kubectl delete pod nginx-deploy-xxxx-xxxx 
# 立即查看Pod，会发现Deployment自动重建一个新Pod，保持副本数为3
kubectl get pod 


```

## service
Pod 的 IP 是临时的，Service 用于为 Pod 提供固定的集群内访问地址，并实现 Pod 的负载均衡，K8s 中 Service 分 3 种核心类型：
ClusterIP：默认类型，仅集群内可访问（本次先用）；
NodePort：通过节点 IP + 固定端口暴露（集群外临时访问）；
LoadBalancer：云厂商专属，自动分配公网负载均衡器。


### 1. 创建 ClusterIP 类型 Service（关联 Deployment 的 Pod，集群内访问）

```

# 创建Service，名称nginx-svc，关联标签app=nginx-deploy的Pod（Deployment默认标签），暴露80端口
# --port：Service的端口；--target-port：Pod内容器的端口（Nginx默认80）

kubectl expose deploy nginx-deploy --name=nginx-svc --port=80 --target-port=80 


# 查看Service基本信息（CLUSTER-IP是集群内固定IP，PORT(S)是暴露的端口）
kubectl get svc  -o wide

# 查看Service详细信息（关联的Pod、标签选择器、Endpoints等）
kubectl describe svc nginx-svc 
# 查看Service关联的Endpoints（即Pod的IP+端口，验证Service是否正确绑定Pod）
kubectl get endpoints nginx-svc 

# 在集群内任意节点/Pod中，通过Service的CLUSTER-IP访问Nginx
curl <Service的CLUSTER-IP>:80
# 或通过Service名称（集群内同ns可直接用名称）
curl nginx-svc:80
# 跨ns访问格式：curl 服务名.命名空间名.svc.cluster.local:80
curl nginx-svc.default.svc.cluster.local:80

```

### 2.创建 NodePort 类型 Service（集群外临时访问，替代 Ingress 测试）

```

# 删除原有ClusterIP Service（避免端口冲突）
kubectl delete svc nginx-svc
# 创建NodePort类型Service，暴露80端口为节点随机端口（30000-32767）
kubectl expose deploy nginx-deploy --name=nginx-svc --port=80 --target-port=80 --type=NodePort -n k8s-learn
# 查看NodePort端口（PORT(S)列：80:3xxxx/TCP，3xxxx就是节点端口）
kubectl get svc 
# 集群外访问：节点IP+NodePort端口（Minikube可执行minikube ip获取节点IP）
curl <节点IP>:<3xxxx端口>


```

