# class MemberController 
# /device segment 

Q = require('q')
util = require('../libs/util')

ApiError = require('../core/apiError')
log = require('../core/logger')
BaseController = require('../core/baseController')

class DeviceController extends BaseController

	constructor: () ->
		super('device')

	# /api/device/subscribe processes
	# method POST 
	onSubscribe: (req, res, next) =>
		log.i('deviceController::onSubscribe()')
		param = @.getParam(req, res, next, 
			post: 
				token: ['member_token'] 
				devicetoken: []
				devicetype: ['device_type']
		)
		@.sendSuccess(param, res)

	# /api/device/unsubscribe processes 
	# method POST 
	onUnsubscribe: (req, res, next) =>
		param = @.getParam(req, res, next, 
			post: 
				token: ['member_token']
				devicetoken: []
		)
		@.sendSuccess(param, res)
		
module.exports = DeviceController
