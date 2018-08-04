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

## 真偽値と条件分岐

Rubyの真偽値のルール

* false or nilであれば偽
* それ以外は全て真

(-1とかも真になるので要注意)

nilが偽になるのはなぜか？  
オブジェクトがnilかどうかで条件分岐する機会が多いから便利だよ  
(Goとかだとちょっと冗長だよねイメージ)

```ruby
data = find_data
if data # nilならfalseになる
  'データがあります'
else
  'データがありません'  
end
```

Goとかだとこうだよね

```go
data, err := findData()
err != nil {
	return err
} else {
	return data
}
```

### 論理演算子

他の言語と特に変わりない

* `&&` : and条件
* `||` : or条件
* `!***` : 真偽値の反転

or条件の方が優先度高、演算子のように()で包むと優先順変えれるよ

### if文

rubyのifは文じゃなくて式だった気がする

rubyのif-else

```ruby
if conditionA 
  # 条件A時の処理
elsif conditionB
  # 条件B時の処理
else
  # その他の時の処理
end
```

Rubyのifは式で、最後に評価された値を返すのでif結果を代入できる

```ruby

conuntry = 'italy'
greeting =
    if conuntry == 'japan'
      'こんにちは'
    elsif conuntry == 'italy'
      'ciao'
    else
      '???'
    end
# => "ciao"
```

### 後置if

Rubyではifを修飾子として文の後ろに置ける

```ruby
# 普通のコード
point = 7
day = 1
if day == 1
  point *= 5 
end
point # => 35

# 後置if
point = 7
day = 1
point *= 5 if day == 1
point # => 35
```

### if-then

if, elsifの後ろにthenも入れれる  
これを使うと条件と処理を１行にまとめれる  
使用頻度は少なめ

```ruby
a = "hoge"
if a == "hoge" then "hello"
elsif a == "fuga" then "world!"
else "bye"
end
# => "hello"
```

## メソッドの定義

Rubyはdefでメソッド定義できる

```ruby
def メソッド名(引数)
  # 処理
end
```

メソッド名もスネークケースで書くのが慣例  
戻り値に関する情報はメソッド定義に出てこない  
メソッドの処理内で最後に評価された式が戻り値になるので、`return`は不要  
(一応returnは使えるけど、rubyでは使わないのが一般的)

```ruby
# 一般的なrubyの書き方
def test(a)
  if a == 'hoge'
    'こんにちは'
  else
    'Hello'
  end
end

# returnも一応使える
def test2(a)
  if a == 'hoge'
    return 'こんにちは'
  else
    return 'Hello'
  end
end
# 中身は両方同じ
```

returnはメソッドの途中で抜け出す時に使われることが多い

```ruby
def hoge(a)
  return 'aが入力されていません' if a.nil?
  
  if a == 'hoge'
    return 'こんにちは'
  else
    return 'Hello'
  end 
end

hoge nil # => "aが入力されていません"
```

引数のないメソッドは宣言時に`()`が不要  
つけてもいいけど一般的に外されるらしい

```ruby
# ()は省略できる
def hello_world
  'Hello, World!'
end

# 引数ありでも()を外せるけど、引数ありの場合は()をつけるのが一般的
def hello_world name
  "Hello, #{name}" 
end
hello_world 'esaka' # => "Hello, esaka"
```


## 文字列についてもう少し詳しく

文字列は全てStringクラスのオブジェクト

```ruby
# .classでクラス名を見れる
abc'.class # => String
```

シングル・ダブルクォーテーションで挟むいがいに`%q!  !`で挟むことでもできる
```ruby
# %q!!で挟むのはシングルクォーテーションで挟むのと同義
puts %q!He said, "Don't speak"! # => He said, "Don't speak"

# %Q!! , %!!で挟むのはダブルで挟むのと同じ(式展開可能)
name = "hoge"
puts %Q!He said, "#{name}"! # => He said, "hoge"

# !じゃなくても区切りもじに使えるよ
puts %? hoge hoge #{name}? # => hoge hoge hoge
```

### ヒアドキュメント

複数行にコメントの書き方

