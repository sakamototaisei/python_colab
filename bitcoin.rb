require './method'

puts get_my_monety("BTC")["amount"]
puts get_my_monety("JPY")["amount"]

# ifdoneOCO


# while(1)
#   current_price = get_price
#   puts current_price
  
#   buy_price = 4500000
#   sell_price = 5000000
  
#   if (current_price > sell_price) && (get_my_monety("BTC")["amount"] > 0.001)
#     puts "売ります"
#     order("SELL", sell_price, 0.001)
#   elsif current_price < buy_price && (get_my_monety("JPY")["amount"] > 1000)
#     puts "買います"
#     order("BUY", sell_price, 0.001)
#   else
#     puts "何もしません"
#   end
#   sleep(1)
# end