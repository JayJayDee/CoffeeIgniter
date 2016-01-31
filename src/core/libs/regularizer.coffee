# module Regularizer
# regularize response.

log = require('../logger')
coreUtil = require('./util')
_ = require('underscore')

# default regularize methods 
regularizeMethods = 
	integer: (obj, keyName, extraRule = null) ->
		obj[keyName] = parseInt(obj[keyName]) 

	boolean: (obj, keyName, extraRule = null) ->
		value = obj[keyName]
		if value == 'true' 
			obj[keyName] = true 
		else if value == 'false' 
			obj[keyName] = false

	integer2boolean: (obj, keyName, extraRule = null) ->
		value = parseInt(obj[keyName])
		if value == 1
			obj[keyName] = true 
		else if value == 0
			obj[keyName] = false

	keyname: (obj, keyName, extraRule = null) ->
		if extraRule == null
			return 
		newKeyName = extraRule
		obj[newKeyName] = obj[keyName]
		if (keyName != newKeyName) 
			delete obj[keyName]

class Regularizer
	@regularizeRule: null
	@targetObj: null 

	constructor: () ->
		@regularizeRule = regularizeMethods

	# accquire regularization 
	regularize: (obj, ruleArr, options = null) => 
		@targetObj = obj
		for key, rule of ruleArr
			ruleExpr = null
			extraRuleExpr = null
			rule = String(rule + '')

			split = rule.split(':')
			if split.length > 1
				extraRuleExpr = split[1]
				ruleExpr = split[0]
			else 
				ruleExpr = rule 

			if @regularizeRule[ruleExpr] == undefined 
				return
			method = @regularizeRule[ruleExpr]
			method(obj, key, extraRuleExpr)
		return @

	# accquire regularization for list 
	regularizeList: (list, ruleArr, options = null) =>
		for obj in list
			@.regularize(obj, ruleArr, options)
		return @ 

	# add custom regularize rule 
	addRegularizeRule: (rule) =>
		@regularizeRule = _.extend(@regularizeRule, rule)
		return @

	# convert unix-style response to camelcase 
	toCamelCase: () =>
		if @targetObj == null 
			return @
		for key, value of @targetObj
			newKey = coreUtil.toCamelCase(key)
			@regularizeRule.keyname(@targetObj, key, newKey)
		return @

# regularizer singleton generater 
class RegularizerSingleton
	@instance = null 
	@getBaseClass: () ->
		return Regularizer
	@getInstance: () ->
		if @.instance == null
			@.instance = new Regularizer()
		return @.instance 

module.exports = RegularizerSingleton.getInstance()