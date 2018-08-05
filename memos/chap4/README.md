# 4章のメモ

## 配列

複数のデータをまとめて格納できるオブジェクト  

### 配列の基本

```ruby
# からの配列を作る
[]

# ２つの要素をもつ配列
["a", "b"] 

# 最後の要素後に,がついていても文法エラーにならない
[
   "a",
   "b",
   "c",
]

# 異なるデータ型を一緒に格納できる
[1, "a", 0.1, true]  # => [1, "a", 0.1, true] 

# 配列の中に配列も可能
[["a", "b"], [1, 2]]

# 添字を指定して中身取り出せる
a = [["a", "b"], [1, 2]]
a[0] # => ["a", "b"]
a[0][0] # => "a"

# サイズ以上を指定するとnilが返る
a[2] # => nil
# サイズはsize or lengthメソッドで確認できる
a.size # => 2

# 添字指定して代入で値を更新
arr = [1, 2, 3] # => [1, 2, 3]
arr[0] = "one"
arr # => ["one", 2, 3]

# 元の数より大きい添字指定すると間がnil埋めされる
arr[5] = "six" # => "six"
arr # => ["one", 2, 3, nil, nil, "six"]

# << で配列の末尾に要素追加
arr << "seven"
arr # => ["one", 2, 3, nil, nil, "six", "seven"]

# 削除はdelete_atメソッドで 
arr.delete_at(3) # => nil
arr # => ["one", 2, 3, nil, "six", "seven"]

# 多重代入(以下2つは同義) 
a, b = 1, 2 
a, b = [1, 2] 
a # => 1
b # => 2
# 足りない場合はnil, はみ出る場合は切り捨ても2章と同じ

# 配列で結果を返すメソッドの受け取りに使うと良い
14.divmod(3) # => [4, 2] // 商と余りを配列で返すdivmodメソッド、配列で受けると扱いづらいので

quo, rem = 14.divmod(3)
puts "商=#{quo}, 余り=#{rem}" # => 商=4, 余り=2
```

## ブロック

メソッドに引数で渡せる処理の塊(繰り返し処理で見てみる)

```ruby
numbers = [1, 2, 3, 4]
sum = 0
numbers.each do |n|
  sum += n
end
sum
```

Rubyにもfor文もあるけど、ほぼ使わない  
eachなど、配列に「繰り返し」命令を送る

eachはjavaのfor拡張文

eachはメソッドなわけだけど、引数はなに？  
上の例だと`do`から`end`まで(つまりブロック)を引数として渡している

eachは配列の要素を順番に取り出すという責務
それぞれの要素に何をするかはブロックの責務

`|n|`はブロック引数と呼ばれる(numbersの各要素が入る)(1,2,3,4が順番に入る)

### その他のブロックを使うメソッド

```ruby
# deleteメソッドは値が完全一致する要素だけを消せる
a = [1,2,2,1,3,4,6,7,11]
a.delete(2)
a # => [1, 1, 3, 4, 6, 7, 11]

# delete_ifだとブロックを使ってもっと柔軟な条件で消せる
a = [1,2,2,1,3,4,6,7,11]
a.delete_if do |n|
  # 奇数だけ削除
  # 処理内でtrueになった要素だけ削除される 
  n.odd?
end
a #  => [2, 2, 4, 6]
```

delete_ifメソッドは「配列の要素を順番に取り出す」「ブロックの戻り値が真であれば要素削除」  
どの要素を真とするかはブロック側に任せる

Rubyでは要件を問わず共通する処理はメソッド自身、要件ごとの異なる処理はブロックに任せるというメソッドが多い.

ちなみにブロック変数はnじゃなくてもOK(iとかnumberとかでいいよ)  
ブロック変数使わない場合は省略可能

```ruby
numbers.each do
  sum += 1
end
```

```ruby
# ブロック内は複数行かけるよ
numbers = [1, 2, 3]
numbers.each do |n|
  sum_value = n.even? ? n * 10 : n
  sum += sum_value 
end
# ブロック内で宣言した変数のスコープはブロック内のみ
sum_value
# Traceback (most recent call last):
#        2: from /usr/local/bin/irb:11:in `<main>'
#        1: from (irb):62
# NameError (undefined local variable or method `sum_value' for main:Object)
```

```ruby
# 1行でもかける
numbers.each do |n| sum += n end

