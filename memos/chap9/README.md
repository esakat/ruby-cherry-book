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
上のようなコードになると思われる