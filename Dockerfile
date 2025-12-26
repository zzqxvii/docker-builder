# 使用 Alpine Linux 作为基础镜像
FROM alpine:latest
# 安装 bash
RUN apk add --no-cache bash
# 设置 bash 作为默认 shell
SHELL ["/bin/bash", "-c"]
# 确认安装成功
RUN bash --version
# 设置镜像标签
LABEL description="Alpine Linux with bash"
LABEL maintainer="NAME"
