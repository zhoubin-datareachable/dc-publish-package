// Octokit.js
// https://github.com/octokit/core.js#readme
const { Octokit } = require("@octokit/core");

console.log("process", process.argv);

const auth = process.argv[2];
console.log("process.argv", process.argv);
console.log("process.argv[3]", process.argv[3]);
const tags = process.argv.slice(3, process.argv.length);

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
