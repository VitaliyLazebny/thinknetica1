# Класс Train (Поезд):
# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route).
# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Train
  def initialize(name, type, coaches_number)
    @name           = name
    @type           = type
    @coaches_number = coaches_number
    @speed          = 0
  end

  # -   -   -   -   -   -   -   -   -
  # Speed section
  #
  def speed
    @speed
  end

  def increase_speed
    @speed++
  end

  def decrase_speed
    @speed--
  end
  # -   -   -   -   -   -   -   -   -


  def name
    name
  end

  def type
    @type
  end

  # -  -  -  -  -  -  -  -  -  -  -  -
  # Coaches section
  #
  def coaches_number
    @coaches_number
  end

  def add_coach
    @coaches_number++
  end

  def leave_coach
    @coaches_number--
  end
  # -  -  -  -  -  -  -  -  -  -  -  -  -

  def set_route

  end

  def get_next_station

  end

  def get_previous_station

  end

  def go_to_next_station

  end

  def go_to_previous_station

  end

  # -  -  -  -  -  -  -  -  -  -  -  -  -

  def size
    coaches_number
  end
end
