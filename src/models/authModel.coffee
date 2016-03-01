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
			"""
				INSERT INTO
					pic_auth
				SET
					member_no=? ,
					auth_type=? ,
					auth_id=? ,
					auth_pw=? ,
					reg_time=NOW() 
			"""

		queryParam = [
			parseInt(authObj.memberNo)
			authObj.authType
			authObj.authId
			@.getEmptiable(authObj, 'authPw')
		]
		console.log(queryParam)

		@.db.query(query, queryParam)
		.then((result) =>
			defer.resolve(result)
		)
		.catch((err) =>
			defer.reject(err)
		)
		return defer.promise 

	# find authentication record by authentication type, id
	findAuthByAuthTypeId: (authType, authId) =>
		defer = Q.defer() 
		query = 
			'''
				SELECT 
					a.* 
				FROM 
					pic_auth a
				WHERE 
					a.auth_type=? AND 
					a.auth_id=? 
			'''
		param = [
			authType 
			authId
		]
		@.selectSingle(query, param)
		.then((authObj) =>
			defer.resolve(authObj)
		)
		.catch((err) =>
			defer.reject(err)
		)
		return defer.promise

module.exports = AuthModel 