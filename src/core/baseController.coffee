# class BaseController 
# controller base 

_ = require('underscore') 

log = require('./logger')
ApiError = require('./apiError')
baseutil = require('./libs/util')
response = require('./libs/response')
validater = require('./libs/validater')
regularizer = require('./libs/regularizer')

class BaseController

	constructor: (controllerName) ->
		log.i('Controller intialized : ' + controllerName)

	# controller의 method들에서 지정한 parameter rule에 따라 parameter를 
	# 반환 및 parameter 예외처리 
	getParam: (req, res, next, paramRule) =>
		param = 
			post: {}
			get: {}
			url: {}

		_.each(paramRule, (params, paramType) =>

			inputParam = null 
			if paramType == 'post'
				inputParam = req.body 
			else if paramType == 'get' 
				inputParam = req.query
			else if paramType == 'url' 
				inputParam = req.params

			# parameter각각의 rule을 순회.
			_.each(params, (ruleArr, key) =>
				isNullable = false
				_.each(ruleArr, (ruleName) =>
					if ruleName == 'nullable'
						isNullable = true
				)

				if isNullable == false and inputParam[key] == undefined
					throw new ApiError('INVALID_PARAM', 'parameter required : ' + key)

				param[paramType][key] = null
				if inputParam[key] != undefined
					isValid = true
					cause = null
					converted = null
					for ruleName in ruleArr
						resObj = validater.validate(ruleName, inputParam[key])
						if resObj != null 
							if resObj.result == false
								isValid = false
								cause = resObj.failCause
								break
							else 
								if resObj.converted != null
									converted = resObj.converted
					if isValid == false
						throw new ApiError('INVALID_PARAM', cause + ' : ' + key)
					else
						if converted != null
							param[paramType][key] = converted
						else
							param[paramType][key] = inputParam[key]

			)
		)
		return param 

	sendSuccess: (data, res) =>
		response.sendSuccess(data, res)

	regularize: (data, ruleArr, options = null) =>
		regularizer.regularize(data, ruleArr, options)

	regularizeList: (list, ruleArr, options = null) =>
		regularizer.regularizeList(data, ruleArr, options)

module.exports = BaseController