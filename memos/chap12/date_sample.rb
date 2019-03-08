time = Time.new(2017, 1, 31, 23, 30, 59)

require 'date'

date = Date.new(2017, 1, 31)

date_time = DateTime.new(2017, 1, 31, 23, 30, 59)

puts time
puts date
puts date_time

# =>
# 2017-01-31 23:30:59 +0900
# 2017-01-31
# 2017-01-31T23:30:59+00:00