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

## シンボル

文字列と１対１で対応するオブジェクト`:シンボル名`で宣言できるよ

### 文字列との違い

クラスが違う

```ruby
'apple'.class # => String
:apple.class # => Symbol
```

シンボルは内部では整数として管理されている、そのためequalの比較とかは文字列より高速にできる  
同じシンボルは全く同じオブジェクトになる  
大量に作成するときは、文字列よりシンボルのほうが効率よくなる

```ruby
:apple.object_id # => 1272988
:apple.object_id # => 1272988
:apple.object_id # => 1272988
'apple'.object_id # => 70137994999860
'apple'.object_id # => 70137994996200
'apple'.object_id # => 70138007394200
```

シンボルはイミュータブルなオブジェクトですよ

### シンボルの用途

名前を識別できるようにしたいけど、文字列を使う必要がないもの  
ハッシュのキーとかはシンボルがいいよ

```ruby
a = { :japan => 1, :us => 2, :eu => 3 }
a[:japan] # => 1 // 文字列でやるより高速
```

Rubyの内部でもメソッドの情報はシンボルで管理されている
```ruby
'apple'.methods # => [:encode!, :include?, :%, :*, ...]
```

Rubyではシンボルが色々使われているのでRubyの思想を知るためにはいいかもね


## ハッシュについてもう少し詳しく

ハッシュのキーをシンボルにする場合は`=>`を使わなくても作れる  
`シンボル名: 値`でいけるよ

```ruby
a = { :japan => 1, :us => 2 }
b = { japan: 1, us: 2 }
a == b # => true
```

これはかなり良く使われる手法です

ハッシュのキーは同じ型で揃える必要はない(できるというだけで統一したほうがいいよ)
値に関しても型は揃っている必要はない(これはよくあるよ)

```ruby
person = {
  name: 'Alice',
  age: 20,
  friends: [:Bob, :John],
  phones: {home: '0101122', mobile: '1112222'}
}
```

### キーワード引数

メソッドは引数がなにかよくわからないことあるよね  
メソッド宣言時にキーワード引数を設定するとわかりやすくなるよ


```ruby
def get_number(num, count: 1, hoge: 3)
  num * count * hoge
end

# 呼ぶときはキーワード引数指定
get_number(1, count: 2, hoge: 1) # => 2

# ないとエラー
get_number(1, 2, 1)
# ArgumentError (wrong number of arguments (given 3, expected 1))

# 指定しないとデフォの値が使われる
get_number(1) # => 3

# キーワード引数を使うと、引数の順番も入れ替えれる
get_number(1, hoge: 10, count: 20) # => 200

# デフォルト値なしでも宣言できるよ
def get_number(num, count: , hoge:)
  num * count * hoge
end 
```