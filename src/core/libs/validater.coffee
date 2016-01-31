# parameter validater

log = require('../logger')
util = require('./util')
_ = require('underscore')

Validater = 

	# validation rule name - method name map
	validationRule: 
		integer: 'validateIsInteger'
		boolean: 'validateIsBoolean'
		date_ymd: 'validateIsDateYMD' 
		time_hms: 'validateIsTimeHMS' 
		datetime_ymdhms: 'validateIsDateTimeYMDHMS'

	# result base.
	resultBase:
		result: false
		converted: null
		failCause: null 

	# paramter regularization / purification 수행 
	validate: (ruleName, value) ->
		if ruleName == 'nullable' 
			return null
		if @.validationRule[ruleName] == undefined 
			throw new Error('invalid rule name : ' + ruleName)
		methodName = @.validationRule[ruleName]
		retObj = @[methodName](value)
		return retObj

	# integer validation
	validateIsInteger: (value) ->
		ret = JSON.parse(JSON.stringify(@.resultBase))
		ret.result = util.isInteger(value);
		if ret.result == true
			ret.converted = parseInt(value)
		else 
			ret.failCause = 'not an integer'
		return ret

	# boolean validation
	validateIsBoolean: (value) ->
		ret = JSON.parse(JSON.stringify(@.resultBase))
		ret.result = util.isBoolean(value);
		if ret.result == true
			ret.converted = util.parseBoolean(value)
		else 
			ret.failCause = 'not a boolean'
		return ret

	validateIsDateYMD: (value) ->
		ret = @.resultBase.clone()
		log.i('validate - isdateYMD')
		return ret

	validateIsTimeHMS: (value) ->
		ret = @.resultBase.clone()
		log.i('validate - isTime H:M:S')
		return ret

	validateIsDateTimeYMDHMS: (value) ->
		ret = @.resultBase.clone()
		log.i('validate - isDateTime_YMDHMS')
		return ret

	# or you can add custom validation rule methods.
	# custom validation rules 

	validateIsMemberToken: (value) ->
		ret = JSON.parse(JSON.stringify(@.resultBase))
		
		return ret

module.exports = Validater