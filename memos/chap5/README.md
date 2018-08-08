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

## ハッシュについてもう少し

### よく使われるメソッド

* keys
* values
* has_key?

```ruby
hash = {a: 1, b: 2, c: 3}
hash.keys # => [:a, :b, :c]
hash.values # => [1, 2, 3]
hash.has_key(:a) # => true
```

### **で展開

```ruby
hash = {a: 1, b: 2, c: 3}
# ハッシュリテラル内でのみ利用可能(もしくはmergeメソッド利用)
{ hoge: 4, **hash } # => {:hoge=>4, :a=>1, :b=>2, :c=>3}
{ hoge: 4 }.merge hash # => {:hoge=>4, :a=>1, :b=>2, :c=>3}
```

### 擬似キーワード引数

ハッシュを受け取ってキーワード引数のように利用する

```ruby
def buy(menu, options = {})
  drink = options[:drink]
  potato = options[:potato]
end

buy('cheese', drink: true, potato: true)
```

昔はこれでやってたので古いコードだと残っているかも,  
基本は新しいキーワード引数を使ったほうがいいよ(言語サポート機能なので)

### **引数

キーワード引数を使うと、メソッドに存在しないキーワードは受け取れない  
でもオプション的に追加したい場合

```ruby

def buy(menu, test: true, **options)
  if test
      drink = options[:drink]
      potato = options[:potato]
  end
end

buy('cheese', test: false, drink: true, potato: true) # => nil
```

### 最後の引数がハッシュであれば、{}は省略できる

```ruby
def buy(menu, options = {})
  drink = options[:drink]
  potato = options[:potato]
end

buy('cheese', { drink: true, potato: true }) # 普通に考えるとこうだけど
buy('cheese', drink: true, potato: true) # 引数の最後がハッシュであれば、これでおk
```

## ハッシュとブロックの{}

```ruby
def buy(options = {}, menu)
  drink = options[:drink]
  potato = options[:potato]
end

buy({ drink: true, potato: true }, 'cheese') # => これはOK
# これはだめ,, ハッシュの{}がブロックの{}として解釈されてしまう
buy { drink: true, potato: true }, 'cheese'
Traceback (most recent call last):
        1: from /usr/local/bin/irb:11:in `<main>'
SyntaxError ((irb):38: syntax error, unexpected ':', expecting '}')
buy { drink: true, potato: true }, 'chees...
           ^
(irb):38: Can't assign to true
buy { drink: true, potato: true }, 'cheese' 
```

## ハッシュと配列

```ruby
# to_h, to_aで変換可能
{ drink: true, potato: true }.to_a # => [[:drink, true], [:potato, true]]
[[:drink, true], [:potato, true]].to_h # => {:drink=>true, :potato=>true}
# to_hはRuby2.1からの新し目機能

# 古いのだと下
Hash[{ drink: true, potato: true }] # => {:drink=>true, :potato=>true}
```

## ハッシュの初期値

ハッシュは存在しないキーを取得しようとするとnilを返す  
Hash.newで宣言するときは初期値を設定できる

```ruby
h = Hash.new('default_value')
h[:a] # => "default_value"
h[:b] # => "default_value"
# 初期値は全て同じオブジェクトで作成されるので、破壊的変更には要注意

h[:b].upcase! 
h[:c] # => "DEFAULT_VALUE" // 変わっちゃった
```

## シンボルについて

シンボルはもう少し柔軟に宣言できる

```ruby

:12345 # => エラー
# クォーテーションで囲めば通る
:'12345' # => :"12345" 

# 式展開も可能
a = "hoge"
:"#{a}" # => :hoge 
```

### %s, %i(式展開したい場合は%I)

シンボルの作成とシンボルリストの作成

```ruby
%s!hoge hoge hoge! # => :"hoge hoge hoge"
%i!hoge test moge! # => [:hoge, :test, :moge]
```

### シンボルと文字列の関係

全く別物だけど`to_sym`, `to_s`メソッドで相互変換可能  
ただメソッドによっては文字列とシンボルを同等に扱うものあったりする  
(一般的には同等に扱わないほうが多いよ)