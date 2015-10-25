# Description:
#   Fuckface's personality matrix
#
#   Function:
#	everyone loves to fuckface

cloudflare = [':poop:flare', 'lulzflare', 'derpflare', 'herpesflare', 'downtimeflare']
kek = ['http://i.imgur.com/jhqGVTR.jpg', 'http://i.imgur.com/BqjKRio.jpg?1', 'http://static4.fjcdn.com/comments/Gt+youtube+gt+staff+_306f4976c2e7da3e14d542a2fe99c53b.png', 'http://i.imgur.com/c7u9m3S.gif?1']

module.exports = (robot) ->

   #Stupid simple shit responses we enjoy:
   robot.hear /joel/i, (msg) ->

     msg.send "JOEL!!!"
   robot.hear /kek/i, (msg) ->
     msg.send msg.random kek

   robot.hear /lel/i, (msg) ->
     msg.send "http://vignette2.wikia.nocookie.net/s4s/images/9/94/Top_lel.jpg/revision/latest?cb=20130608224602"
	
   robot.hear /cloudflare/i, (msg) ->
     msg.send msg.random cloudflare

   robot.hear /kpi/i, (msg) ->
     msg.send "KPI... sounds a lot like a Roger word"
