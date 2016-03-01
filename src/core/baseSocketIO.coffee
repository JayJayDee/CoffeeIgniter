# class BaseController 
# controller base 

_ = require('underscore') 

log = require('./logger')
io = require('socket.io')

class BaseSocketIO

	constructor: (controllerName) ->
		log.i('Socket.IO Controller intialized : ' + controllerName)


module.exports = BaseController