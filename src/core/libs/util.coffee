# core util module
# @author jaydee

log = require('../logger')
crypto = require('crypto')
Buffer = require('buffer').Buffer

util = {}

# 숫자 표현인지를 검사 
util.isInteger = (numberExpr) ->
	return isFinite(numberExpr) 

# boolean 표현인지를 검사 
util.isBoolean = (booleanExpr) ->
	if booleanExpr == 'true' or booleanExpr == 'false'
		return true
	return false 

# boolean표현을 string으로 parse 
util.parseBoolean = (booleanExpr) -> 
	if booleanExpr == 'true' 
		return true 
	return false 

# AES Encryption 
util.encryptAes = (data, key) ->
	cipher = crypto.createCipher('aes-256-cbc',key)
	encipheredContent = cipher.update(data,'utf8','hex')
	encipheredContent += cipher.final('hex')
	return encipheredContent

# AES Decryption 
util.decryptAes = (data, key) ->
	decipher = crypto.createDecipher('aes-256-cbc', key)
	decipheredPlaintext = decipher.update(data, 'hex', 'utf8')
	decipheredPlaintext += decipher.final('utf8')
	return decipheredPlaintext

# padding add
util.pad = (text) ->
	padBytes = 8 - (text.length % 8)
	for x in [1 ... padBytes]
		text = text + String.fromCharCode(0)
	return text

# convert unix-style expression to camelcase 
util.toCamelCase = (expr) ->
	str = String(expr)
	arr = str.split('_')
	retStr = '' 
	idx = 0
	for word in arr
		if idx > 0 
			retStr += (word.charAt(0).toUpperCase() + word.slice(1))
		else 
			retStr += word
		idx++
	return retStr 

module.exports = util 