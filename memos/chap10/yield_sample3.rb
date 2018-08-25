def greeting(&block)
  puts 'おはよう'
  text =
      if block.arity == 1
        # ブロック引数が１個の場合
        yield 'こんにちは'
      elsif block.arity == 2
        # ２この場合
        yield 'こんに', 'ちは'
      end
  puts text
  puts 'こんばんは'
end

# 引数の数に応じた処理が組める
greeting do |text|
  text * 2
end

greeting do |text, other|
  text * 2 + other * 2
end