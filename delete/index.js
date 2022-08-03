const { Octokit } = require("@octokit/core");
// 获取仓库名称
const package_name = process.argv[2].split("/")[1];
// 获取token
const auth = process.argv[3];
// 获取参数
const tags = process.argv.slice(4, process.argv.length);
const octokit = new Octokit({ auth });

if (auth.length !== 40) {
  return;
}

// 获取tag列表
const b = octokit.request(
  "GET /user/packages/{package_type}/{package_name}/versions",
  {
    package_type: "npm",
    package_name,
  }
);

// 删除tag
b.then((res) => {
  const data = res.data;
  if (tags.length <= 1) {
    return;
  }
  if (Array.isArray(tags)) {
    data.map((item) => {
      if (!tags.includes(item.name)) {
        octokit.request(
          "DELETE /user/packages/{package_type}/{package_name}/versions/{package_version_id}",
          {
            package_type: "npm",
            package_name,
            package_version_id: item.id,
          }
        );
      }
    });
  }
});
