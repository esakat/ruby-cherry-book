# 9章のメモ(例外処理)

## 例外の捕捉(Catch)

例外が起きたら、普通はそこで処理が止まる  
それ以降も継続したい場合はCatchが必要

Rubyでは下のようにかく

```ruby
begin
  # 例外が起きうる処理
rescue
  # 例外が発生した場合の処理
end
```

## もちろん呼び出し元で例外キャッチとかも可能

sample_nest_exception.rb参照

## 例外はオブジェクトなので, eみたいな変数に入れて、メッセージ確認とか

sample_exception_object.rb参照

```ruby
begin

rescue => e
  e.message
end
```

## 特定の例外のみキャッチ

```ruby
begin

rescue 特定の例外クラス
end
```

sample_exception_class.rbを参照

## 例外の継承関係

例外のトップクラスは`Exception`それのサブクラスに`特殊エラー`と`StandardError`  
他言語で言う所のExceptionはStandardErrorに該当する

```ruby
begin
  # 例外処理
rescue ZeroDivisionError
  puts "0除算"
rescue NoMethodError
  puts "存在しないメソッド呼び出し"
rescue StandardError
  puts "その他例外が発生しました"
end
```

特定のエラーをキャッチした後にその他全ての例外みたいにやる時は
上のようなコードになると思われる(これはまだまだ冗長)

```ruby
begin
  # 例外処理
rescue ZeroDivisionError
  puts "0除算"
rescue NoMethodError
  puts "存在しないメソッド呼び出し"
rescue # StandardErrorの場合は指定がそもそも不要
  puts "その他例外が発生しました"
end
```

## retry

例外発生時にもう一度処理をやり直す場合はretryキーワードをつける

sample_retry.rbを参照

継承関係を理解して書かないといけないですよ

## 意図的に例外を発生

`raise`キーワードで発生させれる

sample_raise.rbを参照

引数が１つだけの場合はエラーメッセージ
引数が2つの場合は,第一引数が例外クラス、第二引数がエラーメッセージ

```ruby
# 引数1つ
raise "エラーメッセージ"
# 指定しない場合はRuntimeErrorになります `currency_of': 無効な国名です hoge (RuntimeError)

# 引数２つ
raise ArgumentError, "エラーメッセージ"

# もしくはオブジェクトを渡すことも可能
raise ArgumentError.new("エラーメッセージ") 
```

デバッグ辛くなるのでエラーメッセージはちゃんとやりましょうね


## 例外処理ベストプラクティス

### 安易にrescueは使わない

rubyの場合は自分で頑張るよりは即異常終了させるか, Railsとかのフレームワークの共通処理に任せたほうがいい

### rescueした場合は情報を残す

あとでデバッグできるように例外時の状況を確実に残そう  
最低でも、発生した例外クラス、エラーメッセージ、バックとレースの３つはログなりに残しましょう

### 例外が発生しそうな範囲はなるべく絞り込む

```ruby
begin
  m = "jpe"
  y = "msa"
  da = "s"
  1 / 0
end
```
よりも
```ruby
m = "jpe"
y = "msa"
da = "s"
begin
  1 / 0
end
```

なるべくbegin~endの範囲をせばめよう

### 例外処理より条件分岐を

例外で全てキャッチより条件分岐とかをやる  
valid?的な異常チェックをするメソッドでif使って対応したりするようにしましょう

### 予期しない場合は異常終了する

なんか引数を渡されて、それが想定しない場合は  
例外を返したほうがいいよ、変なデフォルト値を返すより


## ensure

例外が発生しても発生しなくても絶対に処理したやつ(Javaでいうfinally)

```ruby
begin

rescue
  # 例外処理
ensure
  # 例外の有無に関わらず処理
end
```

```ruby
begin

ensure
  # 例外が発生してもそのまま例外あげるけど、その前に必ずやる処理
end
```

Fileのオープンクローズとかでやられるよね
```ruby
file = File.open("sample.txt", 'w')

begin
  file << 'Hello'
ensure
  # 例外の有無に関わらずファイルクローズしたい
  file.close
end

```


### ensureじゃなくてブロック付きメソッドを使う

上のファイルクローズの場合などはブロック付きでオープンすると暗黙的にクローズをやってくれる

```ruby
File.open("sample.txt", 'w') do |file|
  file << 'Hello'
end
```

Rubyではこういったブロック付きの呼び出しが多いので  
ensureでやる前にこれでできないかかくにん

## 例外が発生しなかった場合の処理(else)

```ruby
begin

rescue
  # 例外処理
else
  # 例外が発生しなかった場合の処理
ensure
  # どちらにしろやる処理 
end
```

あんま使うことないけどね

## 例外処理と戻り値

例外処理の戻り値

例外が発生しなかった場合はbegin節の最後の式が戻り値  
例外が発生して、rescueされた場合はrescue節の最後の式が戻り値

## 修飾子でrescue

beginを省略できる

```ruby
# エラーが発生しない場合はそのまま値が、発生した場合はrescueに渡した値が返る
1 / 1 rescue "エラーが発生したぞ" # => 1
1 / 0 rescue "エラーが発生したぞ" # => "エラーが発生したぞ"
```

シンプルにできるけど、捕捉できるエラーの種類を設定できない(StandardErrorとそのサブクラスが捕捉される)  
細かく制御するときはbegin〜end利用が良いでしょう

## $! と$@

rubyでは$!に最後に発生した例外、バックトレース情報を$@に格納している  
`rescue => e`みたいにエラーオブジェクト捕捉できるし不要な気もする

## 例外処理のbegin~end省略その２

メソッドの最初から最後までが捕捉対象の場合は省略可能

こういうメソッドが
```ruby
def hoge(n)
  begin
    a = n * 4
    a / 0
  rescue => e
    puts "#{e.message}"
  end
end
```
こうかける
```ruby
def hoge(n)
    a = n * 4
    a / 0
rescue => e
    puts "#{e.message}"
end
```

## 例外捕捉内でさらに例外発生させないように気をつけようね


## 例外内でもう一度同じ例外を発生させる

なんのために？  
例えば例外発生してそのまま終了したいけど, 例外情報をメールで送りたい場合など

ensureで代用できそうな気もするけどね

```ruby
begin
  1 / 0
rescue => e
  # メールを送る
  mail.send(e.message, e.backtrace)
  # 捕捉した例外を再度発生させる
  raise
end
```

## 独自の例外クラスを作成

StandardErrorを継承が一般的

```ruby
class HogeHogeError < StandardError
  # 独自のクラス名与えるだけが目的なので、処理は書かない 
end

def hoge(n)
  if (n.is_a?(String))
    raise HogeHogeError
  end
end

# =>
hoge("hoge")
Traceback (most recent call last):
        3: from /usr/local/bin/irb:11:in `<main>'
        2: from (irb):13
        1: from (irb):9:in `hoge'
HogeHogeError (HogeHogeError) 
```