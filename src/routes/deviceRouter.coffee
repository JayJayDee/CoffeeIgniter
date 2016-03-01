# /device segment routes 

express = require('express')
log = require('../core/logger')

router = express.Router()

DeviceController = require('../controllers/deviceController')
ctrl = new DeviceController()

router.post('/subscribe', (req, res, next) ->
	ctrl.onSubscribe(req, res, next)
)

router.post('/unsubscribe', (req, res, next) -> 
	ctrl.onUnsubscribe(req, res, next)
)

module.exports = router