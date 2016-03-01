
# class MemberLogic 
# provide promises that include /member segment logics

Q = require('q')

log = require('../core/logger')
MemberModel = require('../models/memberModel')
AuthModel = require('../models/authModel')

class MemberLogic 
	@member: null
	@auth: null 

	constructor: () ->
		@member = new MemberModel()
		@auth = new AuthModel()

	# insert new member record and authentication record 
	registerNewMember: (newMemberObj) =>
		defer = Q.defer()
		memberNo = null 

		@member.insertNewMember(newMemberObj)
		.then((result) =>
			memberNo = result.insertId
			authParam = 
				memberNo: memberNo
				authType: newMemberObj.authType
				authId: newMemberObj.authId 
				authPw: newMemberObj.authPw
			return @auth.insertNewAuth(authParam)
		)
		.then((result) =>
			return @member.findElem(memberNo)
		)
		.then((memberObj) =>
			defer.resolve(memberObj)
		)
		.catch((err) =>
			defer.reject(err)
		)
		return defer.promise

class MemberLogicSingleton 
	@instance = null
	@getInstance: () ->
		if @.instance == null
			@.instance = new MemberLogic()
		return @.instance

module.exports = MemberLogicSingleton.getInstance()
