# Description:
#   personality matrix
#
#   Function:
#       leave us filling empty when the bot dies

cloudflare = [':poop:flare', 'lulzflare', 'derpflare', 'herpesflare', 'downtimeflare']
kek = ['http://i.imgur.com/jhqGVTR.jpg', 'http://i.imgur.com/BqjKRio.jpg?1', 'http://i.imgur.com/BTBS8pu.png', 'http://i.imgur.com/c7u9m3S.gif?1']

module.exports = (robot) ->

   #Stupid simple shit responses we enjoy:
   robot.hear /joel/i, (msg) ->
     msg.send "JOEL!!!"

   robot.hear /kek/i, (msg) ->
     msg.send msg.random kek

   robot.hear /lel/i, (msg) ->
     msg.send "http://i.imgur.com/QUFJp9S.jpg"
	
   robot.hear /cloudflare/i, (msg) ->
     msg.send msg.random cloudflare

   robot.hear /kpi/i, (msg) ->
     msg.send "KPI... sounds a lot like a Roger word"
