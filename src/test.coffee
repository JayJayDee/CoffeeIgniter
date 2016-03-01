
util = require('./libs/util')

dummyObj = 
	no: 1 
	nation_code: 'KO' 		

memberToken = util.generateMemberToken(dummyObj)
console.log('# MEMBER TOKEN = ' + memberToken)

memberObj = util.decryptMemberToken(memberToken)
console.log('# DECRYPTED TOKEN = ')
console.log(memberObj)
