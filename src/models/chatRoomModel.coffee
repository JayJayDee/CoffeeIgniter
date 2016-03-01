# class ChatRoomModel 
# chat_room schema related model 

Q = require('q')
_ = require('underscore')

BaseModel = require('../core/baseModel')

class ChatRoomModel extends BaseModel 

	constructor: () ->
		super('pic_room', 
			no: 'integer' 
			profile_image_no: 'integer'
		)

module.exports = ChatRoomModel