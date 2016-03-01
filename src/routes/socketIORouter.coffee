# /socketio segment routes 

express = require('express')
log = require('../core/logger')

router = express.Router()

SocketIOController = require('../controllers/socketioController')
sctrl = new SocketIOController()

router.post('/subscribe', (req, res, next) ->
	sctrl.onSubscribe(req, res, next)
)

router.post('/unsubscribe', (req, res, next) ->
	sctrl.onUnsubscribe(req, res, next)
)

module.exports = router