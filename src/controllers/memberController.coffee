# class MemberController 
# /member 세그먼트 내 요청 처리 

Q = require('q')

log = require('../core/logger')
BaseController = require('../core/baseController')
MemberModel = require('../models/memberModel')
AuthModel = require('../models/authModel')

class MemberController extends BaseController

	@member: null 

	constructor: () ->
		super('member')
		@member = new MemberModel()

	# /api/member/register/phonenum 요청 처리 
	# method POST 
	registerPhonenum: (req, res, next) =>
		param = @.getParam(req, res, next,
			post: 
				nick: [] 
				nationcode: []
				profileimg: ['integer']
		)

		@member.findElem(1)
		.then((memberObj) =>
			@.regularize(memberObj, {}).toCamelCase()
			@.sendSuccess(memberObj, res)
		)
		.catch((err) =>
			return next(err)
		)

	auth: (req, res, next) =>
		param = @.getParam(req, res, next, 
			post:
				token: [] 
		)
		@.sendSuccess(param, res)

module.exports = MemberController
