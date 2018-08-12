# 7章(クラスについて)

## クラスの利点

クラスを使わずに同じようなデータ構造を複数扱うと、小さいミスが発生しやすい  
クラスを使えば繰り返しの記述が減ってミスがへる



```ruby
# Userクラス
class User
  attr_reader :first_name, :last_name, :age
  
  def initialize(first_name, last_name, age)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end
  
  # 氏名表示のメソッド
  def full_name
    "#{first_name} #{last_name}"
  end
end

# Userデータ作成
users = []
users << User.new('Alice', 'Ruby', 20)
users << User.new('Bob', 'Java', 30)



# Userデータの表示
users.each do |user|
  puts "#{user.full_name}, 年齢: #{user.age}" 
end

# タイポがへる
users[0].first_mame # => Error

# カプセル化(直接の値変更が不可)
users[0].first_name = "hoge"  # => Error
```

## オブジェクト指向プログラミングについて

### クラス

一種のデータ型  
クラスが同じであれば、保持している属性、メソッドは同じになる  
(よく言われる設計図的なもので、具体的なものは持たない)

### オブジェクト・インスタンス・レシーバ

クラスを具象化したものがオブジェクト  
属性の具体的な値はオブジェクト毎に異なってくる

インスタンスもオブジェクトと同義と考えて良い.  
レシーバも同じ(メソッドの話を主体的に書く場合はレシーバが使われる(メソッドの呼び出された側))

### メソッド・メッセージ

オブジェクトが持つ動作や振る舞いをメソッドと呼ぶ  
(共通処理的なやつで)

メッセージはメソッドの別名みたいなもの

```ruby
user = User.new('Alice', 'Ruby', 20)
user.first_name
```

例えばうえのコードだと、「userというレシーバに対して、first_nameというメッセージを送っている」と言える  
(Smalltalkからの用語)

### ステート

オブジェクト毎に保持されるデータのことをオブジェクトの状態(ステート)と言う

### 属性(アトリビュート・プロパティ)

オブジェクトから取得・設定できる値のことを属性(アトリビュート・プロパティ)と呼ぶ  
(サンプルのUserクラスだとfirst_nameとかageのこと)

## Rubyでクラス色々

```ruby
# 原則クラス名はキャメルケース
class ClassName
end

# オブジェクト作成
# このとき、initializeメソッドが呼ばれる(コンストラクタ) 
ClassName.new

class ClassName
  # initializeはprivateメソッドなので直接は呼べない
  def initialize(hoge)
    puts 'コンストラクタ'
    # @変数はインスタンス変数(オブジェクト内部で共通の変数)
    # インスタンス変数は代入されていない状態で参照されてもnilを返すだけ
    # ローカル変数は代入前に呼び出すと参照エラーになるので注意 
    @hoge = hoge
  end
  # クラス構文内でメソッドを定義すると、インスタンスメソッドになる
  def hello(hogehoge)
    puts(hogehoge)
    puts "Hello #{@hoge}"
  end
  
  # インスタンス変数は外部からアクセスできない
  # アクセスした場合はgetter, setterとかを作る必要がある 
  def hoge
    @hoge
  end
  # =で終わるメソッドは代入の形で呼べる
  # className = ClassName.new()
  # こうではなく className.hoge("newValue")
  # className.hoge = "newValue"
  def hoge=(value)
    @name = value
  end
  
  # setter,getterはいちいち宣言めんどい、attr_accessorを使うと暗示的に宣言してくれる
  attr_accessor :hoge # def hogeとdef hoge=(value)の2メソッドを宣言するのと同義
  # getterだけで、setterを設定したくない場合はattr_readerを使う
  attr_reader :hoge
  # setterだけなら
  attr_writer :hoge 
end
```

## クラスの複数回定義

なんども同じクラスを定義すると、毎回1から作り直しではなく、既存の実装が上書きされる  
ので想定した挙動と違うことが発生することがアリエル

## インスタンスメソッドとクラスメソッド

インスタンス毎に固有の値を返した場合などはインスタンスメソッドを使う  
宣言方法は上記の通り

クラスで共通のメソッドを宣言するとき(staticメソッドてきな)は下のように宣言する

```ruby
# selfを使う
class SampleClass
  def self.classMethod
    # 処理
  end
end

# もう1つの方法
class SampleClass
  class << self
    def classMethod
      # 処理
    end
  end
end

# 呼び出し方法
SampleClass.classMethod # クラス名.クラスメソッド 
```

Rubyではインスタンスメソッドを表すときは`クラス名#メソッド名`  
クラスメソッドは`クラス名::メソッド名`で表すよよく

## クラスの中での定数

クラス毎に固有の定数を宣言できる  
```ruby
class Sample
  # 大文字始めが必須, 慣習的には大文字とアンダースコア、数値で構成することが多い
  DEFALUT_VALUE = 0
end
```

呼び出しにはsetter, getterが必要だよ

ちなみにクラス名も定数の1つとなっているので、クラスが定義されていない時のエラーは「定数が見つからない」と出るよ


# クラスをもう少し

## selfキーワード

インスタンス自身を表すキーワード、他言語でいうthisとか  
メソッドの内部で他のメソッドを呼ぶときは暗黙的にselfがついている(sample_seld.rb参照)

`name=`メソッドだけはselfキーワードが必須

