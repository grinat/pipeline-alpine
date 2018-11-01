## CI configs

Usage in gitlab, add in gitlab-ci.yml:

```
image: grinat0/pipeline-alpine:latest

# example job
stages:
- test
- production

cache:
  key: ${CI_COMMIT_REF_SLUG}
  paths:
  - node_modules/

test:
  only:
  - master
  stage: test
  script:
  - mkdir -p dist
  - npm install
  - npm run e2e-headless-ci

production:
  only:
  - master
  stage: production
  script:
  - mkdir -p dist
  - npm install
  - npm run build
```

Usage in bitbucket, add in bitbucket-pipelines.yml:

```
image: grinat0/pipeline-alpine:latest

# example job
pipelines:
  branches:
    master:
      - step:
          caches:
            - node
          deployment: test
          name: Test
          script:
            - mkdir -p dist
            - npm install
            - npm run e2e-headless-ci
      - step:
          caches:
            - node
          deployment: production
          name: Build
          script:
            - mkdir -p dist
            - npm install
            - npm run build
```

## Paths

chromium Driver Path - /usr/bin/chromedriver
chromium Path - /usr/bin/chromium-browser

## Nightwatch.js

Sample config
```
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
      'webdriver.chrome.driver': '/usr/bin/chromedriver'
    },
    end_session_on_fail: true
  },

  test_settings: {
    default: {
      selenium_port: 4444,
      selenium_host: 'localhost',
      silent: true,
      globals: {
        devServerURL: 'http://localhost:' + (process.env.PORT || config.dev.port),
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

    'chrome-headless': {
      desiredCapabilities: {
        browserName: 'chrome',
        javascriptEnabled: true,
        acceptSslCerts: true,
        chromeOptions: {
          args: [
            'window-size=414,736,
            '--no-sandbox',
            '--headless',
            '--disable-gpu',
            '--disable-extensions'
          ],
          binary: '/usr/bin/chromium-browser'
        }
      }
    }
  }
}
```