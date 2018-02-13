#!/usr/bin/env node

const program = require("commander");
const fs = require("fs");
const { copySync, moveSync } = require("fs-extra");
const path = require("path");
const package = require("./package.json");
const colors = require("colors");

/*
If you're wondering why the app skeleton features both a `gitignore` file and a
`.gitignore` one, read this and cry https://github.com/npm/npm/issues/3763.
Basically we can't publish any file named `.gitignore` to the npm package
registry, so we package a `gitignore` that we rename to `.gitignore` as a post
app init process. Sometimes, I wanna just move away from this industry and open
a pub to drink every bottle out of it.
*/

const skeleton = path.resolve(__dirname, "skeleton");

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
      copySync(skeleton, target);
      moveSync(`${target}/gitignore`, `${target}/.gitignore`);
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
