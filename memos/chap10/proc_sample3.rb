# lambdaでproc
proc1 = -> a, b { a + b.to_i}
# lambdaでproc 引数なし
proc2 = -> {'Hello!'}

proc3 = proc { |a, b| a + b.to_i }

# 普通のproc生成との違い
puts proc1.call(1, 4)
puts proc3.call(1, 4)

# ラムダは引数のチェックが厳密になる
puts proc3.call(1) # => 1
#puts proc1.call(1) # => wrong number of arguments

# lambdaとprocの見分け方、　クラスは一緒

puts proc1.class # => Proc
puts proc2.class # => Proc
puts proc3.class # => Proc
puts proc1.lambda? # => true
puts proc2.lambda? # => ture
puts proc3.lambda? # => false