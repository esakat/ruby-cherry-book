class SampleSelf
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def hello
    # selfなしでnameメソッドを呼び出し
    puts "Hello, #{name}"
  end

  def hi
    # selfつき
    puts "Hi, #{self.name}"
  end

  def my_name
    # インスタンス変数で呼び出し
    puts "my name is #{@name}"
  end
end

user = SampleSelf.new("Alice")
user.hello
user.hi
user.my_name

# ==> Output
# Hello, Alice
# Hi, Alice
# my name is Alice

class Foo
  puts "クラス直下 #{self}"

  # クラスメソッドを呼び出す場合は、宣言より下にする必要がある

  def self.bar
    puts "クラスメソッド内 #{self}"
  end

  # ここでは呼び出せる
  self.bar

  def baz
    puts "インスタンスメソッド内 #{self}"
    # クラスメソッドをインスタンスメソッド内で呼ぶときは クラス名.メソッド名(もしくはself.class.メソッド)
    Foo.bar
  end
end

Foo.bar
foo = Foo.new
foo.baz