# 1行で書くときはdo,endの代わりに{}で挟むのが一般的
numbers.each { |n| sum += n } 
```

### ブロックを使う、その他のメソッド

#### map, collect

各要素に対して、ブロックで評価した値を新しい配列に対して返す

```ruby
numbers = [1, 3, 5]
new_numbers = numbers.map { |n| n * 10 }
new_numbers # => [10, 30, 50]
```

#### select, find_all, reject

ブロック内で評価が真にされた要素だけで新しい配列を返す(他言語でいうfilter)

```ruby
numbers = [1, 3, 5]
new_numbers = numbers.select { |n| n >= 3 }
new_numbers # => [3, 5]
```

find_allはselectのエイリアス, rejectは真じゃなくて、偽のやつだけ返す

#### find, detect

ブロック内で最初に真と評価された値を返す

```ruby
numbers = [1, 3, 5, 6]
new_numbers = numbers.find { |n| n.even? }
new_numbers # => 6
```

#### inject, reduce

たたきこみ演算

```ruby
numbers = [1, 3, 5]
# ブロック変数の第１引数(result)が前回のブロック処理の返り値(初回はinject(0)の0が渡される)
# 第二引数は numbersが1つづつ渡される 
new_numbers = numbers.inject(0) { |result, n| result + n }
# |result, n|のセットは→の感じ |0, 1| → |1, 3| → |4, 5|
new_numbers # => 9
```

### &とシンボルでわかりやすく

```ruby
['ruby', 'java', 'perl'].map { |s| s.upcase } # => ["RUBY", "JAVA", "PERL"]
# こう書き換えられる(ラムダ式みたいだね)
['ruby', 'java', 'perl'].map(&:upcase)
```

`&:メソッド名`でブロックに渡せるらしい  
いかの条件が揃った時だけ使える

* ブロック引数が1つだけ
* ブロックの中で呼び出すメソッドは引数がない
* ブロックの中でブロックの引数に対して、メソッドを１回呼ぶ以外の処理がない

## Range

Rubyには範囲を表すオブジェクトがある  
`最初の値..最後の値`or`最初の値...最後の値`でできる  
.が2つだと、最後の値を含む、　３つだと最後の値を含まない  

```ruby
# クラスはRange
(1..5).class # => Range
(1...5).class #=> Range

(1..5).include?(0)   # => false
(1..5).include?(4.9) # => true
(1..5).include?(5)   # => true
(1...5).include?(0)  # => false
(1...5).include?(5)  # => false
```

### Rangeを使う例

```ruby
# 配列の指定した範囲の要素を取り出せる
a = ['a','b','c','d','e','f','g','h']
a[3..5] # => ["d", "e", "f"]

# 文字の範囲
a = "abcdefgh"
a[3..5] # => "def"

# n以上m未満の判定とか
def liquid?(temp)
  (0...100).include?(temp) 
end
liquid?(-1)  # => false
liquid?(10)  # => true
liquid?(100) # => false

# caseで使う
def charge(age)
  case age
  when 0..5
    "baby"
  when 6..12
    "boy"
  when 13..18
    "man"
  end
end
charge(1) # => "baby"
charge(13) # => "man"

# 配列の作成
(1..10).to_a # => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# splat展開 [*Range]でできる
[*1..10] # => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# 繰り返し処理
(1..10).select { |n| n.even? } # => [2, 4, 6, 8, 10]
```

## 配列もっと詳しく

```ruby
a = [1,3,5,7,9]
# 同義
a[1..3]
a[1, 3]

# values_atで値ごしも可能
a.values_at(0, 4) # => => [1, 9]

# マイナスの添字は最後から数えた要素
a[-1] # => 9
a[-2] # => 7
# lastメソッドもあるよfirstメソッドも
a.last # => 9
a.last(2) # =>  [7, 9]
a.first # => 1

# 代入について
# 範囲指定だと、要素数が減るよ
a = [1,3,5,7,9]
a[1, 3] = 100
a # => [1, 100, 9]
# pushメソッド
a.push(10) # => [1, 100, 9, 10]

# 配列の連結
a = [1,2]
b = [3,4]
# concatは破壊的代入(aが更新される)
a.concat(b)
a # => [1,2,3,4]
# + だと元のには影響ない
# 副作用を考えると、こちらを使うのが推奨される 
a + b # => [1,2,3,4]
a # => [1,2]

# 配列で集合の表現 |, -, &　を使える(使えるってだけ、集合使う場合はSetの方がいい)
a = [1,2,3]
b = [2,3,4]
a | b # => [1, 2, 3, 4]
a & b # => [2, 3]
a - b # => [1]

