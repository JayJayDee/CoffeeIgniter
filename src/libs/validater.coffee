
crypto = require('crypto')
credential = require('../config/credential')
log = require('../core/logger')
util = require('./util')
BaseValidater = require('../core/baseValidater') 

class Validater extends BaseValidater 

	constructor: () ->
		# TODO: you can add rule here. 
		@.registerValidationRule('member_token', 'validateIsMemberToken')
		@.registerValidationRule('device_type', 'validateIsDeviceType')
		@.registerValidationRule('room_type', 'validateIsRoomType')

	# TODO: you can add custom, app-specific validation methods 
	validateIsMemberToken: (value) =>
		ret = JSON.parse(JSON.stringify(@.resultBase))
		log.i('validtate - isMemberToken')
		memberObj = util.decryptMemberToken(value)
		if memberObj != null
			ret.result = true
			ret.converted = memberObj
		else 
			ret.failCause = 'invalid member token'
		return ret

	validateIsDeviceType: (value) =>
		ret = JSON.parse(JSON.stringify(@.resultBase))
		log.i('validate - isDeviceType')
		if value == 'IOS' or value == 'ANDROID' 
			ret.result = true 
		else 
			ret.failCause = 'invalid device type expression'
		return ret

	validateIsRoomType: (value) =>
		ret = JSON.parse(JSON.stringify(@.resultBase))
		
		return ret

module.exports = Validater