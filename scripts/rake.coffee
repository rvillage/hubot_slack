# Description:
#   Execute ruby script
#
# Commands:
#   :octocat: hubot rake - Exec `rake ping`.
#   :octocat: hubot create pbi <REPOSITORY> "<TITLE>" - Create an issue (for PBI).
#   :octocat: hubot create release pr <REPOSITORY> "<TITLE>" - Create a pull request (for ReleaseBranch).
#   :octocat: hubot create release tag <REPOSITORIES(,)> <TAG> "<TAG MESSAGE>" - Create a tag (for ReleaseTag).

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

  robot.respond /CREATE PBI (.+?) [\"\'](.+?)[\"\']$/i, (msg) ->
    msg.send('プロダクト バックログ イシュー ヲ サクセイ シテイマス')
    rakeExec(msg, "\"create_pbi[#{msg.match[1]}, #{msg.match[2]}]\"")

  robot.respond /CREATE RELEASE PR (.+?) [\"\'](.+?)[\"\']$/i, (msg) ->
    msg.send('リリース プルリクエスト ヲ サクセイ シテイマス')
    rakeExec(msg, "\"create_release_pr[#{msg.match[1]}, #{msg.match[2]}]\"")

  robot.respond /CREATE RELEASE TAG (.+?) [\"\']?(.+?)[\"\']? [\"\'](.+?)[\"\']$/i, (msg) ->
    msg.send('リリース タグ ヲ サクセイ シテイマス')
    repositories = msg.match[1].split(',')
    for repository in repositories
      rakeExec(msg, "\"create_release_tag[#{repository}, #{msg.match[2]}, #{msg.match[3]}]\"")

  robot.router.post "/hubot/pacemaker", (req, res) ->
    return res.end 'failed' unless req.body.uuid == process.env.HUBOT_ACCESS_UUID
    response = new robot.Response(robot, {room: '#bot'})
    rakeExec(response, 'notify_event')
    res.end 'success'
