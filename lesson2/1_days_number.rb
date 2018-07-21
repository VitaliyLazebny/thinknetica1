# 1. Сделать хеш, содеращий месяцы и
# количество дней в месяце. В цикле
# выводить те месяцы, у которых количе-
# ство дней ровно 30

months = {
    'Январь'   => 31,
    'Февраль'  => 28,
    'Март'     => 31,
    'Апрель'   => 30,
    'Май'      => 31,
    'Июнь'     => 30,
    'Июль'     => 31,
    'Август'   => 31,
    'Сентябрь' => 30,
    'Октябрь'  => 31,
    'Ноябрь'   => 30,
    'Декабрь'  => 31
}

puts months.keep_if {|m, days| days == 30 }.keys

# Expected:
# Апрель
# Июнь
# Сентябрь
# Ноябрь
