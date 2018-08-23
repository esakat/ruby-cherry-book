# helloという文字列を返すProcオブジェクト
hello_proc = Proc.new do
  'hello'
end

# do_end記法じゃなくてもいい
hello_proc2 = Proc.new { 'hello!'}

# 呼び出し
puts hello_proc.call # => hello

# 引数をもつProc
add_proc = Proc.new { |a=0, b=0| a + b }
puts add_proc.call() # => 0
puts add_proc.call(2) # => 2
puts add_proc.call(1, 4) # => 5

# Proc.new以外での生成方法

divide_proc = proc { |a, b| a / b }
puts divide_proc.call(10, 2) # => 5