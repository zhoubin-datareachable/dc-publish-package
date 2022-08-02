// Octokit.js
// https://github.com/octokit/core.js#readme
const { Octokit } = require("@octokit/core");

console.log("process", process.argv);

const auth = process.argv[2];
const tags = process.argv[3].replace(/\r/g, "").split(",");

console.log("auth", auth);
console.log("tags", tags);

const octokit = new Octokit({ auth });

const b = octokit.request(
  "GET /user/packages/{package_type}/{package_name}/versions",
  {
    package_type: "npm",
    package_name: "npm-test",
  }
);

b.then((res) => {
  const data = res.data;
  data.map((item) => {
    if (!tags.includes(item.name)) {
      octokit.request(
        "DELETE /user/packages/{package_type}/{package_name}/versions/{package_version_id}",
        {
          package_type: "npm",
          package_name: "npm-test",
          package_version_id: item.id,
        }
      );
    }
  });
});