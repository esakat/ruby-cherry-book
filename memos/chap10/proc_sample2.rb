def greeting(&block)
  puts block.class # => Proc
  text = block.call('こんにちは')
  puts text
end

# 普通にブロック
greeting do |text|
  text * 2
end

# Procを渡す
repeat_proc = proc { |text| text * 2 }
# &指定が必要
greeting(&repeat_proc)


# 普通の引数として渡すと
def greeting2(not_block)
  puts not_block.class # => Proc
  text = not_block.call('こんにテャ')
  puts text # => こんにテャこんにテャ
end
greeting2(repeat_proc)
# 普通にブロック引数として動いている


# Procの場合は普通のオブジェクトなので、複数のProcを渡せる
def greeting3(proc1, proc2, proc3)
  puts proc1.call('hello')
  puts proc2.call('hello')
  puts proc3.call('hello')
end

upcase_proc = proc {|text| text.upcase}
add_hoge_proc = proc { |text| text + 'hoge' }

greeting3(repeat_proc, upcase_proc, add_hoge_proc)
# =>
# hellohello
# HELLO
# hellohoge