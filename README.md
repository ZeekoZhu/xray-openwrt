# xray-tproxy-openwrt

## 环境要求

* 一个用来执行打包脚本的 Linux 环境
* fish shell

## 自行构建ipk安装包

在[前人](https://github.com/felix-fly/xray-openwrt)的基础上，专为 openwrt 打造的适用于[全局透明代理](https://xtls.github.io/document/level-2/tproxy.html)的 xray 安装包

```fish
git clone https://github.com/ZeekoZhu/xray-openwrt.git
```

1. 进入项目目录，调整 `build-tproxy-config.fish` 脚本头部的参数、`sample-config.json`，生成透明代理配置文件
2. 运行 `package.sh`，参数为 CPU 平台，版本不指定默认为最新版

```fish
./build-tproxy-config.fish
./package.sh amd64
```

生成的 ipk 包在当前路径下，形如 **xray-xxx.ipk** 

路由安装后可按需自行修改配置文件

```fish
/etc/xray/config.json
```

需要使用 xray 路由策略也可以自行在此路径下加入 site.dat 等文件

可选的平台参数：

* 386
* amd64
* armv5
* armv6
* armv7
* arm64
* mips
* mipsle
* mips64
* mips64le
* ppc64
* ppc64le

## 一些说明

* `sample-config.json` 与 `package/data/etc/init.d/xray` 搭配使用的话， openwrt 自带的 dnsmasq 的 DNS 功能将会被忽略，所有的 DNS 查询将会通过 xray 的 DNS 模块查询。
* `sample-config.json` 使用了来自 [Loyalsoldier/v2ray-rules-dat](https://github.com/Loyalsoldier/v2ray-rules-dat) 的路由规则文件

## 参考链接

* [透明代理（TProxy）配置教程](https://xtls.github.io/document/level-2/tproxy.html)
* [openwrt主路由iptables透明代理时，路由器自身不能解析域名](https://github.com/XTLS/Xray-core/issues/185#issuecomment-762603549)
* [如何彻底解决高并发时 file descriptor 不够的问题？](https://github.com/wongsyrone/openwrt-Pcap_DNSProxy/issues/46)
* [OpenWrt: procd init script parameters](https://openwrt.org/docs/guide-developer/procd-init-scripts)
* [Fish Shell Documents](https://fishshell.com/docs/current/index.html)
