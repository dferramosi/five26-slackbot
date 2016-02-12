# Description:
#   personality matrix
#
#   Function:
#       to leave our chat feeling hollow and empty when the bot dies

cloudflare = [':poop:flare', 'lulzflare', 'derpflare', 'herpesflare', 'downtimeflare', 'shitflare', 'slaflare', 'dreamhost']
kek = ['http://i.imgur.com/oWBhLjU.jpg', 'http://i.imgur.com/aheUOF1.jpg', 'http://i.imgur.com/0vyOajy.png', 'http://i.imgur.com/3TJqrki.png', 'http://i.imgur.com/Qo7Si7o.jpg','http://i.imgur.com/Y3EMYMy.png','http://i.imgur.com/2AqrbVy.jpg','http://i.imgur.com/jhqGVTR.jpg', 'http://i.imgur.com/BqjKRio.jpg?1', 'http://i.imgur.com/BTBS8pu.png', 'http://i.imgur.com/c7u9m3S.gif?1']
lyl = ['https://d.maxfile.ro/kqbnhljrpr.png'] 
wot = ['http://i.imgur.com/22uS56K.jpg', 'http://i.imgur.com/uTZGZ62.jpg', 'http://i.imgur.com/5ZwTZLp.png', 'http://i.imgur.com/ozbBXsw.jpg', 'http://i.imgur.com/ieBMltD.jpg', 'http://i.imgur.com/EswGa1l.png', 'http://i.imgur.com/hxJQSbj.png', 'https://i.ytimg.com/vi/lAop8SyJ0aY/hqdefault.jpg','http://i.imgur.com/xEkxOt6.png']

module.exports = (robot) ->

   #Stupid simple shit responses we enjoy:
   robot.hear /joel/i, (msg) ->
     msg.send "JOEL!!!"
   
   robot.hear /im out|i'm out|I'm out|fuck that shit|bullshit/i, (msg) ->
     msg.send "http://i.imgur.com/VroA892.gif?1"
     
   robot.hear /kek/i, (msg) ->
     msg.send msg.random kek

   robot.hear /lel/i, (msg) ->
     msg.send "http://i.imgur.com/QUFJp9S.jpg"

   robot.hear /lyl/i, (msg) ->
     msg.send msg.random lyl
   
   robot.hear /cloudflare/i, (msg) ->
     msg.send msg.random cloudflare

   robot.hear /kpi/i, (msg) ->
     msg.send "KPI... sounds a lot like a Roger word"

   robot.hear /rectum/i, (msg) ->
     msg.send "rectum? DAMN NEAR KILLED EM!"

   robot.hear /wot|wut/i, (msg) ->
     msg.send msg.random wot

#   robot.hear /fuck/i, (msg) -> #never uncomment this
#     msg.send "EARMUFFS!"

