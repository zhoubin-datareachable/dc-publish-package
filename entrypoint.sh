#!/bin/bash
set -e

main() {
    echo "CICD-START"
    echo "${INPUT_REA}"
    apk add git
    # 获取所有tag
    string=$(git tag)
    echo ${string}
    read -a array <<<${string}
    list=""
	for loop in ${array[*]}; do
		list="${list}${loop},"
	done
	list=${list:0:$(expr ${#list[0]} - 1)}
	echo ${list}
    cd /delete
    npm install
    node index.js ${INPUT_TOKEN} ${list}

    # 构建
    # buildingConfiguration

    # # 发包
    # push

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
