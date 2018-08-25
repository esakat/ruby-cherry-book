def proc_return
f = Proc.new { |n| return n * 10 }
ret = [1,2,3].map(&f)
"ret: #{ret}"
end

def lambda_return
  f = ->(n) { return n * 10 }
  ret = [1, 2, 3].map(&f)
  "ret: #{ret}"
end

puts proc_return
puts lambda_return

def proc_break
  f = Proc.new { |n| break n * 10 }
  ret = [1,2,3].map(&f)
  "ret: #{ret}"
end

def lambda_break
  f = ->(n) { break n * 10 }
  ret = [1, 2, 3].map(&f)
  "ret: #{ret}"
end

# puts proc_break # => これは例外になる
puts lambda_break

