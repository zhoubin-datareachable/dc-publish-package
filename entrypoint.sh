#!/bin/bash
set -e

# 主函数
main() {
    echo "CICD-START"
    echo ${INPUT_DELETE}
    if ["$INPUT_DELETE" = true]; then
        deleteTag
    else
        publish
    fi
}

# 发布包
publish() {
    echo "===== publish star ====="
    echo "${INPUT_TAG}"
    sed -i "s/{{version}}/${INPUT_TAG}/g" package.json
    npm publish
    echo "===== publish end ====="
}

# 删除Tag
deleteTag() {
    echo "===== delete star ====="
    apk add git
    tags=$(git tag)
    cd /delete
    npm install
    node index.js ${INPUT_REPOSITORY} ${INPUT_TOKEN} ${tags}
    echo "===== delete end ====="
}
main
