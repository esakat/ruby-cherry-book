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


