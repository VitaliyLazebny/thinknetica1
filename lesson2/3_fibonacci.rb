# 3. Заполнить массив числами
#    фибоначчи до 100.

arr = [0, 1]

while true do
  next_value = arr[-2] + arr[-1]

  break if next_value > 100

  arr.push next_value
end

puts arr
