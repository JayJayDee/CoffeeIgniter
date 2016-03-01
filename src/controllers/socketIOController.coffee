# class SocketIOController 
# /socketio 세그먼트 요청 처리 .

BaseController = require('../core/baseController') 
log = require('../core/logger')

class SocketIOController extends BaseController

	constructor: () ->
		super('socketio')

	# /api/socketio/subscribe 요청 처리 
	# method POST 
	onSubscribe: (req, res, next) =>
		param = @.getParam(req, res, next, 
			post: 
				socketid: [] 
				token: ['member_token']
		)
		@.sendSuccess(param, res)

	onUnsubscribe: (req, res, next) =>
		param = @.getParam(req, res, next,
			post:
				socketid: []
				token: ['member_token']
		)
		@.sendSuccess(param, res)

module.exports = SocketIOController