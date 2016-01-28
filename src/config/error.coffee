
errors =  

	# poll related errors 
	NOT_EXIST_POLL: 
		code: 'NOT_EXIST_POLL'
		message: 'not exist poll for specified pollId'
		num: 5001 

	# item related errors 
	NOT_EXIST_ITEM: 
		code: 'NOT_EXIST_ITEM' 
		message: 'not exist item for specified itemId'
		num: 5101 
	ALREADY_VOTED_ITEM:
		code: 'ALREADY_VOTED_ITEM'
		message: 'already voted item with that member'
		num: 5102
	NOT_VOTED_ITEM:
		code: 'NOT_VOTED_ITEM'
		message: 'haven\'t voted item'
		num: 5103

module.exports = errors