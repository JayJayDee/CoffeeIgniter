# class MemberModel 
# member schema related model 

Q = require('q')
_ = require('underscore')

BaseModel = require('../core/baseModel')

class MemberModel extends BaseModel 

	constructor: () ->
		super('pic_member', 
		)

	# insert new member to db 
	insertNewMember: (memberObj) =>
		defer = Q.defer()
		query = 
			'''
				INSERT INTO 
					pic_member 
				SET 
					profile_image_no=? ,
					nick=? ,
					nation_code=? , 
					total_like_count=? ,
					following_count=? ,
					followed_count=? ,
					reg_time=NOW()
			'''
		param = [
			parseInt(memberObj.profileImageNo)
			memberObj.nick
			memberObj.nationCode
			0, 0, 0
		]

		@.db.query(query, param)
		.then((result) =>
			defer.resolve(result)
		)
		.catch((err) =>
			defer.reject(err)
		)
		return defer.promise

module.exports = MemberModel 