var gulp = require('gulp');
var coffee = require('gulp-coffee');
var server = require( 'gulp-develop-server' );
var clean = require('gulp-clean');
var runseq = require('run-sequence');
var del = require('del')

var paths = {
	coffee: 'src/**/*.coffee',
	js_src: 'src/**/*.js',
	js_bin: 'bin/**/*.js' 
};

gulp.task('compile-coffee', function() {
	gulp.src(paths.coffee)
		.pipe(coffee({bare: true}).on('error', console.log))
		.pipe(gulp.dest('./bin'));
});

gulp.task('remove-js-src', function() {
	return gulp.src(paths.js_src)
		.pipe(clean());
});

gulp.task('remove-js-bin', function(cb) {
	return del([paths.js_bin], function() {
		cb();
	});
});

gulp.task('rebuild-coffee-all', function(cb) {
	runseq('remove-js-bin', 'compile-coffee', 'remove-js-src', function() {
		cb();
	});
});

gulp.task('restart-server', function(cb) {
	runseq('rebuild-coffee-all', function() {
		server.restart(function() {
			cb();
		});
	});
});

gulp.task('default', function(cb) {
	runseq('rebuild-coffee-all', 'start-server', function () {
		gulp.watch(paths.coffee, ['restart-server']);
		cb();
	});
});

gulp.task('start-server', function() {
    server.listen({path: './bin/app.js'});
});
 

