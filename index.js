const program = require("commander");
const fs = require("fs");
const { copySync } = require("fs-extra");
const path = require("path");
const package = require("./package.json");
const colors = require("colors");

const skeleton = path.resolve(__dirname, "skeleton");
const excludes = fs.readFileSync(path.join(skeleton, ".gitignore"), "utf8")
  .split("\n")
  .filter(line => line.trim() !== "");

function exclude(path) {
  return !excludes.some(exclude => path.includes(exclude));
}

function installed(target) {
  console.log("");
  console.log(colors.green(`Generated app in ${target}.`));
  console.log(`
Now:

    $ cd ${target}
    $ npm i
    $ npm start
`);
  console.log(colors.blue("Enjoy ;)"));
  console.log("");
}

program
  .version(package.version)
  .arguments("<dir>")
  .action(function(dir) {
    try {
      const target = path.resolve(dir);
      if (fs.existsSync(target)) {
        throw `Target dir ${dir} exists, aborting.`;
      }
      copySync(skeleton, target, { filter: exclude });
      installed(target);
    } catch (err) {
      console.error(colors.red(err));
      process.exit(1);
    }
  });

if (process.argv.slice(2).length !== 1) {
  program.outputHelp();
}

program.parse(process.argv);