# 多重代入で余りを配列で受け取る.. *をつければいい
a, *b = 1,2,3,4,5,6,7,8 
a # => 1
b # => [2, 3, 4, 5, 6, 7, 8]

# メソッドの引数に配列を展開して渡したい(splat展開) これも*を使う
a = []
a.push([1,2,3])
a # => [[1, 2, 3]] 配列の中に配列になっている
a = []
a.push(*[1,2,3])
a # => [1, 2, 3]　展開されている
```

### 可変長引数

`*`をつけて可変長引数を表現できる  
可変長引数は配列として受け取れる

```ruby
def hoge(*c)
  c.each { |n| puts "hello, #{n}"}
end
hoge('a', 'b')
# => hello, a
# => hello, b
```

### もうちょい配列

```ruby
# 配列の中で配列を展開したい
a = [1, 2]
[0, *a, 3, 4] # => [0, 1, 2, 3, 4]

# 配列の比較は全ての要素が同じ時に真になる
[1,2,3] == [1,2,3] # => true
[1,2,3] == [1,3,2] # => false
[1,2,3] == [1,2,3,4] # => false
```

### 文字列の配列をもっと簡単に

```ruby
# より短くできる
%w!apple hoge orange! # => ["apple", "hoge", "orange"]
# 改行かスペースが区切りになる
%w(
  orange
  test
  moon
) # => ["orange", "test", "moon"]

# 式展開とかしたいときは %Wの大文字の方を使って
# 文字列にスペース入れたいときはバックスラッシュでエスケープ
%w(
  orange\ juice
  moon
) # => ["orange juice", "moon"]

# 文字列を1文字区切りで配列にする
'Ruby'.chars # => ["R", "u", "b", "y"]

# 指定した区切り文字で配列に
'abc,def,ghi'.split(',') # => ["abc", "def", "ghi"]
```

### 配列の初期化

`[]`じゃなくて`Array.new`でおk
```ruby
#　引数を渡すと、その数分のnil埋め要素ができる
a = Array.new(5) # => [nil, nil, nil, nil, nil]
# 第二引数で初期値を渡せる
a = Array.new(5, 'a') # => ["a", "a", "a", "a", "a"]
# 第二引数はブロックでもう少し高度な生成も可能
# 0始まりで１ずつ加算して、偶数は*10する
a = Array.new(10) { |n| n.even? ? n * 10 : n } # => [0, 1, 20, 3, 40, 5, 60, 7, 80, 9]

# 注意として、第二引数で渡すと参照値が全て同じになることがある
a = Array.new(5, 'a') # => ["a", "a", "a", "a", "a"] # => ["a", "a", "a", "a", "a"]
a[0].upcase!
a # => ["A", "A", "A", "A", "A"]

# ブロックで渡せば解決
a = Array.new(5) {'a'}
a[0].upcase!
a # => ["A", "a", "a", "a", "a"]

# これは文字列がRubyではミュータブルなものだから発生する
# イミュータブルな数値クラスとかだと、わざわざブロックにしなくて良い(そもそも破壊的変更が不可) 
```

## ブロックについてもう少し

### 添字も繰り返し内で欲しいとき

```ruby
fruits = %w!apple banana orange!
fruits.each_with_index { |fruit, i| puts "#{i}: #{fruit}" }
# 0: apple
# 1: banana
# 2: orange
```

これだとeachメソッドにしか使えない  
`with_index`メソッドが単独で用意されているので組み合わせ

```ruby
fruits = %w!apple banana orange!
fruits.map.with_index { |fruit, i| "#{i}: #{fruit}" }
# => ["0: apple", "1: banana", "2: orange"]

# 技術的にいうと、Enumeratorオブジェクトを返すものがwith_indexを呼べる
>> fruits.map
=> #<Enumerator: ["apple", "banana", "orange"]:map>
>> fruits.each
=> #<Enumerator: ["apple", "banana", "orange"]:each>
>> fruits.delete_if
=> #<Enumerator: ["apple", "banana", "orange"]:delete_if>
```

#### 添字を０以外始まり

with_indexメソッドに引数を渡せばok

```ruby
fruits = %w!apple banana orange!
fruits.map.with_index(1) { |fruit, i| "#{i}: #{fruit}" }
# => ["1: apple", "2: banana", "3: orange"]
```

### 配列のブロック引数

```ruby
xy = [
  # x座標, y座標
  [1, 10],
  [10, 2],
  [4, 6], 
]

# 面積を求める
xy.each do |n|
  area = n[0] * n[1]
  puts area
