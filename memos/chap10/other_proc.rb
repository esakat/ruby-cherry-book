add_proc = Proc.new { |a, b| puts  a + b }

add_proc.call(10, 20)
add_proc.yield(10, 20)
add_proc.(10, 20)
add_proc[10, 20]

add_proc === [10, 20]

def judge(age)
  adult = Proc.new { |n| n > 20 }
  child = Proc.new { |n| n < 20 }

  case age
  when adult
    '大人です'
  when child
    '子供です'
  else
    '二十歳です'
  end
end

puts judge(25)
puts judge(10)
puts judge(20)

reverse_proc = Proc.new { |s| puts s.reverse }
['Ruby', 'man', 'Perl'].map(&reverse_proc)


# シンボル名のメソッドをprocにできる
split_proc = :split.to_proc
# 第１引数はレシーバーに
puts split_proc.call('a-b-c-d e')

# 第２引数はメソッドの第１引数に
puts split_proc.call('a-b-c-d-e', '-')

# 第3引数はメソッドの第２引数に
puts split_proc.call('a-b-c-d-e', '-', 3)

def generate_proc(array)
  counter = 0
  Proc.new do
    counter += 10
    array << counter
  end
end

values = []
sample_proc = generate_proc(values)
puts values # => []

sample_proc.call
puts values # => [10]

sample_proc.call
puts values # => [10, 20]