module.exports = (robot) ->
   msgData = {
      channel: "channel"
      text: "text"
      attachments: [
         {
            fallback: "fallback",
            title: "title"
            title_link: "title link"
            text: "text"
            mrkdwn_in: ["text"]
         }
      ]
   }

   testcheck=/test( )?check/i
  
   robot.respond testcheck, (msg) ->
      robot.adapter.customMessage msgData