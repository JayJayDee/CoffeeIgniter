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
	encipheredContent = cipher.update(data,'utf8','base64')
	encipheredContent += cipher.final('base64')
	return encipheredContent

# AES Decryption 
util.decryptAes = (data, key) ->
	decipheredPlaintext = null 
	try 
		decipher = crypto.createDecipher('aes-256-cbc', key)
		decipheredPlaintext = decipher.update(data, 'base64', 'utf8')
		decipheredPlaintext += decipher.final('utf8')
	catch err 
		return null 
	return decipheredPlaintext

# convert base64-string to safe-base64-string
util.base64toSafeBase64 = (base64) ->
	base64 = base64.replace(/\+/g, '-')
	base64 = base64.replace(/\//g, '_')
	base64 = base64.replace(/\=/g, ',')
	return base64

# convert safe-base64-string to base64-string
util.safeBase64toBase64 = (safeBase64) ->
	safeBase64 = safeBase64.replace(/\-/g, '+')
	safeBase64 = safeBase64.replace(/\_/g, '/')
	safeBase64 = safeBase64.replace(/\,/g, '=')
	return safeBase64	

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