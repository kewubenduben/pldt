const gulp = require('gulp');
const htmlmin = require('gulp-htmlmin');
const uglify = require('gulp-uglify');

gulp.task('sanitize-asp', () => {
  const minifyJSOption = {
    parse: {},
    compress: false,
    mangle: false,
    output: {
      comments: false,
      beautify: true,
      preserve_line: true,
      keep_quoted_props: true,
      braces: true
    }
  };

  return gulp.src('H*/**/web/**/*.asp')
    .pipe(htmlmin({ minifyJS: minifyJSOption }))
    .pipe(gulp.dest('dist'));
});

gulp.task('sanitize-js', () => {
  const minifyJSOption = {
    parse: {},
    compress: false,
    mangle: false,
    output: {
      comments: false,
      beautify: false,
      preserve_line: true,
      keep_quoted_props: true,
      braces: true
    }
  };

  return gulp.src('H*/**/web/**/*.js')
    .pipe(uglify(minifyJSOption))
    .pipe(gulp.dest('dist'));
});


gulp.task('sanitize', gulp.parallel('sanitize-asp', 'sanitize-js'));

