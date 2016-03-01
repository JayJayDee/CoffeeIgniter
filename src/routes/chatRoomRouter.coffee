# /chatroom segment routes 

express = require('express')
log = require('../core/logger')

router = express.Router()

ChatRoomController = require('../controllers/chatRoomController')
ctrl = new ChatRoomController()

router.post('/create', (req, res, next) ->
	ctrl.onCreate(req, res, next)
)

router.post('/join', (req, res, next) -> 
	ctrl.onJoin(req, res, next)
)

module.exports = router