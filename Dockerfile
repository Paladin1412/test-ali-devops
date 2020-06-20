FROM golang:latest

# 容器环境变量设置，覆盖默认的变量值
ENV GOPROXY=https://mirrors.aliyun.com/goproxy/,direct
ENV GO111MODULE="on"

# 作者
MAINTAINER bing.ding@neox-inc.com

# 工作区
WORKDIR /go/src/hello-neox

# 复制仓库源文件到容器里
COPY . .

# 编译可执行二进制文件
#RUN go build -o neox-device
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o hello-neox

# help doc: https://docs.docker.com/engine/reference/builder/#from
FROM alpine:latest

WORKDIR /root/

COPY --from=0 /go/src/neox-device/hello-neox .

# 容器向外提供服务的暴露端口
EXPOSE 8000:8000

# 启动服务
ENTRYPOINT ["./hello-neox"]
