# 日本語版
def greeting_ja(&block)
  texts = ['おはよう', 'こんにちは', 'こんばんは']
  # 別メソッドにそのままブロック引数を渡す(この時も&をつけないとブロック引数と認識されない)
  greeting_common(texts, &block)
end

# 英語版
def greeting_en(&block)
  texts = ['Good Morning', 'hello', 'good evening']
  # 別メソッドにそのままブロック引数を渡す
  greeting_common(texts, &block)
end

# 共通処理
def greeting_common(texts, &block)
  puts texts[0]
  # ブロックを実行
  puts block.call(texts[1])
  puts texts[2]
end

greeting_ja do |text|
  text * 2
end

greeting_en do |text|
  text * 2
end