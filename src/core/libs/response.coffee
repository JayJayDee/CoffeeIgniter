# response writing module 

log = require('../logger')

userError = require('../../config/error')
coreError = require('../config/error')

ApiError = require('../apiError')

response = 
	send: (res, data = null, error = null) -> 
		sendObject = {
			success: false
			data
			error
		}

		if error?
			sendObject.success = false
			statusCode = if error.code == 'NOT_EXIST_API_CALL' then 404 else 400
		else
			sendObject.success = true
			statusCode = 200

		res.status(statusCode)
		res.setHeader('Content-Type', 'application/json')
		res.send(sendObject)

	sendSuccess: (data, res) ->
		if res.headerSent == true 
			log.e('Header already sent')
			return 
		@.send(res, data)

	sendError: (errorObj, res, next) -> 
		errCode = errorObj.message
		errDesc = null
		if errorObj instanceof ApiError
			errDesc = errorObj.description 

		errObj = coreError[errCode]
		if errObj == undefined 
			errObj = userError[errCode]

		if errDesc != null
			errObj.message = errDesc 

		@.send(res, null, errObj)

module.exports = response