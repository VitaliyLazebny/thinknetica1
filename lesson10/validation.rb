validate :name, :presence
validate :number, :format, /A-Z{0,3}/
validate :station, :type, RailwayStation
validate :name, :presence
validate :name, :format, /A-Z/
validate :name, :type, String
