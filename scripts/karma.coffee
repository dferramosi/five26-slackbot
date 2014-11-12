# Description:
#   Track arbitrary karma
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   <thing>++ - give thing some karma
#   <thing>-- - take away some of thing's karma
#   hubot karma <thing> - check thing's karma (if <thing> is omitted, show the top 5)
#   hubot karma empty <thing> - empty a thing's karma
#   hubot karma best - show the top 5
#   hubot karma worst - show the bottom 5
#
# Author:
#   stuartf

class Karma

  constructor: (@robot) ->
    @cache = {}

    @increment_responses = [
      "+1!", "gained a level!", "is on the rise!", "leveled up!"
    ]

    @decrement_responses = [
      "took a hit! Ouch.", "took a dive.", "lost a life.", "lost a level."
    ]

    @self_responses = [
      "Nice try %name.", "I don't think so.", "Hey everyone! Did you see what %name tried to do?"
    ]

    @robot.brain.on 'loaded', =>
      if @robot.brain.data.karma
        @cache = @robot.brain.data.karma

  kill: (thing) ->
    delete @cache[thing]
    @robot.brain.data.karma = @cache

  increment: (thing) ->
    @cache[thing] ?= 0
    @cache[thing] += 1
    @robot.brain.data.karma = @cache

  decrement: (thing) ->
    @cache[thing] ?= 0
    @cache[thing] -= 1
    @robot.brain.data.karma = @cache

  incrementResponse: ->
     @increment_responses[Math.floor(Math.random() * @increment_responses.length)]

  decrementResponse: ->
     @decrement_responses[Math.floor(Math.random() * @decrement_responses.length)]

  selfResponse: ->
     @self_responses[Math.floor(Math.random() * @self_responses.length)]

  

  get: (thing) ->
    k = if @cache[thing] then @cache[thing] else 0
    return k

  sort: ->
    s = []
    for key, val of @cache
      s.push({ name: key, karma: val })
    s.sort (a, b) -> b.karma - a.karma

  top: (n = 5) ->
    sorted = @sort()
    sorted.slice(0, n)

  bottom: (n = 5) ->
    sorted = @sort()
    sorted.slice(-n).reverse()

normalizeSubject = (subject) ->
  if subject.indexOf('@') == 0
    normalizeSubject subject[1..-1]
  else
    subject.trim()

self_karma = (msg, subject) ->
  user = normalizeSubject msg.message.user.mention_name.toLowerCase()
  if user == subject
    true

sub_response = (text, msg) ->
  text.replace('%name', msg.message.user.mention_name).replace('%room', msg.message.room)

module.exports = (robot) ->
  karma = new Karma robot
  robot.hear ///
    (                           # Group 1.
      @(\S+[^+:\s])\s           # Group 2. Someone's name followed by a space
      |(\S+[^+:\s])             # Group 3. A single word not followed by a space, :, or +
      |\(([^\(\)]+\W[^\(\)]+)\) # Group 4. A parenthetic multi-word phrase
    )                           #
    \+\+                        # ++ for karma
    (\s|$)                      # Group 5. A space or end of line
  ///, (msg) ->
    m = msg.match[2] || msg.match[3] || msg.match[4]
    subject = normalizeSubject m.toLowerCase()
    if !self_karma(msg, subject)
      karma.increment subject
      msg.send "#{subject} #{karma.incrementResponse()} (Karma: #{karma.get(subject)})"
    else
      msg.send sub_response karma.selfResponse(), msg

  robot.hear /(((@\S+[^+:\s]) )|((\S+[^+:\s])))--(\s|$)/, (msg) ->
  robot.hear ///
    (                           # Group 1.
      @(\S+[^+:\s])\s           # Group 2. Someone's name followed by a space
      |(\S+[^+:\s])             # Group 3. A single word not followed by a space, :, or +
      |\(([^\(\)]+\W[^\(\)]+)\) # Group 4. A parenthetic multi-word phrase
    )                           #
    --                          # -- for karma
    (\s|$)                      # Group 5. A space or end of line
  ///, (msg) ->
    m = msg.match[2] || msg.match[3] || msg.match[4]
    subject = normalizeSubject m.toLowerCase()
    if !self_karma(msg, subject)
      karma.decrement subject
      msg.send "#{subject} #{karma.decrementResponse()} (Karma: #{karma.get(subject)})"
    else
      msg.send sub_response karma.selfResponse(), msg

  robot.respond /karma empty ([\s\S]+)$/i, (msg) ->
    subject = msg.match[1].toLowerCase()
    # Don't kill karma if 'empty *' has karma. Use 'empty empty *'
    if karma.get("empty #{subject}") == 0
      karma.kill subject
      msg.send "#{subject} has had its karma scattered to the winds."

  robot.respond /karma( best)?$/i, (msg) ->
    verbiage = ["The Best"]
    for item, rank in karma.top()
      verbiage.push "#{rank + 1}. #{item.name} - #{item.karma}"
    msg.send verbiage.join("\n")

  robot.respond /karma worst$/i, (msg) ->
    verbiage = ["The Worst"]
    for item, rank in karma.bottom()
      verbiage.push "#{rank + 1}. #{item.name} - #{item.karma}"
    msg.send verbiage.join("\n")

  robot.respond /karma (.+)$/i, (msg) ->
    match = msg.match[1].toLowerCase()
    if match != "best" && match != "worst"
      msg.send "\"#{match}\" has #{karma.get(match)} karma."
