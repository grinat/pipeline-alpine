// For authoring Nightwatch tests, see
// http://nightwatchjs.org/guide#usage

module.exports = {
  'hello word exist': function (browser) {
    browser
      .url(browser.globals.devServerURL + '/test.html')
      .assert.elementPresent('.hello')
      .assert.containsText('.hello', 'Hello world')
      .end()
  }
}
