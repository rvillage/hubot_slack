# Description:
#   Execute ruby script
#
# Dependencies:
#   "<module name>": "<module version>"
#
# Configuration:
#   HUBOT_GITHUB_REPOSITORY
#
# Commands:
#   hubot <trigger> - <what the respond trigger does>
#   <trigger> - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   rvillage

run = (msg, command) ->
  require('child_process').exec command, (error, stdout, stderr) ->
    if error
      msg.send stderr
    else
      msg.send stdout

module.exports = (robot) ->
  robot.respond /thor (.+)/i, (msg) ->
    run(msg, 'bundle exec thor ' + msg.match[1])
