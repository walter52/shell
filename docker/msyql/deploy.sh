#!/usr/bin/env bash

#Author :walter52
#Mail :walter52@sohu.com
#Function :docker镜像上传阿里云脚本
#Version :v1.0
#在vim中用"set ff=unix"切换格式或者使用"dos2unix"命令

# 上传到镜像仓库
# $1:repos,$2:image_tag，$3:image_name
function uploadRepos(){
    docker login --username=walter52@sohu.com registry.cn-shenzhen.aliyuncs.com
    docker tag $3:$2 registry.cn-shenzhen.aliyuncs.com/walter_self/$1:$2
    docker push registry.cn-shenzhen.aliyuncs.com/walter_self/$1:$2
}

# 选择上传的仓库
# $*:仓库列表
function chooseRepos(){
    select i in $*
    do
        case ${i} in
            ${IMAGE_REPOS[0]})
                result=${i}
                break
                ;;
            ${IMAGE_REPOS[1]})
                result=${i}
                break
                ;;
        esac
    done
    echo ${result}
}

# 启动容器
# $1:命令参数，$2:目标镜像
function start_contain(){
    docker run $1 $2
}

###############################

# 变量
IMAGE_REPOS=("mid_mysql" "mid_nginx")

# 输入镜像名称和标签
echo "输入镜像名称:"
read image_name

echo "输入镜像tag:"
read image_tag

image=${image_name}:${image_tag}

# 是否上传镜像
echo "是否上传镜像?(Y/N)"
read is_upload
if [ ${is_upload^^} == "Y" ] || [ ${is_upload^^} == "YES" ];then
    to_upload=0
    echo "选择上传的镜像仓库"
    repos=$(chooseRepos ${IMAGE_REPOS[*]})

    echo "开始上传镜像..."
    uploadRepos ${repos} ${image_tag} ${image_name}
    if (($?==0));then
        echo "镜像上传成功."
        origin_image="registry.cn-shenzhen.aliyuncs.com/walter_self/${repos}:${image_tag}"
    else
        echo "上传失败!!!"
        exit 1
    fi
else
    echo "上传取消."
    to_upload=1
fi



# 是否启动镜像
echo "是否启动镜像?(Y/N)"
read is_start
if [ ${is_start^^} == "Y" ] || [ ${is_start^^} == "YES" ];then
    if ((${to_upload}==1));then
       origin_image=${image}
    fi

    # 上传
    echo "输入命令参数:"
    echo "eg:mysql--->'--name mid_mysql -e MYSQL_ROOT_PASSWORD=kgdiyniqmq -p 3306:3306 -d'"
    read command_parm
    echo "开始启动..."
    start_contain "${command_parm}" ${origin_image}
    if (($?==0));then
        echo "启动完成."
    else
        echo "启动失败!!!"
        exit 1
    fi

else
    echo "启动取消."
fi






