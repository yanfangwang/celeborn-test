# 阶段 1: 拉取 vc-webhook-manager 镜像
FROM docker.io/volcanosh/vc-webhook-manager:latest AS webhook-builder

# 阶段 2: 拉取 vc-controller-manager 镜像
FROM docker.io/volcanosh/vc-controller-manager:latest AS controller-builder

# 阶段 3: 拉取 vc-scheduler 镜像
FROM docker.io/volcanosh/vc-scheduler:latest AS scheduler-builder

