# dc-publish-package

`package.json配置`

```json
{
    "version": "{{version}}"
}
```

添加

```yaml
# work flow name
name: publish package
# when to trage this work flow
on:
  push:
    tags:
      - "[0-9]+.[0-9]+.[0-9]+"

# the jobs to run this ci
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      # pull all branch and tag data
      - name: Checkout
        uses: actions/checkout@v3
      - name: Get the Tag Name
        id: tagName
        run: echo "::set-output name=tag::${GITHUB_REF#refs/tags/}"
      # publish the docker to github package
      - name: publish to github package
        uses: zhoubin-datareachable/dc-publish-package@main
        with:
          token: ${{ secrets.TOKEN }}
          tag: ${{ steps.tagName.outputs.tag }}
```

删除

```yaml
# work flow name
name: delete package
# when to trage this work flow
on:
  delete:
    tags:
      - "[0-9]+.[0-9]+.[0-9]+"
# the jobs to run this ci
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      # pull all branch and tag data
      - name: Checkout
        uses: actions/checkout@v3
        with:
          fetch-depth: 0
      # delete tag
      - name: delete github tag
        uses: zhoubin-datareachable/dc-publish-package@main
        with:
          token: ${{ secrets.TOKEN }}
          delete: "true"
```

