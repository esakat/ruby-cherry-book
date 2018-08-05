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