```ruby
# EOFが識別子になっている(なんでもいいよ別に)
a = <<EOF
これはヒアドキュメントです
複数行の長い文字列用
改行もおk
EOF # => "これはヒアドキュメントです\n複数行の長い文字列用\n改行もおk\n"

puts a
# これはヒアドキュメントです
# 複数行の長い文字列用
# 改行もおk
```

`<<識別子`という使い方  
`<<-識別子`にすると最初の識別子をインデントできる  
`<<'識別子'`これだと式展開できない、(普通はできる、ダブルクォーテーションつけても同じ)
```ruby
a = "test"
b = 
  <<-HTML
<div>
  <p>#{a}</p>
</div>
  HTML
puts b

c = 
  <<HTML
<div>
  <p>test</p>
</div>
  HTML
# => これだと終わらない
```

`<<TEXT`は式なので、これに対してメソッド呼び出しも可能
```ruby
b = <<TEXT.upcase
hoge
hello
TEXT
puts b 
# HOGE
# HELLO
```

### フォーマット指定

`sprintf`メソッドで可能

```ruby
# 小数第３位まで表示
sprintf('%0.3f', 1.20) # => "1.200"

# こんなのもできるよ
'%0.3f + %0.3f' % [1.3, 0.48] # => "1.300 + 0.480"
```

### 他のオブジェクトから文字列作成

`to_s`メソッドや配列を`.join`メソッドでつなげたり

```ruby
1.to_s # => "1"
[1,3,4].join # => "134"
'Hi!' * 10 # => "Hi!Hi!Hi!Hi!Hi!Hi!Hi!Hi!Hi!Hi!"
```

### 文字列と文字について

rubyでは文字と文字列を区別しない

## 数値について


### 10進数以外

`0b`始まりは2進数, `0`始まりは8進数, `0x`始まりは16進数

### ビット演算

できるよ必要になったら覚えるくらいでいいかな

```ruby
(0b1010 & 0b1111).to_s(2) # => "1010"
(0b1010 | 0b1111).to_s(2) # => "1111"
```

### 指数

`2e-3`は`2 × 10の-3乗`を意味する
```ruby
2e+3 # => 2000.0
```

### 数値のクラス

文字のように１クラスだけじゃない  
(`Numeric`クラスのサブクラスではある)

```ruby
>> 10.class
=> Integer
>> 10.0.class
=> Float
```

ruby2.4から整数は全てIntegerにまとめられた

整数のInteger, 小数のFloat, 有理数のRational, 複素数のComplexがある

## 真偽値をもう少し

&&, ||を使った場合、必ずtrue or falseが返るわけではない  
真偽が確定した時点の式が返される

```ruby
1 && 3 # => 3
1 || 3 # => 1
false || 1 # => 1
false && 1 # => false
```
&&,||と似た働きとして`and` `or` `not`などがある  
これは演算子の優先順位が低い(&&, ||に比べて)

また、&&と||では&&の方が優先度高かったが
and と orは同じ優先度になる(左から順に評価される)

```ruby
true || true && false # => true (先に&&が評価された後に||が評価されるから true || falseでtrueになる )
true or true and false # => false (左から順に評価されるから true and false が最後に評価されて、falseになる)
``` 

and,orは条件分岐ではなく、制御フローへの利用用途によく使われる  
```ruby
# Aが真か? 真であればBせよ みたいな制御フローに使われる
user.valid? and do_method user
```

### unless

ifの反対(条件が偽の時実行される)  
elseもある、thenもある(elsifはない)  
別に`if !条件`でもいい見やすさで使い分けられるかな


### case

elsifが複数重なるときはcaseですね  
他の言語のcase文とほとんど同じ

whenで複数の値を指定できるのは珍しいかも  
これも式なので、結果を代入可能

```ruby
a = "hoge"
answer = 
    case a
    when "ho", "fu"
      "--"
    when "hog", "fug"
      "--"
    when "hoge", "fuga"
      "!!!!"
    else
      "--"
    end
puts answer # => "!!!!"
```

### 三項演算子

使えるよ

`式 ? 真だった場合の処理 : 偽だった場合の処理` 他の言語と構文同じ
```ruby
true ? "!" : "_"  # => "!"
false ? "!" : "_" # => "_" 
```

## メソッド定義についてもう少し

### デフォルト値つき引数

```ruby
def default_arg(a = 10, b = 0, c = 2, d = 4)
  puts a
  puts b
  puts c
  puts d
end

default_arg(-1)
# -1
# 0
# 2
# 4
```

