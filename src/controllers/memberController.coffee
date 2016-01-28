# class MemberController 
# /member 세그먼트 내 요청 처리 

BaseController = require('../core/baseController')
log = require('../core/logger')
coreutil = require('../core/libs/util')
mysql = require('../core/database/mysql')

class MemberController extends BaseController

	constructor: () ->
		super('member')

	# /api/member/register/phonenum 요청 처리 
	# method POST 
	registerPhonenum: (req, res, next) =>
		param = @.getParam(req, res, next,
			post: 
				token: [] 
				nick: [] 
				nationcode: []
				profileimg: ['integer']
		)
		log.i('register/phonenum')
		@.sendSuccess(param, res)

	auth: (req, res, next) =>
		param = @.getParam(req, res, next, 
			post:
				token: [] 
		)
		@.sendSuccess(param, res)

module.exports = MemberController
