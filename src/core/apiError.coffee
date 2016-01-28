# custom API error class 

class ApiError extends Error 
	@description = null 
	@message = null 
	@stack = null 

	constructor: (message, description) -> 
		@message = message 
		@description = description
		
module.exports = ApiError