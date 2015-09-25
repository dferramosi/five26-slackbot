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

request = require 'request'

ff = "&channel=C02Q2L5K5&text=fuckface++--&username=fuckface&icon_emoji=%3Arainbow%3A"


#takes in a slack name, queries the api for a list of users, searches by slack name, and returns the user id
#this shit took 3 mins to make in python and like an hour of frustration in coffeescript ಠ_ಠ
nameToSlackID = (name) ->
    slackUserList = "https://slack.com/api/users.list?" + process.env.slackToken
    request.get { uri: slackUserList, json: true }, (err, r, body) -> 
        results = body
        userName = (item for item in results['members'] when item.name is name)
        console.log(userName[0]['id'])
        userName[0]['id']

module.exports = (robot) ->

  robot.hear /fuckface--|fuckface --/i, (msg) ->
    
    msg.send "*Pump* *Pump* *Pump*"
    aim = msg.random ["head", "chest"]
    
    target = msg.random ["#{aim}", "#{aim}", "#{aim}", "#{aim}", "miss"]
    result = (target) ->
      if target is "miss"
        "I think i'd rather jizz all over #NSFWGENERAL, bbl"
      else if target is "head"
        msg.random [
          "Oooooh yeahhhhh, right in the back of your open gaping throat! _Fuckface_ ++",
          "Right up your nose. Lets take a selfie together. #fuckfacegetsrevenge",
          "...in the ear.  No one likes it in the ear...",
          "*SPLUUUUURRRRRight* in the eye.  'your vision'--"
        ]
      else if target is "chest"
        msg.random [
          "All over your giant glistening manboobs.  Fuckface ++"
        ]
    #msg.reply "#{result target}"
    msg.http("https://slack.com/api/chat.postMessage?{process.env.slackToken}{ff}")
    msg.send nameToSlackID 'awesinine'
    robot.send {room: nameToSlackID "awesinine"}, "#{result target}"
