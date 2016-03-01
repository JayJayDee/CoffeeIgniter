# class MemberController 
# /member segment 

Q = require('q')

util = require('../libs/util')

ApiError = require('../core/apiError')
log = require('../core/logger')

BaseController = require('../core/baseController')
MemberModel = require('../models/memberModel')
AuthModel = require('../models/authModel')

memberLogic = require('../logics/memberLogic')

class MemberController extends BaseController

	@member: null 
	@auth: null 

	constructor: () ->
		super('member')
		@member = new MemberModel()
		@auth = new AuthModel()

	# /api/member/register/phonenum processes
	# method POST 
	onRegisterPhonenum: (req, res, next) =>
		param = @.getParam(req, res, next,
			post: 
				nick: [] 
				nationcode: []
				profileimg: ['integer']
				phonenum: []
		)

		# accquire authentication using phone-number 
		@auth.findAuthByAuthTypeId('PHONENUM', param.post.phonenum)
		.then((authObj) =>
			# if there is no authentication record, register new member
			if authObj == null
				newMemberObj = 
					authType: 'PHONENUM' 
					authId: param.post.phonenum
					nick: param.post.nick 
					nationCode: param.post.nationcode
					profileImageNo: param.post.profileimg
				return memberLogic.registerNewMember(newMemberObj)

			# if there is authentication record, return that 
			else 
				return @member.findElem(authObj.member_no)
		)
		.then((memberObj) =>
			token = util.generateMemberToken(memberObj)
			memberObj.token = token
			@.regularize(memberObj, {}).toCamelCase()
			@.sendSuccess(memberObj, res)
		)
		.catch((err) =>
			return next(err)
		)

	# /api/member/auth processes
	# method POST 
	onAuth: (req, res, next) =>
		param = @.getParam(req, res, next, 
			post:
				token: ['member_token'] 
		)

		@member.findElem(param.post.token.no)
		.then((memberObj) =>
			if memberObj == null
				throw new ApiError('NOT_EXIST_ITEM', 'not exist member for that token')

			newToken = util.generateMemberToken(memberObj) 
			memberObj.token = newToken

			@.regularize(memberObj, {}).toCamelCase()			
			@.sendSuccess(memberObj, res)
		)
		.catch((err) =>
			return next(err)
		)

module.exports = MemberController
