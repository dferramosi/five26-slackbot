# Description:
#   Check yoself before you rekt yoself.
#   
#   foxtype has this neat little politness checker
#	  I found it's api and messed around enough to integrate this
#	  into our chat bot :D
#   https://labs.foxtype.com/politeness

# Commands:
#   hubot politecheck - Returns a value with how polite the last spoken phrase was

module.exports = (robot) ->

   politecheck=/polite( )?check/i
  
   robot.respond politecheck, (msg) ->
      politenessScrap msg.robot.brain.get(politecheck_lookup_id(msg)), (back) ->
         #msg.send slackMessage back
         robot.emit 'slack-attachment', slackMessage(msg,back)
         #msg.send back

  #robot hears everything, caches the last thing heard that isn't politecheck
  #should likely expand this to a list of all robot commands
   robot.hear /.*/, (msg) ->
      message = msg.match[0]
      if ( !politecheck.test(message))
         msg.robot.brain.set politecheck_lookup_id(msg), message 

slackMessage = (msg, back, cb) ->
   link = "https://labs.foxtype.com/politeness"
   value = Math.round(back.score * 100) / 1
   
   if value >= 70
      badgeImg = "http://i.imgur.com/ux8gV2Q.jpg"
      #cb "https://img.shields.io/badge/Polite%20Check-#{value}%:%20%20Certified%20Grandma-green.svg"
   else if value >= 40 && value < 70
      #badgeImg = "http://i.imgur.com/l91y3n0.jpg"
      #cb "https://img.shields.io/badge/Polite%20Check-#{value}%:%20%20Slightly%20Dickish-orange.svg"
   else if value < 40
       badgeImg = "http://i.imgur.com/t5AvBQF.jpg"
      #cb "https://img.shields.io/badge/Polite%20Check-#{value}%:%20%20Certified%20Asshole-red.svg"

      data = {
         channel: "git",
         attachments: [{color:"#4183C4",title: "Test",text:"this is a test."}],
         username: "politechecked",
         image_url: "#{badgeImg}",
         text: "#{value}% Polite"
      }

   return data

      		
politenessScrap = (msg, cb) ->
   phrase = msg
   phrase = phrase.replace(/\ /g, "+")
 
   search = "https://api-classifier.foxtype.com/classify/politeness02?texts=#{phrase}&limit=3&pathname=%2Fpoliteness"
   robot.http(search)
      .header('Accept', 'application/json')
      .post() (err, res, body) ->
         try
            json = JSON.parse body
           
            value = Math.round(json.score * 100) / 1
            cb json
           #if value >= 70
               #cb value
           #    cb "http://i.imgur.com/ux8gV2Q.jpg"
               #cb "https://img.shields.io/badge/Polite%20Check-#{value}%:%20%20Certified%20Grandma-green.svg"
           #else if value >= 40 && json.score < 70
           	   #cb value
           #	   cb "http://i.imgur.com/l91y3n0.jpg"
           	   #cb "https://img.shields.io/badge/Polite%20Check-#{value}%:%20%20Slightly%20Dickish-orange.svg"
           #else if value < 40
           	   #cb value
           #	   cb "http://i.imgur.com/t5AvBQF.jpg"
           	   #cb "https://img.shields.io/badge/Polite%20Check-#{value}%:%20%20Certified%20Asshole-red.svg"
         catch err
      	    cb "this shit broke, @awesinine--"

lookup_id = (msg) ->
   (msg.envelope.room or msg.envelope.user.id)

politecheck_lookup_id = (msg) ->
   'politecheck_' + lookup_id(msg)