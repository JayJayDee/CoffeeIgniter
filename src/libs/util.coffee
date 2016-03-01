
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
		createdTick = new Date().getTime()
		serialized = memberObj.no + '&' + memberObj.nation_code + '&' + createdTick
		appSecret = credential.appSecret 
		encryptedToken = coreUtil.encryptAes(serialized, appSecret)
		encryptedToken = coreUtil.base64toSafeBase64(encryptedToken)
		return encryptedToken

	# decrypt member token. 
	decryptMemberToken: (memberToken) ->
		appSecret = credential.appSecret 
		memberToken = coreUtil.safeBase64toBase64(memberToken)
		decrypted = coreUtil.decryptAes(memberToken, appSecret)
		if decrypted == null
			return null 

		splited = decrypted.split('&')
		memberObj = 
			no: parseInt(splited[0])
			nationCode: splited[1]
			createdTick: parseInt(splited[2])
		return memberObj
		
	# validate if member token is valid 
	isValidMemberToken: (tokenExpr) ->
		decrypted = null 
		try
			decrypted = coreUtil.decryptAes(tokenExpr)		
		catch e
			return false		
		return true
		
module.exports = util 