
cfg = require('../config/config')

logger = {} 

logger.printLog = (level, msg) ->
	if cfg.mode != 'dev' 
		return 
	timestamp = new Date().getTime()
	if typeof(msg) == 'string'
		console.log(level + "\t[" + timestamp + ']# ' + msg)
	else 
		console.log(level + "\t[" + timestamp + ']# ')
		console.log(msg)

logger.i = (msg) ->
	@.printLog('INFO', msg) 
		
logger.e = (msg) ->
	@.printLog('ERROR', msg)

module.exports = logger