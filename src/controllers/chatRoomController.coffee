# class ChatRoomController 
# /chatroom segment 

Q = require('q')
util = require('../libs/util')
ApiError = require('../core/apiError')
log = require('../core/logger')

BaseController = require('../core/baseController')

class ChatRoomController extends BaseController

	constructor: () ->
		super('chatRoom')

	# /api/chatroom/create processes
	# method POST 
	onCreate: (req, res, next) =>
		param = @.getParam(req, res, next,
			post: 
				token: ['member_token']
				roomtype: ['room_type']
		)
		@.sendSuccess(param, res)

	# /api/chatroom/join processes 
	# method POST 
	onJoin: (req, res, next) =>
		param = @.getParam(req, res, next,
			post: 
				token: ['member_token']
		)
		@.sendSuccess(param, res)

module.exports = ChatRoomController
