# 3. Заполнить массив числами
#    фибоначчи до 100.

def next_value(a, b)
  return 1 unless a && b
  a + b
end

arr = [0]

while (nv = next_value(arr[-2], arr[-1])) < 100 do
  arr.push nv
end

puts arr