# 阶段 1: 拉取 vc-webhook-manager 镜像
FROM docker.io/volcanosh/vc-webhook-manager:latest AS webhook-builder

# 阶段 2: 拉取 vc-controller-manager 镜像
FROM docker.io/volcanosh/vc-controller-manager:latest AS controller-builder

# 阶段 3: 拉取 vc-scheduler 镜像
FROM docker.io/volcanosh/vc-scheduler:latest AS scheduler-builder

# 这里我们用一个空的阶段来作为一个基础镜像
FROM alpine:3.16

# 安装工具 (如果你需要，可以安装一些工具，比如 curl, jq)
RUN apk update && apk add --no-cache curl

# 设置阿里云容器镜像服务的地址
ENV ALIYUN_REGISTRY=registry.cn-hangzhou.aliyuncs.com/wyf-test-boss/spark-on-k8s

# 标记并推送 vc-webhook-manager 镜像
COPY --from=webhook-builder / /tmp/vc-webhook-manager/
RUN echo "vc-webhook-manager 镜像已准备好推送"

# 标记并推送 vc-controller-manager 镜像
COPY --from=controller-builder / /tmp/vc-controller-manager/
RUN echo "vc-controller-manager 镜像已准备好推送"

# 标记并推送 vc-scheduler 镜像
COPY --from=scheduler-builder / /tmp/vc-scheduler/
RUN echo "vc-scheduler 镜像已准备好推送"
