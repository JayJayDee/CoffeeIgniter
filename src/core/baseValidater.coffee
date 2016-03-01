# parameter validater

log = require('./logger')
coreUtil = require('./libs/util')
_ = require('underscore')

class BaseValidater 

	# validation rule name - method name map
	validationRule:
		integer: 'validateIsInteger'
		boolean: 'validateIsBoolean'
		date_ymd: 'validateIsDateYMD' 
		time_hms: 'validateIsTimeHMS' 
		datetime_ymdhms: 'validateIsDateTimeYMDHMS'

		member_token: 'validateIsMemberToken'
		device_type: 'validateIsDeviceType'

	# result base.
	resultBase: 
		result: false
		converted: null
		failCause: null 

	# register validation rule - method pair 
	registerValidationRule: (ruleName, methodName) =>
		@.validationRule[ruleName] = methodName 

	# paramter regularization / purification 수행 
	validate: (ruleName, value) =>
		if ruleName == 'nullable' 
			return null
		if @.validationRule[ruleName] == undefined 
			throw new Error('invalid rule name : ' + ruleName)
		methodName = @.validationRule[ruleName]
		retObj = @[methodName](value)
		return retObj

	# integer validation
	validateIsInteger: (value) =>
		ret = JSON.parse(JSON.stringify(@.resultBase))
		ret.result = coreUtil.isInteger(value);
		if ret.result == true
			ret.converted = parseInt(value)
		else 
			ret.failCause = 'not an integer'
		return ret

	# boolean validation
	validateIsBoolean: (value) =>
		ret = JSON.parse(JSON.stringify(@.resultBase))
		ret.result = coreUtil.isBoolean(value);
		if ret.result == true
			ret.converted = coreUtil.parseBoolean(value)
		else 
			ret.failCause = 'not a boolean'
		return ret

	validateIsDateYMD: (value) =>
		ret = @.resultBase.clone()
		log.i('validate - isdateYMD')
		return ret

	validateIsTimeHMS: (value) =>
		ret = @.resultBase.clone()
		log.i('validate - isTime H:M:S')
		return ret

	validateIsDateTimeYMDHMS: (value) =>
		ret = @.resultBase.clone()
		log.i('validate - isDateTime_YMDHMS')
		return ret

module.exports = BaseValidater