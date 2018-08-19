# method_1だけ例外捕捉を記述
def method_1
  puts 'method_1 start'
  begin
    method_2
  rescue
    puts '例外発生'
  end
  puts 'method_1 end'
end

def method_2
  puts 'method_2 start'
  method_3
  puts 'method_2 end'
end

def method_3
  puts 'method_3 start'
  # ZeroDivision
  1 / 0
  puts 'method_3 end'
end

method_1

# Output
# ==>
# method_1 start
# method_2 start
# method_3 start
# 例外発生
# method_1 end