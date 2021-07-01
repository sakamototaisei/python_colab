# puts 3 + 4
# puts 9 - 4
# puts 3 * 9
# puts 9 / 3
# puts 5.0 / 2.0
# puts 5 % 2
# -----------------------------------
# japanese = 80
# math = 50
# science = 30
# history = 60
# english = 70
# puts (japanese + math + science + history + english) / 5
# puts (math + science) / 2
# puts (japanese + history + english) / 3
# ----------------------------------------------


# scores = [80,60,30,60,70,45,90,100]
# puts scores[3]

# omikuji = ["大吉","中吉","小吉","末吉","凶","大凶"]
# puts omikuji.sample
# puts omikuji.length
# ------------------------------------------------

# def greet
#   puts "おはようございます"
#   puts "こんにちは"
#   puts "こんばんは"
# end
# greet

# def average(a, b, c)
#   (a + b + c) / 3
# end
# puts average(1, 2, 3)
# puts average(58, 28, 46)
# ---------------------------------

# bitcoin = 480000

# if bitcoin > 500000
#   puts "高い値段になったので売ります"
# elsif bitcoin < 450000
#   puts "安い価格になったので、買います"
# else
#   puts "50万以下かつ45万以上なので、何もしない"
# end
# ------------------------------------

# omikuji = ["大吉","中吉","小吉","末吉","凶","大凶"]
# 10.times do
#   puts omikuji.sample
#   sleep(5)
# end

# while(1) この中の処理をずっと行う
# end
# ------------------------------------------------------

# ハッシュ
# scores = {"japanese" => 80, "math" => 60, "science" => 40, "history" => 90, "english" => 50}
# puts scores["japanese"]

# --------------------------------------------------------

# 演習問題 別解
def stop(i)
  if i % 3 == 0
    sleep(1)
  end
end

(1..30).each do |i|
    puts i
    stop(i)
end


# # 正解
# def stop(num)
#   if num % 3 == 0
#   sleep(1)
#   end
# end

# num = 0
# 30.times do
#   num = num + 1
#   puts num
#   stop(num)
# end