const gulp = require('gulp');
const htmlmin = require('gulp-htmlmin');

const minifyJSOption = {
    parse: {},
    compress: false,
    mangle: false,
    output: {
        comments: false,
        beautify: true,
        preserve_line: true
    }
};

gulp.task('minify', () => {
  return gulp.src('**/web/**/*.asp')
    .pipe(htmlmin({ minifyJS: true }))
    .pipe(gulp.dest('dist'));
});

