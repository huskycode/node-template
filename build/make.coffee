require 'shelljs/make'
fs = require 'fs'

# Config
config = {
      srcDir: "src"
    , mainDir: "src/main"
    , testDir: "src/test"
    , buildDir: "build"
}

# Helpers

# Targets
target.autotest = ->
  scripts = "
require('shelljs/global');\n 
\n
console.log('\\033[2J\\033[0f'); //Clear Screen\n
console.log('Restarting autotest...');\n
\n
exec('mocha --reporter min --compilers coffee:coffee-script --colors #{config.testDir}/*_test.coffee');\n
  "
  fs.writeFileSync("#{config.buildDir}/autotest.js", scripts)

  exec("nodemon --watch #{config.srcDir} -e js,coffee #{config.buildDir}/autotest.js")

target.test = ->
  exec("mocha --reporter spec --compilers coffee:coffee-script --colors #{config.testDir}/*_test.coffee")

target.all = ->
  target.dev()


target.dev = ->
  exec("supervisor -w src -e 'js|coffee' app")