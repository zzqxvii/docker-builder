#!/bin/sh
# 如果任何命令出错，直接退出
set -e

# 打印一下 Java 版本，方便你在 docker logs 中确认环境是否正常
# java -version

# 执行传给 docker run 的后续命令
# exec 保证 Java 是容器内的 1 号进程，方便接收停止信号
tail -f  /dev/null
