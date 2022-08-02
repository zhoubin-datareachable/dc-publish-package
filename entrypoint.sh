#!/bin/sh
set -e

main() {
    echo "CICD-START"
    echo "${INPUT_REA}"
    apk add git
    apk add openssh

    git config --global user.name zhoubin-datareachable
    git config --global user.email bin.zhou@datareachable.com
    git config --list
    # ssh-keygen -t rsa -C "email@ai.com"
    # cat /root/.ssh/id_rsa

    # echo "${INPUT_REA}" >/root/.ssh/id_rsa
    mkdir /root/.ssh
    echo "${INPUT_REA}" >/root/.ssh/id_rsa
    echo "${INPUT_HOST}" >/root/.ssh/id_rsa.pub
    cat /root/.ssh/id_rsa
    chmod 0600 /root/.ssh/id_rsa
    chmod 0600 /root/.ssh/id_rsa.pub
    git ls-remote --tags git@github.com:zhoubin-datareachable/npm-test.git

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
