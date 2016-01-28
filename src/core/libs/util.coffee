# core util module
# @author jaydee

log = require('../logger')
crypto = require('crypto')
Buffer = require('buffer').Buffer

util = {}

# check is expression is integer
util.isInteger = (numberExpr) ->
	return isFinite(numberExpr) 

# check is expression is boolean
util.isBoolean = (booleanExpr) ->
	if booleanExpr == 'true' or booleanExpr == 'false'
		return true
	return false 

# parse boolean expression into boolean variable
util.parseBoolean = (booleanExpr) -> 
	if booleanExpr == 'true' 
		return true 
	return false 

# AES encryption
util.encryptAes = (data, key) ->
	cipher = crypto.createCipher('aes-256-cbc',key)
	encipheredContent = cipher.update(data,'utf8','hex')
	encipheredContent += cipher.final('hex')
	return encipheredContent

# AES decryption  
util.decryptAes = (data, key) ->
	decipher = crypto.createDecipher('aes-256-cbc', key)
	decipheredPlaintext = decipher.update(data, 'hex', 'utf8')
	decipheredPlaintext += decipher.final('utf8')
	return decipheredPlaintext

module.exports = util 