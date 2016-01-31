# class BaseModel
# superclass of model 

Q = require('q')
_ = require('underscore')

log = require('./logger')
cfg = require('../config/config')
mysql = require('./database/mysql')
regularizer = require('./libs/regularizer')

class BaseModel

	@db: null 
	@regularizeRuleMap: null 
	@tableName: null
	@pkFieldName: null 

	constructor: (tableName, defaultRegularizeRule = null, pkFieldName = 'no') ->
		@db = mysql
		@tableName = tableName 
		@pkFieldName = pkFieldName
		@regularizeRuleMap = 
			default: defaultRegularizeRule

	# set table name 
	setTableName: (tableName) =>
		@tableName = tableName
		return @

	# set pk field name 
	setPkFieldName: (pkFieldName) =>
		@pkFieldName = pkFieldName
		return @

	# register regularize rule 
	registerRegularizeRule: (rule, ruleName = 'default') =>
		@regularizeRuleMap[ruleName] = rule

	# returns single object 
	selectSingle: (query, param = null, ruleName = 'default') =>
		defer = Q.defer()
		@db.query(query, param)
		.then((list) =>
			if list.length == 0
				defer.resolve(null)
				return
			regularizer.regularizeList(list, @regularizeRuleMap[ruleName])
			defer.resolve(list[0])
		)
		.catch((err) =>
			defer.reject(err)
		)
		return defer.promise 

	# returns multi-object rows 
	selectMultiple: (query, param = null, ruleName = 'default') =>
		defer = Q.defer()
		@db.query(query, param)
		.then((list) => 
			regularizer.regularizeList(list, @regularizeRuleMap[ruleName])
			defer.resolve(list)
		)
		.catch((err) => 
			defer.reject(err)
		)
		return defer.promise

	# insert new element
	insertElem: (elemObj) =>
		log.i('insert-elem')

	# get element for primary key
	findElem: (pk) =>
		defer = Q.defer()
		query = 
			"""
				SELECT 
					*
				FROM 
					#{@tableName}
				WHERE 
					#{@pkFieldName}=?

			"""
		param = [pk]
		@.selectSingle(query, param)
		.then((obj) =>
			defer.resolve(obj)
		)
		.catch((err) =>
			defer.reject(err)
		)
		return defer.promise

	# update element 
	updateElem: (pk, modifyObj) =>
		log.i('update-elem')

	# delete element 
	deleteElem: (pk) =>
		log.i('delete-elem')

module.exports = BaseModel