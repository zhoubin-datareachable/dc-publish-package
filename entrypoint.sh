#!/bin/sh
set -e

main() {
    echo "CICD-START"

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
    # npmrc=""
    # token="//npm.pkg.github.com/:_authToken=${TOKEN}\n"
    # registry="@zhoubin-datareachable:registry=https://npm.pkg.github.com"
    # npmrc="${token}${registry}"
    # echo "${npmrc}"
    # sed -i "1a \\${npmrc}" .npmrc
    echo "hello"
}

# 发布包
push() {
    npm publish
}

main
