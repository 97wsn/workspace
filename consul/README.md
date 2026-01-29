# consul

## 官网地址： https://developer.hashicorp.com/consul
## 个人整理教程： https://juejin.cn/post/7089016533682225160

## mac安装consul
```
brew tap hashicorp/tap
brew install hashicorp/tap/consul

consul --version
```

## 使用

```
启动本地节点
consul agent -dev

查看节点信息
consul members

```

## 可视化界面
自带的管理界面 
```
http://localhost:8500
```






