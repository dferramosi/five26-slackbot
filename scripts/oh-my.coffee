# Description:
#   Some shit that @mjm wanted
#
# Dependencies:
#   Lack of good taste
#
# Configuration:
#   None
#
# Commands:
#   oh my - george takei's words of wisdom
#
# Author:
#   awesinine

oh_my = [
	"http://i.imgur.com/TBo68Vx.gif",
	"https://www.youtube.com/watch?v=6nSKkwzwdW4",
	"http://i.imgur.com/X6UtmCL.png",
	"http://i.imgur.com/bUTfZKf.gif?1"
]

module.exports = (robot) ->
  robot.hear /oh my/i, (msg) ->
    msg.send msg.random oh_my
