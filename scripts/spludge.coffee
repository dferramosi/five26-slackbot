#Description
#   Fuckface spludges anyone that --'s him in an orifice now
#
# Dependencies:
#   You need to be badass to appriciate this shit
#
# Configuration:
#   None
#
# Commands:
#   fuckface -- - Fuckface gets Jizzy wit it
#
# Notes:
#   None
#
# Author:
#   Awesinine, adapted from the stupid dart game (google it bitch)

module.exports = (robot) ->
  robot.hear /fuckface--|fuckface -- (.*)/i, (msg) ->
    slackUserList = "https://slack.com/api/users.list?token=" + process.env.slackToken
    robot.http(slackUserList)
      .header('Accept', 'application/json')
      .get() (err, res, body) ->
        #user = msg.match[1]
        sender = msg.message.user.name.toLowerCase()
        data = JSON.parse body
        userLookup = (item for item in data['members'] when item.name is sender)        
        #msg.send JSON.stringify userLookup[0].id
        #msg.send JSON.stringify userLookup <--everything!
        id = (JSON.stringify userLookup[0].id).replace(/"/g,"")
        data = JSON.stringify({
          text: "Suck an egg buddy", 
          channel: "#{id}", 
          username: "fuckface"
        })

        robot.http(process.env.slackIncomingWebhook)
          .header('Accept', 'application/json')
          .get(data) (err, res, body) ->
            msg.send "sent"
            msg.send JSON.stringify userLookup[0].id