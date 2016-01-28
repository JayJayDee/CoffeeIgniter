# /member segment routes 

express = require('express')
log = require('../core/logger')

router = express.Router()

MemberController = require('../controllers/memberController')
mctrl = new MemberController()

router.post('/register/phonenum', (req, res, next) ->
	mctrl.registerPhonenum(req, res, next)
)

router.post('/auth', (req, res, next) -> 
	mctrl.auth(req, res, next)
)

module.exports = router