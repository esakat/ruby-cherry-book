# 正規表現について

## 正規表現の便利さ

パターンで検索

```ruby
text = <<TEXT
I love Ruby
Python is a great language
Java and JavaScript are different
TEXT

text.scan(/[A-Z][A-Za-z]+/)
```

置換

```ruby
text = <<TEXT
私の郵便番号は1129987です.
TEXT

puts text.gsub(/(\d{3})(\d{4})/, '\1-\2') # => 私の郵便番号は112-9987です.
```

## 正規表現オブジェクト

Rubyでは`/正規表現/`で表せる

```ruby
/[1-9]/.class # => Regexp
```

### 文字列とのマッチング確認

`=~`を使うとBoolean的に扱える


```ruby
# マッチングしたときはマッチングした文字位置の数値,  マッチングしない場合はnilが返る
# つまりBoolean的に扱える 
'123-4567' =~ /\d{3}-\d{4}/ # => 0
'aaa-45678' =~ /\d{3}-\d{4}/ # => nil

# 否定マッチングは !~でできる
'123-4567' !~ /\d{3}-\d{4}/ # => false
'aaa-45678' !~ /\d{3}-\d{4}/ # => true
```

## 複雑なのテストするとき

[Rubular](http://www.rubular.com)を使うといいそうですよ

## キャプチャ機能

`私の誕生日は1997年3月20日です`これを正規表現使うと

```ruby
# かくにん
'私の誕生日は1997年3月20日です'.scan(/\d+年\d+月\d+日/) # => ["1997年3月20日"]

# 年、月、日をそれぞれ個別に扱いたいときはキャプチャ,,()で囲む
'私の誕生日は1997年3月20日です'.scan(/(\d+)年(\d+)月(\d+)日/) # => [["1997", "3", "20"]]

# matchメソッドがいいかも
test =  '私の誕生日は1997年3月20日です'
m = /(\d+)年(\d+)月(\d+)日/.match(test) # => #<MatchData "1997年3月20日" 1:"1997" 2:"3" 3:"20">
# MatchDataは配列的に使える
m.class # => MatchData
m[1] # => "1997"

# 連番だと分かりづらいので、?<>で名前をつける
m = /(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/.match(test)
# シンボルで取れるようになる
m[:year] # => 1997
```

## 正規表現と組み合わせると便利なStringクラスメソッド

### scan

```ruby
# マッチした内容を配列で返してくれる
'私の誕生日は1997年3月20日です'.scan(/(\d+)年(\d+)月(\d+)日/) # => [["1997", "3", "20"]]
```

### [], slice, slice!

```ruby
# マッチした箇所文字列で取り出す
text = '私の誕生日は1997年3月20日です'
text[/\d+年\d+月\d+日/] # => "1997年3月20日"
# sliceはエイリアスメソッド、slice!は元の文字列から該当箇所が取り除かれる

text.slice(/\d+年\d+月\d+日/)
text # => 私の誕生日は1997年3月20日です
text.slice!(/\d+年\d+月\d+日/)
text # => "私の誕生日はです"
``` 

### split

文字列だけでなく、正規表現で文字列の分割が可能

### gsub, gsub!

置換メソッド、第一引数で正規表現渡して、第二引数で置換先文字列を指定する

## 正規表現オブジェクトの生成方法

```ruby
/[1-9]/
Regexp.new('[1-9]')
%r![1-9]!
```

3つとも同じ, `%r` を使うとスラッシュとかがでる文字列でエスケープが不要になるよ

## 正規表現のオプション

`/正規表現/オプション`でオプション渡せる

`i`オプションはアルファベットの小文字・大文字の違いを無視する  
`m`は`.`の任意の１文字に改行文字も含まれるようになる  
`x`は空白文字を無視する

## 組み込み変数

というのがあるけど、可読性落ちるし、matchメソッドとか使う方がいいよね
