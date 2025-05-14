# 说明


保存文件  .curl-format  到自己的家目录下面


````

\n
Request Details:\n
url: %{url_effective}\n
num_redirects: %{num_redirects}\n
content_type: %{content_type}\n
response_code: %{response_code}\n
remote_ip: %{remote_ip}\n
\n
Timing Analysis:\n
time_namelookup: %{time_namelookup}\n
time_connect: %{time_connect}\n
time_appconnect: %{time_appconnect}\n
time_pretransfer: %{time_pretransfer}\n
time_redirect: %{time_redirect}\n
time_starttransfer: %{time_starttransfer}\n
----------\n
time_total: %{time_total}\n
\n

````


# 配置

编辑vim .zshrc

````
alias curltrace='curl -w "@$HOME/.curl-format" -o /dev/null -s'
````






# 结果说明

````
time_namelookup：DNS 域名解析的时候，就是把http://wordpress.com 转换成ip地址的过程
time_connect：TCP 连接建立的时间，就是三次握手的时间
time_appconnect：SSL/SSH等上层协议建立连接的时间，比如 connect/handshake 的时间
time_pretransfer：从请求开始到响应开始传输的时间
time_starttransfer：从请求开始到第一个字节将要传输的时间
time_total：这次请求花费的全部时间
````
