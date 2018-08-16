begin
  1 / 0
rescue ZeroDivisionError
  puts "0除算"
rescue ParseError, TimeoutError
  puts "複数の例外キャッチを同時に"
rescue NoMethodError
  puts "存在しないメソッド呼び出し"
rescue StandardError
  puts "その他例外が発生しました"
end