# module Regularizer
# regularize response.

log = require('../logger')
util = require('./util')
_ = require('underscore')

regularizer = 

	regularizeRule:
		integer: 'convertInteger'

	regularize: () ->
		log.i('regularize')

module.exports = regularizer