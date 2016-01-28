
crypto = require('crypto')
credential = require('../config/credential')
log = require('../core/logger')
coreUtil = require('../core/libs/util')

util = 

	# SHA-1 hash generation 
	generateHash: (rawExpr) ->
		sha = crypto.createHash('sha1')
		sha.update(rawExpr)
		return sha.digest('hex')

	# memberToken generation
	generateMemberToken: (memberObj) ->
		return null
		
	# validate if member token is valid 
	isValidMemberToken: (tokenExpr) ->
		decrypted = null 
		try
			decrypted = coreUtil.decryptAes(tokenExpr)		
		catch e
			return false		
		return true
		
module.exports = util 