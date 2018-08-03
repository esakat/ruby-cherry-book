# 2章のメモ

## Rubyは全てオブジェクト

nilとかも全てメソッド呼び出しできる
```ruby
'1'.to_s # => "1"
nil.to_s # => ""
false.to_s # => "false"
/¥d+/.to_s # => "(?-mix:¥d+)"
```

## メソッド呼び出し

普通の形  
`オブジェクト.メソッド(引数1, 引数2, ..)`

カッコ省略も可能  
`オブジェクト.メソッド 引数1, 引数2, ..`

```ruby
1.to_s() # => "1"
1.to_s # => "1"
10.to_s 16 # => "a"
```

## 文の区切り

rubyは改行が文の区切り  
セミコロンは不要(使って１行に入れることもできる)

文が続くのが明示的な場合は改行しても同じ文として認識される  
バックスラッシュで明示可能
```ruby
1.to_s; nil.to_s; 10.to_s

10.to_s(
  16
)

10.to_s \
16
```

コメントは`#`と`=begin , =end`の２種類がある  
がrubyでは複数行コメントでも`#`を使うことが多い

```ruby
=begin
コメントです
=end

# コメントです
```

## 空白文字

識別子などの区切りは空白必要  
演算子では不要だけど可読性のため入れたほうがいいよ

## リテラル

ソースコードに直接埋め込める値のこと(数値や文字列とか)  

```ruby
# 数値
123

# 文字列
"Hello"
```

## 変数宣言と代入

rubyは動的型付けなので型指定とかは不要

```ruby
# 変数名 = 式や値
a = 'Hello'
b = 123

# 変数宣言だけは不可
c # => NameError (undefined local variable or method `c' for main:Object)

# rubyの慣習では変数はスネークケースが使われる
human_name = "taro" 

# rubyは同じ変数に異なる型を代入できるがもちろん非推奨
d = 1
puts d # => 1
d = "hoge"
puts d # => hoge

# 同時代入も可能
e, f = 1, 2
e # => 1
f # => 2
# 足りない場合はnilが入る
g, h = 10
g # => 10
h # => nil
# 多い場合は切り捨てられる
i, j = "hoge", "fuga", "moge" 
i # => hoge
j # => fuga
```

## 文字列

rubyで文字列はシングルクォーテーションかダブルクォーテーションで挟むことで作成できる  
文字列としての値は変わらないが、挙動が少し異なる

```ruby
# ダブルだと改行コードなども識別できる
puts "Hello,\n World!" 
# Hello,
#   World!

# シングルは無視される 
puts 'Hello,\n World!'
# Hello,\n World!

# 式展開もダブルのみ可能
name = 'Bob'
puts 'Hello, #{name}' # => Hello, #{name}
puts "Hello, #{name}" # => Hello, Bob

# 文字連結もできるけど式展開の方がいいよ
puts 'Hello, ' + name # => Hello, Bob

# エスケープ文字は他言語同様にバックスラッシュ 
puts "Hello,\\n World!"  # => Hello,\n World!
```

### 文字列の比較

`==`or`!=`を使う  
`>`,`<`で大小比較も可能(これは文字コードの大小で判定)

```ruby
'ruby' == 'ruby' # => true
'ruby' == 'Ruby' # => false
```

## 数値

```ruby
# 整数
10
# 小数
1.5
# 負の数
-3


# _を含めて、桁をわかりやすくできる(このとき_は無視される)
1_000_000_000 # => 1000000000

# 四則演算はもちろん可能
1 + 3 - 5 # => -1
2 * 5 / 5 # => 2 

# 変数の前に-をつけると正負を反転できる
n = 10
-n # => -10

# to_fメソッドで整数を小数にできる
n = 10
n.to_f # => 10.0

# % は余剰を求めれる, **はべき乗を求めれる
8 % 3 # => 2
2 ** 5 # => 32

# 演算子の比較は >, >=, <, <=が使える ==, !=で同値判定も可能
3 > 3
3 >= 3
...

# 演算子の優先順位は一般的な *,/ > +,-
# ()で挟むことで優先度あげれるのも一般的なもの
2 * (4 + 4) / 8 # => 2 

# rubyには ++, --みたいな値増減演算子がない
# 代わりに +=, -=が用意されている

n = 10
n += 1 # => 11
n -= 10 # => 1


# 文字列と数値の足し算はエラーになるよ jsみたいによしなにしてくれない
1 + "1"
# Traceback (most recent call last):
#         3: from /usr/local/bin/irb:11:in `<main>'
#         2: from (irb):43
#         1: from (irb):43:in `+'
# TypeError (String can't be coerced into Integer)

# 型変換が必要
1 + "1".to_i # => 2
1 + "1".to_f # => 2.0

# 逆も然り
"Number is " + 3
# Traceback (most recent call last):
#        3: from /usr/local/bin/irb:11:in `<main>'
#        2: from (irb):46
#        1: from (irb):46:in `+'
# TypeError (no implicit conversion of Integer into String)

# 型変換が必要
"Number is " + 3.to_s # => "Number is 3"
```

### 丸め誤差

こういうやつ

```ruby
0.1 * 3.0 # => 0.30000000000000004
0.1 * 3.0 == 0.3 # => false
```

Rational(有理数)クラスを使うと解消できる

```ruby
0.1r * 3.0r # => (3/10)
0.1r * 3.0r == 0.3 # => true

# 変数の場合はrationalizeメソッドで呼べるよ
n = 0.1
n.rationalize * 3.0r # => (3/10)

# to_fで普通の小数に戻せる
(n.rationalize * 3.0r).to_f # => 0.3
 
```
