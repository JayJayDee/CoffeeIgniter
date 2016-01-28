# class BaseModel
# model base 

Q = require('q')
_ = require('underscore')
mongoose = require('mongoose')
Schema = mongoose.Schema

cfg = require('../config/config')
log = require('./logger')

class BaseModel extends Schema 

	constructor: (schema) ->
		super(schema)

	# mongoose find() 후 정규화 룰에 따라 response를 정규화한다. 
	findExt: (query, fields = null, options = null) =>
		defer = Q.defer()
		@.find(query, fields, options) 
		.then((rows) => 
			# TODO: 여기서 정규화. 
			defer.resolve(rows)
		)
		.catch((err) =>
			defer.reject(err)
		)
		return defer.promise

module.exports = BaseModel