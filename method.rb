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


def get_balance(coin_name)
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
  puts response_hash.find {|n| n["currency_code"] == coin_name}
end