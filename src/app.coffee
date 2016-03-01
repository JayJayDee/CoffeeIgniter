# app entry point 

http = require('http') 
express = require('express') 
io = require('socket.io')
bodyParser = require('body-parser')
logger = require('morgan')
Q = require('q')

log = require('./core/logger')
mysql = require('./core/database/mysql')
response = require('./core/libs/response')

cfg = require('./config/config')
db = require('./config/database') 

memberRouter = require('./routes/memberRouter')
socketIORouter = require('./routes/socketIORouter')
deviceRouter = require('./routes/deviceRouter')
chatRoomRouter = require('./routes/chatRoomRouter')

# mysql configuration
mysql.setConnection(db.mysql)

# set Express configuration 
app = express()
app.use(logger(cfg.mode))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}));

# set Express route rule 
app.use('/api/member', memberRouter)
app.use('/api/socketio', socketIORouter)
app.use('/api/device', deviceRouter)
app.use('/api/chatroom', chatRoomRouter)

app.all('*', (err, req, res, next) ->
	return next(new Error('NOT_EXIST_API_CALL'))
)

# error handler 
app.use((err, req, res, next) ->
	if cfg.mode == 'release' 
		response.sendError(err, res, next)	
	else 
		console.log(err)
		response.sendError(err, res, next)
)

io(cfg.socketIoPort).listen(app.listen(cfg.expressPort))
log.i('express & socket.io started')
