#!/usr/bin/env bash

#Author :walter52
#Mail :walter52@sohu.com
#Function :docker镜像上传阿里云脚本
#Version :v1.0

# 变量
IMAGE_REPOS=("mid_mysql" "mid_nginx")

# 输入镜像名称和标签
echo "please input image's name:"
read image_name

echo "please input image's tag:"
read image_tag

image=${image_name}:${image_tag}

# 选择上传的镜像仓库
select i in ${IMAGE_REPOS[*]}
do
    case ${i} in
        ${IMAGE_REPOS[0]})
            repos=${i}
            break
            ;;
        ${IMAGE_REPOS[1]})
            repos=${i}
            break
            ;;
    esac
done

# 上传到docker
echo "start login..."
docker login --username=walter52@sohu.com registry.cn-shenzhen.aliyuncs.com
echo "login success!"
docker tag ${image} registry.cn-shenzhen.aliyuncs.com/walter_self/${repos}:${image_tag}
echo "start push image..."
docker push registry.cn-shenzhen.aliyuncs.com/walter_self/${repos}:${image_tag}
echo "push success!"




