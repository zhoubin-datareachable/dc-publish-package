#!/bin/bash
set -e

# 主函数
main() {
    echo "CICD-START"
    echo ${INPUT_DELETE}
    if [ $INPUT_DELETE = "true" ]; then
        deleteTag
    else
        publish
    fi
}

# 发布包
publish() {
    echo "===== publish start ====="
    echo "${INPUT_TAG}"
    a=$(cat package.json)
    # 发布备份
    sed -i "s/{{version}}/${INPUT_TAG}-back/g" package.json
    npm publish
    echo $a >package.json
    # 发布当前
    sed -i "s/{{version}}/${INPUT_TAG}/g" package.json
    npm publish
    echo "===== publish end ====="
}

# 删除Tag
deleteTag() {
    echo "===== delete start ====="
    apk add git
    tags=$(git tag)
    cd /delete
    npm install
    node index.js ${INPUT_REPOSITORY} ${INPUT_TOKEN} ${tags}
    echo "===== delete end ====="
}
main
