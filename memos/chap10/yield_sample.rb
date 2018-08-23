def greeting
  puts 'おはよう'
  # ブロックが与えられたかの判定
  if block_given?
    yield
  end
  puts 'こんばんは'
end

greeting
greeting do
  puts 'こんにちは'
end

def greeting2
  puts 'hello'
  text = yield 'hi', 12345 # 逆にyieldからブロックに引数を渡す, 引数はよしなに合わせてくれる(この場合第二引数は無視される)
  puts text # => hihi
  puts 'goodbye'
end

greeting2 do |text|
  text * 2
end

def greeting3
  text = yield 'hoge'
end

greeting3 do |text, nothing| # １つしか渡されない場合は２つ目はnilになる
  text + nothing.inspect
end

def greeting4(&block)
  puts 'おはよう'
  text = block.call('こんにちは')
  puts text
  puts 'byebye'
end

greeting4 do |text|
  text*2
end

def greeting5(a, c, &b)
  puts a
  unless b.nil?
    text = b.call('hi')
    puts text
  end
  # ブロック引数与えられてても普通にyieldでもいいよ
  #
  puts c
end

greeting5('Hello', 'bye')
greeting5('Hello', 'bye') do |text|
  text.upcase
end