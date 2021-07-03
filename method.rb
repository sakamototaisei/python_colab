require 'net/http'
require 'uri'
require 'json'
require "openssl"
require './key'

def get_price
  uri = URI.parse("https://api.bitflyer.com")
  uri.path = '/v1/getboard'
  
  
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  response = https.get uri.request_uri
  # puts response.body
  response_hash = JSON.parse(response.body)
  response_hash["mid_price"]
end

def order(side, price, size)
  key = API_KEY
  secret = API_SECRET
  
  timestamp = Time.now.to_i.to_s
  method = "POST"
  uri = URI.parse("https://api.bitflyer.com")
  uri.path = "/v1/me/sendchildorder"
  # child_order_type 指値か成り行きを指定
  # side 買いか売りか指定
  # price 価格(現在と離れすぎてるとエラーになる)
  # size 注文の数量(今回は最小の設定)
  # minute_to_expire 注文を出してから無効になるまでの時間分で指定
  # time_in_force 執行数量条件
  body = '{
    "product_code": "BTC_JPY",
    "child_order_type": "LIMIT",
    "side": "' + side + '",
    "price":' + price + ',
    "size":' + size + ',
    "minute_to_expire": 10000,
    "time_in_force": "GTC"
  }'
  
  text = timestamp + method + uri.request_uri + body
  sign = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), secret, text)
  
  options = Net::HTTP::Post.new(uri.request_uri, initheader = {
    "ACCESS-KEY" => key,
    "ACCESS-TIMESTAMP" => timestamp,
    "ACCESS-SIGN" => sign,
    "Content-Type" => "application/json"
  });
  options.body = body
  
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  response = https.request(options)
  puts response.body
end


def get_my_monety(coin_name)
  key = API_KEY
  secret = API_SECRET
  
  timestamp = Time.now.to_i.to_s
  method = "GET"
  uri = URI.parse("https://api.bitflyer.com")
  uri.path = "/v1/me/getbalance"
  
  
  text = timestamp + method + uri.request_uri
  sign = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), secret, text)
  
  options = Net::HTTP::Get.new(uri.request_uri, initheader = {
    "ACCESS-KEY" => key,
    "ACCESS-TIMESTAMP" => timestamp,
    "ACCESS-SIGN" => sign,
  });
  
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  response = https.request(options)
  response_hash = JSON.parse(response.body)
  response_hash.find {|n| n["currency_code"] == coin_name}
end


def ifdoneOCO
  key = API_KEY
  secret = API_SECRET
  
  timestamp = Time.now.to_i.to_s
  method = "POST"
  uri = URI.parse("https://api.bitflyer.com")
  uri.path = "/v1/me/sendparentorder"
  # order_method: 注文方法です。以下の値のいずれかを指定してください。省略した場合の値は "SIMPLE" です。
  # "SIMPLE": 1 つの注文を出す特殊注文です。
  # "IFD": IFD 注文を行います。一度に 2 つの注文を出し、最初の注文が約定したら 2 つめの注文が自動的に発注される注文方法です。
  # "OCO": OCO 注文を行います。2 つの注文を同時に出し、一方の注文が成立した際にもう一方の注文が自動的にキャンセルされる注文方法です。
  # "IFDOCO": IFD-OCO 注文を行います。最初の注文が約定した後に自動的に OCO 注文が発注される注文方法です。
  
  # condition_type: 必須。注文の執行条件です。以下の値のうちいずれかを指定してください。
  # "LIMIT": 指値注文。
  # "MARKET" 成行注文。
  # "STOP": ストップ注文。
  # "STOP_LIMIT": ストップ・リミット注文。
  # "TRAIL": トレーリング・ストップ注文。
  body = '{
  "order_method": "IFDOCO",
  "minute_to_expire": 10000,
  "time_in_force": "GTC",
  "parameters": [{
    "product_code": "BTC_JPY",
    "condition_type": "LIMIT",
    "side": "BUY",
    "price": 3800000,
    "size": 0.001
  },
  {
    "product_code": "BTC_JPY",
    "condition_type": "LIMIT",
    "side": "SELL",
    "price": 4000000,
    "size": 0.001
  },
  {
    "product_code": "BTC_JPY",
    "condition_type": "STOP_LIMIT",
    "side": "SELL",
    "price": 3600000,
    "trigger_price": 29000,
    "size": 0.001
  }]
}'
  
  text = timestamp + method + uri.request_uri + body
  sign = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), secret, text)
  
  options = Net::HTTP::Post.new(uri.request_uri, initheader = {
    "ACCESS-KEY" => key,
    "ACCESS-TIMESTAMP" => timestamp,
    "ACCESS-SIGN" => sign,
    "Content-Type" => "application/json"
  });
  options.body = body
  
  https = Net::HTTP.new(uri.host, uri.port)
  https.use_ssl = true
  response = https.request(options)
  puts response.body
end