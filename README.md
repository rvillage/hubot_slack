# hubot-slack

This is a [Hubot](http://hubot.github.com/) adapter to use with [Slack](https://slack.com/).

## Getting Started

* Testing your bot locally:

  ``` sh
  $ npm install
  $ bundle install
  $ ./bin/hubot
  ```

* Run your Hubot:

  ``` sh
  $ npm install
  $ bundle install
  $ HUBOT_SLACK_TOKEN=<your token> HUBOT_SLACK_TEAM=<your team> ./bin/hubot --adapter slack
  ```

## Deploying to heroku

This is a modified set of instructions based on the [instructions on the Hubot wiki](https://github.com/github/hubot/blob/master/docs/deploying/heroku.md).

1. Edit your `Procfile` and change it to use the `slack` adapter:

  ```
  web: bin/hubot --adapter slack
  ```

2. Install the [Heroku Toolbelt](https://toolbelt.heroku.com/) to start, then follow their 'Getting Started' instructions, including logging in the first time:

  ``` sh
  $ heroku login
  ```

3. Then create a Heroku application:

  ``` sh
  $ heroku create <your app name>
  ```

4. Some scripts needs Redis to work, Heroku offers an addon called Redis ToGo, which has a free plan. To use it:

  ``` sh
  $ heroku addons:add redistogo:nano
  ```

5. Activate the Hubot service on your [Slack](https://slack.com/).

6. Add the config variables. For example:

  ``` sh
  $ heroku config:set HUBOT_SLACK_TOKEN=<your slack token>
  $ heroku config:set HUBOT_SLACK_TEAM=<your slack team name>
  $ heroku config:set HUBOT_SLACK_BOTNAME=<your bot name>
  ```

7. Deploy and start the bot:

  ``` sh
  $ heroku keys:add
  $ git push heroku master
  $ heroku ps:scale web=1
  ```

8. Enjoy!
