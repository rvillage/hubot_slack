# Description:
#   Execute ruby script
#
# Commands:
#   hubot tasks - Exec `rake --tasks`.

exec = require('child_process').exec

rakeExec = (msg, command) ->
  exec ('bundle exec rake ' + command), (error, stdout, stderr) ->
    if error
      msg.send stderr
    else
      msg.send stdout

module.exports = (robot) ->
  robot.respond /TASKS$/i, (msg) ->
    rakeExec(msg, '--tasks')
