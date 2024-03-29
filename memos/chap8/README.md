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

# 関数や定数を提供するモジュール

JavaでいうStaticクラスてきな使い方だね

```ruby
module Sample
  def self.log(text)
    "hoge"
  end
end

# ミックスインせずに呼べる
Sample.log("huu")
```

クラスメソッドと似ているけど、モジュールは全くインスタンスが作れないので  
よりこういった用途に向いている

## module_function

ミックスインとしても使えるかつ、特異メソッドとしても使える
モジュール関数というよ

```ruby
module SampleModule
  def log(text)
    "hoge"
  end
  
  module_function :log
end

# ミックスインせずに呼べる
SampleModule.log("huu")

class SampleClass
  include SampleModule
  
  def title
    # ミックスいんもできる
    log "moge"
  end
end
```

```ruby
# 引数なしで呼んだ場合はこれいかに定義されたメソッドがモジュール関数になる
module_function
def hoge 
end
```

## モジュールにも定数定義はできる

クラスと変わらない

```ruby
module Sample
  HOGE = "hoge"
end
Sample::HOGE
```

## モジュール関数の代表例(Mathモジュール)

ミックスいんもできるし、そのまま使えるし

```ruby
Math.sqrt(2) # => 1.4142135623730951

class Calc
  include Math
  # ミックスいんも可能
  def calc n
    sqrt n
  end
end
```

# 状態保持のモジュール利用

シングルトン的なね  
モジュールはインスタンスを生成出来ない点を利用して  
インスタンス変数を使ってシングルトンなオブジェクトを作成できる

1から定義しなくてもsingletonモジュールを使うといいかも(コード参照)

# 高度なモジュール

## モジュール内でモジュールのミックスインも可能

## includeではなく、　prependでモジュールのミックスイン

メソッド参照の優先順が変わる

既存メソッドの置き換えという方法にも使える

## refinements 

有効範囲を制限できる

ミックスインしたモジュールをprivate関数のようにクラス内でのみ使いたい場合に有効

`using`キーワードでモジュールをミックスイン すればいい

