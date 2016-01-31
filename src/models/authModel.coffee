# class MemberModel 
# member schema related model 

Q = require('q')
_ = require('underscore')

BaseModel = require('../core/baseModel')

class AuthModel extends BaseModel 

	constructor: () ->
		super('pic_auth', 
			no: 'integer' 
			profile_image_no: 'integer'
		)

	# insert new authentication record 
	insertNewAuth: (authObj) =>
		defer = Q.defer() 
		query = 
			'''
				
			'''
		return defer.promise 

module.exports = AuthModel 