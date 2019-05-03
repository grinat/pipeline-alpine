const chromiumDriverPath = process.env.CHROME_DRIVER_PATH //'/usr/bin/chromedriver'
const chromiumPath = process.env.CHROME_BIN //'/usr/bin/chromium-browser'

const WINDOW_SIZE = 'window-size=414,736'

// http://nightwatchjs.org/gettingstarted#settings-file
module.exports = {
  src_folders: ['test/e2e/specs'],
  output_folder: 'test/e2e/test-reports',
  custom_assertions_path: ['test/e2e/custom-assertions'],
  custom_commands_path: ['test/e2e/custom-commands'],

  selenium: {
    start_process: true,
    server_path: require('selenium-server').path,
    host: '127.0.0.1',
    port: 4444,
    cli_args: {
      'webdriver.chrome.driver': chromiumDriverPath
    },
    end_session_on_fail: true
  },

  test_settings: {
    default: {
      selenium_port: 4444,
      selenium_host: 'localhost',
      silent: true,
      globals: {
        devServerURL: 'http://localhost:' + (process.env.PORT || 3333)
      },
      skip_testcases_on_fail: true,
      end_session_on_fail: true,
      screenshots: {
        enabled: true,
        on_failure: true,
        on_error: true,
        path: 'test/e2e/test-reports'
      }
    },

    chrome: {
      desiredCapabilities: {
        browserName: 'chrome',
        javascriptEnabled: true,
        acceptSslCerts: true,
        chromeOptions: {
          args: [
            WINDOW_SIZE
          ],
          binary: chromiumPath
        }
      }
    },

    'chrome-headless': {
      desiredCapabilities: {
        browserName: 'chrome',
        javascriptEnabled: true,
        acceptSslCerts: true,
        chromeOptions: {
          args: [
            WINDOW_SIZE,
            '--no-sandbox',
            '--headless',
            '--disable-gpu',
            '--disable-extensions'
          ],
          binary: chromiumPath
        }
      }
    }
  }
}
