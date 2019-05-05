#!/usr/bin/env bash

# 进入调试模式: -x
#export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}: '
export PS4='->${LINENO}: '


echo "是否启动镜像?(Y/N)"
read is_start
if [ ${is_start^^} == "Y" ] || [ ${is_start^^} == "YES" ];then
    # 上传
    echo "开始上传..."
    echo "开始完成."
else
    echo "不执行上传."
fi

