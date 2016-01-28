
# authorizer middleware for express 
# can be used in routers 

cfg = require('../config/config')
log = require('../core/logger') 

authorizer = (req, res, next) ->
	log.i('Authorizer middleware called')

module.exports = authorizer