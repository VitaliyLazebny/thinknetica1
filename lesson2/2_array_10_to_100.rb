# 2. Заполнить массив числами
#    от 10 до 100 с шагом 5

arr = []

#2.upto(20) do |i|
#  arr.push i*5
#end
# (2..20).map{|x| x * 5}
arr = (10..100).step(5).to_a

puts arr
