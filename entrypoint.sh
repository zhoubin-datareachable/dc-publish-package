#!/bin/sh
set -e

main() {
    echo "CICD-START"
    apk add git
    mkdir temp
    cd temp
    git config --global user.name “xxxxx”
    git config --global user.email “123@xx.com”
    git config --list
    echo "${INPUT_REA}" >~/.ssh/id_rsa
    git clone git@github.com:zhoubin-datareachable/npm-test.git

    # sudo apt-get install git
    cd /github/workspace
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
    echo "${INPUT_TAG}"
    sed -i "s/{{version}}/${INPUT_TAG}/g" package.json
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
