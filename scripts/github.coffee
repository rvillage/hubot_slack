# Description:
#   GitHub Notification
#
# Dependencies:
#   "<module name>": "<module version>"
#
# Configuration:
#   HUBOT_GITHUB_USER
#   HUBOT_GITHUB_TOKEN
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

cronJob = require('cron').CronJob

module.exports = (robot) ->
  send = (room, msg) ->
    response = new robot.Response(robot, {user : {id : -1, name : room}, text : 'none', done : false}, [])
    response.send msg

  # new cron('00 00 10 * * 1-5', () ->
  new cronJob('*/10 * * * * *', () ->
    request = msg.http("https://api.github.com/repos/#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPOSITORY}/pulls")
                 .auth(process.env.HUBOT_GITHUB_USER, process.env.HUBOT_GITHUB_TOKEN)
                 .get()
    request (err, res, body) ->
      prNum = body.split('\{\"url\"').length - 1
      if prNum > 0
        # [TODO] string to arrayをスマートにしたい
        send '#github', "@all\nそろそろレビュータイムだわ。#{prNum} 件あるけど、余裕だよね？\nじっくり確認して11時から本気出す！\nhttps://github.com//#{process.env.HUBOT_GITHUB_USER}/#{process.env.HUBOT_GITHUB_REPOSITORY}/pulls"
  ).start()
