#! /usr/bin/ruby

require 'selenium-webdriver'

# chromeを起動する
Selenium::WebDriver::Chrome.driver_path = './webdriver/chromedriver'
driver = Selenium::WebDriver.for :chrome

# firefoxを起動する（app, プロファイル指定なし）
# driver = Selenium::WebDriver.for :firefox

# firefoxを起動する（appのディレクトリを指定、プロファイルを指定）
# Selenium::WebDriver::Firefox.path="/Applications/Firefox.app/Contents/MacOS/firefox-bin"
# driver = Selenium::WebDriver.for(:firefox, :profile => "default-1413197258474")

# オプション
# 暗黙的なwaitを設定
driver.manage.timeouts.implicit_wait = 10

# サイトにアクセスする
base_url = "https://www.google.co.jp/search?q="
word = ARGV[0]
url = base_url + word

driver.get(url)

# 検索結果からタイトルとURLを取得する
elements = driver.find_elements(:xpath, '//*[@class="rc"]/h3/a')
for e in elements
  puts 'title:' + e.text
  puts 'URL  :' + e.attribute("href")
end

sleep 3

# ブラウザ終了
driver.quit
