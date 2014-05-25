# Description
#   require newrelic
#
# Dependencies:
#   "newrelic": "<module version>"
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
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

newrelic = require 'newrelic'

module.exports = (robot) ->