end
# 10
# 20
# 24

# ブロック引数を対応する数にすれば、展開して受け取れる
xy.each do |x, y|
  area = x * y
  puts area
end

# with_indexのように元から2つ受け取る場合は..? ()でくくってあげようしないと、xに配列で渡されて、yにindexが入る
xy.each_with_index do |(x, y), i|
  area = x * y
  puts "#{i} : #{area}"
end
# 0 : 10
# 1 : 20
# 2 : 24
```

### ブロックローカル変数

ブロック外と同名だけど別として扱いたい場合はブロック変数内で`;`の後に宣言すればいけるが
これはほとんど使われない、見通しも悪いし

```Ruby
sum = 10
[1,2,3].each do |n; sum|
  sum = ...
  ...
  # この中でsumに影響を与えても、ブロックがいのsumには影響なし
end
```

### do...end, {}の結合度の違い

`{}`の方が結合度が強い

```ruby
# {}を使うときはメソッドの引数は必ず()で括ること 結合度で{}に取られてしまう
[1,2,3].delete 5 { 'NG' }
# SyntaxError ((irb):259: syntax error, unexpected '{', expecting end-of-input)
# [1,2,3].delete 5 { 'NG' }
[1,2,3].delete(5) { 'NG' } # => "NG"
```

### do...end, {}に続けてメソッド呼び出し

```Ruby
# こんな風に呼び出せるよ
[1,2,3].map {|n| n * 5}.select(&:even?)
# doendも同様に
[1,2,3].map do |n| 
  n * 5
end.select do |n|
  n.even?
end
```

つなげるときは{}を使う方が好まれているようだよ

## さまざな繰り返し処理

### times

ブロック処理を複数回繰り返したいとき

```ruby
sum = 0
5.times {|n| sum += n}
sum # => 10
```

### upto, downto

nからmまで数値を増やして行きたい

```ruby
a = []
10.upto(14) { |n| a << n }
a # => [10, 11, 12, 13, 14]
```

downtoは逆

### step

nからmまで数値をxずつ飛ばしながらやりたい
```ruby
a = []
1.step(10, 2) {|n| a << n}
a # => [1, 3, 5, 7, 9]
```

### while, until

ブロックを使わない繰り返し

```ruby

a = []
# 条件が真の間繰り返される
while a.size < 5
  a << 1
end

# untilは条件が偽の場合
until a.size > 5
  a << 1
end

# 1行なら修飾子として後ろにおく方が良い
a << 1 while a.size < 5 

# begin, endで囲むと必ず１回は実行される
begin
  a << 1 
end while false
```

### for

eachメソッドを定義しているオブジェクトに対して実行可能  
あんま使わない,rubyではeachを使うことが多いかも

```ruby
numbers = [1,2,3,4,5]
for n in numbers do sum += n end
```

### loop

無限ループを作りたいとき

```ruby
numbers = [*1..100]
loop do
  # ランダムに要素を取り出し
  n = numbers.sample
  puts n
  break if n > 70
end
# 55
# 15
# 23 
# 77
# => nil ここで終わり
```

### Enumerableモジュール

mapなどのメソッドは配列でなく、Enumrableのメソッド
配列も範囲もEnumrableモジュールに属しているため  
範囲でもmapとか呼べるよ

## 繰り返し処理の制御構文

* break
* next
* redo

### break

繰り返し処理の脱出  
他言語と特に違いなし(後置ifとかで条件指定するのはruby特有かも)

多重ループの場合は一番内側の処理を抜ける

#### 一気に多重ループを抜け出す場合

```ruby
catch タグ do
  throw タグ
end
```

catch, throw、　javaとかだと例外処理だけどRubyだと例外関係ない

```ruby
fruits = %w!apple banana orange grape!
numbers = [*1..4]
catch :done do
  fruits.shuffle.each do |f|
    numbers.shuffle.each do |n|
      puts "#{f}, #{n}"
      throw :done if f == 'orange' && n == 3  
    end
  end
end
# grape, 1
# grape, 4
# grape, 2
# grape, 3
# ..
# orange, 3
# => nil
```

### breakとreturnの違い

breakは「繰り返しからの脱出」returnは「メソッドからの脱出」  
そもそもrubyでは余りreturnとかは使わない..ので余り使うテクではない


### next

繰り返し処理を途中で中断して、次の処理に進める  
他言語でいうcontiunue


### redo

繰り返し処理の、`その回の処理を最初からやり直す`場合に使う

