#!/bin/sh
set -e

main() {
    echo "CICD-START"
    echo "${TOKEN}"
    # 检测是否有输入TOKEN
    if usesBoolean "${TOKEN}"; then
        echo "::add-mask::${TOKEN}"
        set -x
    fi

    # 构建
    buildingConfiguration

    # 发包
    push
}

usesBoolean() {
    [ ! -z "${1}" ] && [ "${1}" = "true" ]
}

# 构建配置文件
buildingConfiguration() {
    echo "start config"
    ls
    npmrc=""
    token="//npm.pkg.github.com/:_authToken=${TOKEN}"
    registry="@zhoubin-datareachable:registry=https://npm.pkg.github.com\n"
    npmrc="${registry}${token}"
    echo "${npmrc}" >./.npmrc
    cat .npmrc
    echo "end"
    ls
}

# 发布包
push() {
    npm publish
}

main
