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
