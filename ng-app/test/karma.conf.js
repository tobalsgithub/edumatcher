// Karma configuration
// http://karma-runner.github.io/0.12/config/configuration-file.html
// Generated on 2014-06-17 using
// generator-karma 0.8.2

module.exports = function(config) {
  config.set({
    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,

    // base path, that will be used to resolve files and exclude
    basePath: '../',

    // testing framework to use (jasmine/mocha/qunit/...)
    frameworks: ['jasmine','chai','sinon-chai'],

    // list of files / patterns to load in the browser
    files: [
      'bower_components/jquery/dist/jquery.js',
      'bower_components/angular/angular.js',
      'bower_components/angular-mocks/angular-mocks.js',
      'bower_components/angular-animate/angular-animate.js',
      'bower_components/angular-cookies/angular-cookies.js',
      'bower_components/angular-resource/angular-resource.js',
      'bower_components/angular-sanitize/angular-sanitize.js',
      'bower_components/angular-touch/angular-touch.js',
      'bower_components/angular-ui-router/release/angular-ui-router.js',
      'bower_components/angular-devise/lib/devise.js',
      //'bower_components/angular-google-maps/dist/angular-google-maps.js',
      'bower_components/angular-strap/dist/angular-strap.js',
      'bower_components/angular-state-files/state-files.js',
      'bower_components/angular-webstorage/angular-webstorage.js',
      'app/scripts/**/*.js',
      'app/**/*.html',
      'test/mock/**/*.js',
      //'test/spec/**/*.js',
      'test/spec/controllers/admin/admin.js'
    ],

    reporters: ['spec'],
    // Uncomment these lines to test feature #14
    //specReporter : {
    //    suppressPassed: true,
    //    suppressFailed: true,
    //    suppressSkipped: true
    //},

    // list of files / patterns to exclude
    exclude: [
      'app/scripts/vendor/flatui*.js'
    ],

    // web server port
    port: 8080,

    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera
    // - Safari (only Mac)
    // - PhantomJS
    // - IE (only Windows)
    browsers: [
      'PhantomJS'
    ],

    // Which plugins to enable
    plugins: [
      'karma-phantomjs-launcher',
      'karma-jasmine',
      'karma-mocha',
      'karma-chai',
      'karma-spec-reporter',
      'karma-sinon-chai',
    ],

    preprocessors: {
      'app/**/*.html': 'html2js'
    },

    // Continuous Integration mode
    // if true, it capture browsers, run tests and exit
    singleRun: false,

    colors: true,

    // level of logging
    // possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_INFO,

    // Uncomment the following lines if you are using grunt's server to run the tests
    // proxies: {
    //   '/': 'http://localhost:9000/'
    // },
    // URL root prevent conflicts with the site root
    // urlRoot: '_karma_'
  });
};
