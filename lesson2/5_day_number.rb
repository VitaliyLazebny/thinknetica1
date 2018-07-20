# 5. Заданы три числа, которые обозначают
# число, месяц, год (запрашиваем у
# пользователя). Найти порядковый номер
# даты, начиная отсчет с начала года.
# Учесть, что год может быть високосным.
# (Запрещено использовать встроенные в
# ruby методы для этого вроде Date#yday
# или Date#leap?) Алгоритм опредления
# високосного года: www.adm.yar.ru

def leap_year?(year)
  return true  if (year % 400).zero?
  return false if (year % 100).zero?
  return true  if (year % 4).zero?
  false
end

def day_number(year, month, day)
  # result
  number = 0

  # number of days for each month
  months = [ 0, 31, 28, 31, 30, 31,
                30, 31, 31, 30, 31,
                30, 31
  ]

  # change second month days number
  # if needed
  months[2] = 29 if leap_year?(year)

  # Calculation
  1.upto(month) do
    number += months[month]
  end

  number += day

  number
end

puts "Enter the year:"
y = gets.chomp.to_i
puts "Enter the month:"
m = gets.chomp.to_i
puts "Enter the day:"
d = gets.chomp.to_i

puts day_number(y, m, d)

