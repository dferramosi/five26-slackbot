module.exports = (robot) ->
   testcheck=/test( )?check/i  
   robot.respond testcheck, (msg) ->
      robot.emit 'slack-attachment', {
         channel: "git",
         attachments: [{color:"#4183C4",title: "Test",text:"this is a test."}],
         username: "testbot",
         icon_url: "http://images.customplanet.com/UserCreatedImages/MainDisplayImages/Front/0f8326b3-ad83-4aec-822e-9db26fdd9bf0.png",
         text: "text"
      }
