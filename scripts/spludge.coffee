# Description
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

  robot.hear /fuckface --/i, (msg) ->
    msg.send "*Pump* *Pump* *Pump*, _lets take this to private local_"
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
          "*SPLUUUUURRRRRight* in the eye.  -- your vision"
        ]
      else if target is "chest"
        msg.random [
          "All over your giant glistening manboobs.  Fuckface ++"
        ]
    msg.reply "Fuck you #{result target}"
