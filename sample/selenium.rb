#! /usr/bin/ruby

# ブラウザを起動する
# @params [String] 起動するブラウザ(chrome/firefox)
# @return [Driver] WebDriver
def browser_start(browser)

  require 'selenium-webdriver'

  case browser
    when 'chrome'

      # chromeを起動する
      Selenium::WebDriver::Chrome.driver_path = './webdriver/chromedriver'
      # driver = Selenium::WebDriver.for :chrome

      # prefs = {
      #   download: {
      #     prompt_for_download: false,
      #     default_directory: '~/Downloads'
      #   }
      # }
      # driver = Selenium::WebDriver.for :chrome, prefs: prefs

      prefs = {
          prompt_for_download: false,
          default_directory: '~/Downloads'
      }
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_preference(:download, prefs)
      driver = Selenium::WebDriver.for :chrome, options: options

    when 'firefox'

      # firefoxを起動する（app, プロファイル指定なし）
      driver = Selenium::WebDriver.for :firefox

      # firefoxを起動する（appのディレクトリを指定、プロファイルを指定）
      Selenium::WebDriver::Firefox.path="/Applications/Firefox.app/Contents/MacOS/firefox-bin"
      driver = Selenium::WebDriver.for(:firefox, :profile => "default-1413197258474")

  end

  ##
  # オプション
  # 暗黙的なwaitを設定
  driver.manage.timeouts.implicit_wait = 10

  p driver.class

  return driver
end


##
# main

# 引数が指定されてない場合にパラメータを設定する
keyword = ARGV[0] ||= 'selenium'
browser = ARGV[1] ||= 'chrome'

# ブラウザを起動する
driver = browser_start(browser)

# サイトにアクセスする
base_url = 'https://www.google.co.jp/search?q='
url = base_url + keyword

driver.get url

puts '===' + driver.title + '==='

# 検索結果からタイトルとURLを取得する
elements = driver.find_elements(:xpath, '//*[@class="rc"]/h3/a')
for e in elements
  puts 'title:' + e.text
  puts 'URL  :' + e.attribute('href')
end

sleep 3

# ブラウザ終了
driver.quit
