# Description:
#   Execute ruby script
#
# Commands:
#   hubot rake - Exec `rake ping`.
#   hubot Create PBI <REPOSITORY> <TITLE> - Create an issue (for PBI).
#   hubot Create ReleasePR <REPOSITORY> <TITLE> - Create a pull request (for ReleaseBranch).

exec = require('child_process').exec

rakeExec = (msg, command) ->
  exec ("bundle exec rake #{command}"), (error, stdout, stderr) ->
    if error
      msg.send stderr
    else
      msg.send stdout

module.exports = (robot) ->
  robot.respond /RAKE$/i, (msg) ->
    rakeExec(msg, 'ping')

  robot.respond /CREATE PBI (.+) (.+)$/i, (msg) ->
    rakeExec(msg, "\"create_pbi[#{msg.match[1]}, #{msg.match[2]}]\"")

  robot.respond /CREATE RELEASEPR (.+) (.+)$/i, (msg) ->
    rakeExec(msg, "\"create_release_pr[#{msg.match[1]}, #{msg.match[2]}]\"")
