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
         #robot.emit 'slack-attachment', slackMessage(msg,back)
         msg.send slackMessage(msg.robot.brain.get(politecheck_lookup_id(msg),back)

  #robot hears everything, caches the last thing heard that isn't politecheck
  #should likely expand this to a list of all robot commands
   robot.hear /.*/, (msg) ->
      message = msg.match[0]
      if ( !politecheck.test(message))
         msg.robot.brain.set politecheck_lookup_id(msg), message 

slackMessage = (msg, back, cb) ->
   phrase = msg.message
   phrase = phrase.replace(/\ /g, "+")
   link = "https://labs.foxtype.com/politeness?text=#{phrase}"
   value = Math.round(back.score * 100) / 1

   #this can be expanded to include the tags for kind of communication from the API: confrontational, polite etc.
   #their rating system has a % number and kind
   if value >= 70
      color = "#4183C4"
      title = "Nicely said Grandma..."

   else if value >= 40 && value < 70
      color = "#FFA500"
      title = "That was slightly dickish"

   else if value < 40
       color = "#FF0000"
       title = "You're a certified asshole!"

      data = {
         channel: msg.message.room,
         attachments: [{color:"#{color}",title: "#{value}% Polite", title_link: "#{link}"}],
         username: "politechecked",
         text: "#{title}"
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
            cb json
         catch err
      	    cb "this shit broke, @awesinine--"

lookup_id = (msg) ->
   (msg.envelope.room or msg.envelope.user.id)

politecheck_lookup_id = (msg) ->
   'politecheck_' + lookup_id(msg)