```ruby
class Sample
  attr_accessor :name
  # これは書き換えられる
  def rename
    self.name = 'Bob'   
  end
  # これはローカル変数の代入をしているだけ
  def rename
    name = 'Bob'   
  end
end
```

selfはインスタンスのことを表したり、クラス自身のことを表すことがある

## クラスの継承

サブクラス、スーパークラスについては他言語とそんな違いないので  
sample_inheritance.rbを参照

## メソッドの公開レベル

3つのレベルがある

* public
* protected
* private

### public

デフォだとinitialize以外、全てのメソッドがこれ  
クラス外部から自由に呼び出せるメソッド

### private

クラス内部でのみ使えるメソッド

```ruby
class Sample
  # ...
  private # ここから下に定義されたメソッドはprivateメソッドになる
  
  def hello
    puts "hello"
  end
end
```

厳密にはレシーバーを指定して呼び出せないメソッドを指す
(のでクラス内で呼ぶ場合も、selfをつけるとエラーになる)

またrubyの場合、サブクラスでもprivateメソッドが呼び出せる  
意図せずにオーバライドしてしまうこともあるので、継承時はスーパークラスの実装もちゃんと把握することが大事


```ruby
class Sample
 
  def hello
    # レシーバーを指定しているので、これだとエラーになる
    puts "#{self.name}"
    # 下だとおk
    puts "#{name}" 
  end
 
  private # ここから下に定義されたメソッドはprivateメソッドになる
  
  def name
    "test"
  end
end
```

ちなみにクラスメソッドは上の方法でもprivateメソッドにはできない

```ruby
# class << self構文を使うか
class Sample
  class << self
    private
    
    def hello
      'Hello!'
    end
  end
end
Sample.hellp # => Error

class Sample
  def self.hello
    'Hello!'
  end
  # メソッド定義をprivateに変更する
  private_class_method :hello
end
```

privateメソッドを先に書きたい場合は

```ruby
class Sample
  private
  # privateメソッドをかく
 
  public 
  # ここから下はpublicメソッドになる 
end
```

また`private`キーワードの実態はメソッドなので、引数が渡せる(privateにしたいメソッドを渡す)

```ruby
class Sample
  def hoge
  end
  def fuga
  end
  def moge
  end

  # fugaとmogeだけprivateメソッドになる
  private :fuga, :moge
end
```

### protected

その宣言元のクラスとそのサブクラスのインスタンスメソッドからレシーバー付きで呼び出せるメソッド  
privateとの違いはレシーバ付きかどうか

## 継承について

メソッドだけでなく、インスタンス変数も継承されるので意図しないとことがあるので要注意

## 定数について

クラス外部から定数を参照する場合は`クラス名::定数名`で呼び出せる  
```ruby
class Product
  DEFAULT_VALUE = 0
  
  # これを指定すると外部から呼び出し不可になる
  private_constant :DEFAULT_VALUE
end
```

定数はクラス構文内でしか宣言できない(メソッド内では宣言できない)

### Rubyの定数は再代入が可能

可能です(警告は出るけど)　　
再代入を不可にする場合は、クラスをfreezeする必要がある

```ruby
class Product
  DEFAULT_VALUE = 0
  
  # これを指定すると外部から呼び出し不可になる
  # private_constant :DEFAULT_VALUE
end
Product::DEFAULT_VALUE = 1000 
# 凍結 
Product.freeze
Product::DEFAULT_VALUE # => FrozenError (can't modify frozen #<Class:Product>)
```

基本的には暗黙のルールでやらないでねという形にして、freezeは使わないようにしている

### 破壊的メソッドで定数が変わるとき

```ruby
class Product
  # 定数の値をfreezeすれば、破壊的メソッドでの事故も防げる
  DEFAULT_VALUE = "hoge".freeze
  # 配列やハッシュの場合は、配列全体と、各要素全てをfreezeする必要がある
  DEFAULT_ARRAY = ["hoge", "moge", "fuga"].map(&:freeze).freeze
  # この対応が必要なのはミュータブルなオブジェクトだけで、数値やboolean、シンボルなどは不要
end
Product::DEFAULT_VALUE.upcase! # => FrozenError (can't modify frozen String)
```

## その他の変数

ローカル変数とインスタンス変数以外

使用頻度は少ないので、あるよくらいを認識

### クラスインスタンス変数

```ruby
class Sample
  @name = "クラスインスタンス変数"
  
  def self.name
    # クラスインスタンス変数を返す
    @name
  end
  
  def initialize(name)
    # インスタンス変数に代入
    @name = name
  end
  
  def name
    # インスタンス変数を返す
    @name
  end
end
```

インスタンス変数はスーパークラスとサブクラスで同名の変数だと共有されていた  
クラスインスタンス変数の場合は別々のものとして扱われる

### クラス変数(@@変数名)

クラスメソッド内、インスタンスメソッド内、スーパークラス、サブクラスでも共有される変数  
`@@変数`で宣言できる

```ruby
class A
  @@name = "A"
  
  def self.name
    @@name
  end
  
  def initialize(name)
    @@name = name
  end
end

class B < A
  @@name = "B"
  
  def self.name
    @@name
  end
end

A.name # => B
B.name # => B

b = B.new("C")

A.name # => C
```

主な用途はライブラリや設定情報の格納など

### グローバル変数と組み込み変数

`$変数名`はグルーバル変数の宣言  
他の言語同様、複雑になるのでなるべく使用は避けましょう

同様に`$stdin`などあらかじめ予約されている組み込み変数とかもある