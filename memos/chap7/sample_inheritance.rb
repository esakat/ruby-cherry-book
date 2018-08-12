class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def self.sample
    "This is Product Class"
  end

  def to_s
    "name: #{name}, price: #{price}"
  end
end

# Productを継承したクラス
class DVD < Product
  attr_reader :running_time

  def initialize(name, price, running_time)
    # @name = name
    # @price = price
    super(name, price) # 親クラスのメソッドを呼び出す
    # 仮に同じ引数の数だったら、引数なしでsuper呼び出しだけでおk superとsuper()では意味が違うので注
    # DVDクラス独自の属性
    @running_time = running_time
  end

  # そもそも下であれば、initializeを再宣言する必要もない
  # def initialize(name, price)
  #   # @name = name
  #   # @price = price
  #   super
  # end

  # 同名メソッドを宣言でオーバーライドできる
  def to_s
    "name: #{name}, price: #{price}, ruuning_time: #{running_time}"
  end

  def self.sample
    "Override class Method"
  end
end

dvd = DVD.new("movie", 100, 90)
puts dvd.name
puts dvd.price
puts dvd.to_s
puts DVD.sample
puts Product.sample