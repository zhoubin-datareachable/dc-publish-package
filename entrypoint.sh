#!/bin/sh
set -e

main() {
    echo "CICD-START"

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
    sed -i 's/#v/1.0.5/g' package.json
    # npmrc=""
    # custom="//npm.pkg.github.com/:_authToken=${TOKEN}"
    # registry="@zhoubin-datareachable:registry=https://npm.pkg.github.com"
    # npmrc="${registry}${custom}"
    # echo "${npmrc}" >.npmrc
    echo "hello"
}

# 发布包
push() {
    npm publish
}

main
