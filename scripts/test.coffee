# Description:
#   DevOps reactions from https://github.com/hubot-scripts/hubot-devops-reactions/blob/master/src/devops-reactions.coffee
#
# Dependencies:
#   jsdom
#
# Configuration:
#   None
#
# Commands:
#   test testops
#
# Author:
#

jsdom = require('jsdom').jsdom
jquery = 'http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js'
url = 'http://devopsreactions.tumblr.com/random'
devopsRegex = /(test|!testops)/i

module.exports = (robot) ->
  robot.hear devopsRegex, (msg) ->
    msg.http(url).get() (err, res, body) ->
      location = res.headers.location
      jsdom.env location, [jquery], (errors, window) ->
        (($) ->
          title = $('.post_title').text()
          image = $('.item img').attr('src')

          if title and image
            msg.send "#{title}"
            msg.send "testing getting env variables, this should work according to documentation"
            msg.send process.env.apiCall
            msg.send process.env.slackUserApiCall
            msg.send "-----------------"
            msg.send "#{image}"
        )(window.jQuery)
