# Description:
#   DevOps reactions
#
# Dependencies:
#   jsdom
#
# Configuration:
#   None
#
# Commands:
#   hubot devops reactions
#
# Author:
#

jsdom = require('jsdom').jsdom
jquery = 'https://code.jquery.com/jquery-3.1.0.min.js'
url = 'http://devopsreactions.tumblr.com/random'
devopsRegex = /(devops reactions|!devops)/i

module.exports = (robot) ->
  robot.respond devopsRegex, (msg) ->
    msg.http(url).get() (err, res, body) ->
      location = res.headers.location
      jsdom.env location, [jquery], (errors, window) ->
        (($) ->
          title = $('.post_title').text()
          image = $('.item img').attr('src')

          if title and image
            msg.send "#{title}"
            msg.send "#{image}"
        )(window.jQuery)
