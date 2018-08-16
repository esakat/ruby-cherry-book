begin
  1 / 0
rescue => e
  puts "#{e.class}"
  puts "#{e.message}"
  puts e.backtrace
end