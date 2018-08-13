# 8章(モジュールについて)

## モジュールの用途

* 継承を使わずにクラスにインスタンスメソッドを追加
* 複数のクラスに特異メソッドを追加
* 名前空間
* 函数的メソッドを定義
* シングルトンオブジェクトの作成で設定保持とか

## モジュールの定義

```ruby
module モジュール名
  # モジュール定義 
end
```
クラスとの違い

* モジュールからインスタンス作成は不可
* 他のモジュールやクラスを継承はできない

## ミックスイン(include, extend)

`Class.include?(モジュール)`でミックスインされているか確認できる(もしくは`is_a?`)  
ミックスインされているモジュールの確認は`include_modules`メソッドでできる

インクルード先にあるであろうメソッドを前提にモジュールで利用もできる

```ruby
module Taggable
  def price_tag
    # priceはincelude先で定義されている
    "#{price}"
  end
end

class Product
  include price_tag
  def price
    "hoge"
  end
end
```

## ダックタイピングを使ったモジュールをいくつか

### Enumerable

Rangeとか繰り返し処理できる  
map, select, findなどがある

Enumerableモジュールをincludeできる条件はeachメソッドが実装されているということだけ

### Comparable

比較を可能にするモジュール

Comparableモジュールをincludeできる条件は`<=>`演算子を実装しておくこと

`<=>`はUFO演算子

```ruby
>> 1 <=>1
=> 0
>> 1 <=>2
=> -1
>> 2 <=> 1
=> 1
>> 2 <=> "a"
```

比較して左辺が大きい時は正の数値、右辺が大きい時は負の数値,比較できないときはnil　同値は0を返す


### Kernelモジュール

puts, print, requireなどが含まれている

最初から当たり前のように使えるメソッドはKernelモジュールで定義されている  
ObjectクラスがKernelモジュールをincludeしているので、RubyはすベてObjectなので  
つまりKernelモジュールのメソッドはどこでも使えるということ

## Topレベルについて

```ruby
# このクラス外のとこをトップレベルという 

class Sample
end
```

トップレベルはmainという名前のObjectクラスのインスタンスがselfとして存在している
```Bash
$ irb
>> self # => main
self.class
=> Object # つまりKernelモジュールのメソッドが呼べるね
```

## クラス・モジュールもオブジェクト

Rubyは全てがオブジェクト,
```ruby
>> Class.class
=> Class
>> Class.superclass
=> Module
>> Module.superclass
=> Object
```

## モジュールとインスタンス変数

モジュール内でインスタンス変数をいじると、include先のクラスのインスタンス変数も変更される  
これはいい設計ではない

# モジュールを使った名前空間の作成

クラス名かぶることとかあるよね  
モジュールで名前空間を分けることが可能

```ruby
module Baseball
  # 野球のセカンド
  class Second
  end
end

module Clock
  # 時間の秒
  class Second
  end
end

# 呼び出す時はモジュール名を指定して
Baseball::Second.new
Clock::Second.new 
```

名前空間だけでなくjavaでいうpackage的なまとまり単位で分けるために使っているよ

ちなみにネストしなくてもできるよ

```ruby
# 先にモジュールを宣言しておいて
module Baseball
end

# モジュール名指定でクラス宣言
class Baseball::Second
end
```

