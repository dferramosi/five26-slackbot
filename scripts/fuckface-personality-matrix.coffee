# Description:
#   Fuckface's personality matrix
#
#   Function:
#	everyone loves to fuckface

cloudflare = [':poop:flare', 'lulzflare', 'derpflare', 'herpesflare', 'downtimeflare']

module.exports = (robot) ->

   #Stupid simple shit responses we enjoy:
   robot.hear /joel/i, (msg) ->

     msg.send "JOEL!!!"
   robot.hear /kek/i, (msg) ->
     msg.send "http://static4.fjcdn.com/comments/Gt+youtube+gt+staff+_306f4976c2e7da3e14d542a2fe99c53b.png"
	
   robot.hear /cloudflare/i, (msg) ->
     msg.send msg.random cloudflare
