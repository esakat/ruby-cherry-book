# 5章のメモ(ハッシュとシンボル)

## ハッシュ

他言語でいう、連想配列とか辞書とかマップとか(キーと値の組み合わせ)

```ruby
# からハッシュ
hash = {}

# 要素を入れてみる
hash = {
  'japan' => 'yen',
  'us' => 'dollar'
}
```

同じキーが複数使われる場合は最後に出たほうが有効だけど,基本的にはこうならないようにすべし  

### ハッシュとブロックって同じ{}??

言語的には別の扱いだよ、使い続ければ見分けれるようになるとおもうよ

### 要素の追加,変更

```ruby
# 宣言
hash = {
  'japan' => 'yen',
  'us' => 'dollar'
}
# 追加
hash['italy'] = 'euro'

# 変更
hash['japan'] = '円'

# 取得, 存在しないキーの場合はnilが帰る
hash['us'] # => 'dollar' 
hash['hoge'] # => nil
```

### ハッシュの繰り返し

配列と同じ感じでできる

```ruby
# 宣言
hash = {
  'japan' => 'yen',
  'us' => 'dollar'
}

hash.each do |key, value| # ブロック引数を1つにすると配列でわたされる 
  puts "#{key} : #{value}"
end
# japan : yen
# us : dollar
```

### ハッシュの比較とか削除とか

ハッシュは全ての要素(キー:値の組み合わせ)が同じ場合は, equalと判定される

```ruby
# sizeメソッドで要素の個数を調べれる
hash = {
  'japan' => 'yen',
  'us' => 'dollar'
}
hash.size # => 2

# deleteメソッドで指定した要素を削除できる(戻り値は削除された要素の値)(keyがない場合はnil)
hash.delete('japan') # => "yen"
hash # => {"us"=>"dollar"}

```
