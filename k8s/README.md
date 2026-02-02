# k8s

##  官网地址： https://kubernetes.io/zh-cn/docs


## k8s常用命令

### ns
```

# 查看minikube状态（全Running即为正常）
minikube status
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
ls /usr/share/nginx/html
curl 127.0.0.1:80
exit

# 5. 查看Pod的IP地址（K8s集群内唯一IP，供集群内访问）
kubectl get pod nginx-pod -o wide

# 6. 【prod环境】创建Pod，显式指定-n prod
kubectl run nginx-pod-prod --image=nginx:1.25-alpine --port=80 -n prod

# 7. 删除Pod（dev环境）
kubectl delete pod nginx-pod
# 删除prod环境Pod
kubectl delete pod nginx-pod-prod -n prod

```




#  minikube
启动本地集群

```
brew install minikube
```








# KubeCm
k8s集群管理工具
官网地址: https://kubecm.cloud/en-us/cli/kubecm_add

