# class Mysql
# mysql 쿼리 헬퍼 

log = require('../logger')
Q = require('q')
_ = require('underscore')
mysql = require('mysql')

class Mysql

	constructor: () ->
		@connectionConfig = null
		@connectionPool = null 

	setConnection: (conn) =>
		@connectionPool = mysql.createPool(conn)

	connect: () =>
		defer = Q.defer()
		if @connectionPool == null 
			throw new Error('connection has not be configured')
		@connectionPool.getConnection((err, conn) =>
			if err != null
				defer.rejcet(err) 
			else 
				defer.resolve(conn)
		)
		return defer.promise

	query: (query, param = null) =>
		defer = Q.defer()
		@.connect()
		.then((conn) =>
			conn.query(query, param, (err, result, fields) =>
				if err == null
					conn.release()
					defer.resolve(result)
				else 
					conn.release()
					defer.reject(err)
			)
		)
		.catch((err) =>
			defer.reject(err)
		)
		return defer.promise

# mysql singletone generater 
class MysqlSingleton
	@instance = null
	@getInstance: () ->
		if (@.instance == null)
			@.instance = new Mysql()
		return @.instance

module.exports = MysqlSingleton.getInstance()