### ?で終わるメソッド

rubyの慣習として、真偽値を返すメソッドは?で終わるようにしている(javaのisHogeHogeメソッドみたいな感じかと)  
標準メソッドもそれで作られている、自分で作る際もそうした方が良い　
```ruby
"".empty? # => true
"a".empty? # => false
```

### !で終わるメソッド

!で終わるのは利用が要注意のメソッド

(?ほど絶対的な慣例ではない)

Stringクラスには`upcase`と`upcase!`という大文字に変えるメソッドが2つある  
`upcase`は呼び出しオブジェクトは変更されず、新しいオブジェクトを返す  
`upcase!`は呼び出しオブジェクトを変更してしまう

```ruby
a = "hoge"
a.upcase # => "HOGE"
a # => "hoge"
a.upcase! # => "HOGE"
a # => "HOGE"
```

## その他

* rubyはGCを持っている言語  
* rubyでは同じ働きをする別名メソッドがよくある(エイリアスメソッド)

### 式と文

rubyでは他の言語では文で扱われるものも式で扱われることが多い(ifとか)  
値を返し、変数に代入できるのが式、できないのが文

### 擬似変数

特殊な識別子(nilとかtrue,falseとか)

* self
* __FILE__
* __ENCODING__

とかあるよ

擬似変数は代入しようとするとエラーになります。

### 参照

rubyの変数はオブジェクトのそのものではなく、オブジェクトへの参照が格納される  
(object_idメソッドで参照しているオブジェクトがわかる)

```ruby
a = 'hello'
b = 'hello'

# 同じ値でも別オブジェクト
a.object_id # => 70187202362520
b.object_id # => 70187198501900
# 代入したら、同じオブジェクトを参照する
 # 
a = b
a.object_id # => 70187198501900 (bのobject_id)

# メソッドの引数も参照が渡される
def aaa(x)
  x.object_id
end
aaa a # => 70187198501900

# equal?メソッドで確認できる
c = 'hello' 
a.equal? c # => false
a.equal? b # => true

# 参照しているの全てに影響が出る
a.upcase! # => "HELLO"
b # => "HELLO"
c # => "hello" 参照先が違うので影響受けない
```

### 組み込みライブラリと標準ライブラリとgem

Rubyでは多くのライブラリが標準ライブラリとして用意されている。特に使用頻度が高いのは組み込みライブラリとして提供されている  
その他サードパーティのライブラリはgemでパッケージ管理されている


### require

組み込みライブラリ以外のライブラリを使う際は`require　ライブラリ名`で読み込みが必要  
```ruby
Date.today
Traceback (most recent call last):
        2: from /usr/local/bin/irb:11:in `<main>'
        1: from (irb):178
NameError (uninitialized constant Date)
Did you mean?  Data

require 'date' # => true
Date.today # => #<Date: 2018-08-04 ((2458335j,0s,0n),+0s,2299161j)>
```

自分で作成したプログラム(.rb)を参照したい場合は  
`require ./sample.rb`など相対パスor絶対パスで指定する(.rbは省略しても良い)

### load

requireは１回しか読み込まれない

```ruby
require './sample' # => true
# この後sample.rbに変更を入れる
require './sample' # => false 変更を反映できない

load './sample' # true loadであればなんどもできる
```

### require_relative

requireのパス起点はRuby実行しているディレクトリ  
require_relativeにすれば、ファイルのパスが起点になる

### puts , print pメソッドの違い

```Ruby
a = "test\nhoge"
# putsは最後に改行を入れる
puts a
# test
# hoge 
# => nil
# printは改行を入れない 
print a
# test
# hoge=> nil
# pはputs同様に改行を入れて、値をダブルクォーテーションで囲む,また返り値がわたしたオブジェクトになる 
p a
# "test\nhoge"
# => "test\nhoge"
```

使い分けとしては、puts, printは一般ユーザ向け、　pメソッドは開発者向けって感じ   
内部的にはputs, printは引数に対してto_sメソッドを  
pメソッドは引数に対してinspectメソッドを呼び出している


### コーディングルール

公式としてはない

下がよく使われるかな
https://github.com/rubocop-hq/ruby-style-guide