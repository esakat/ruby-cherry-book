class User
  # weightは外部へ公開しないようにする
  attr_reader :name

  def initialize(name, weight)
    @name = name
    @weight = weight
  end

  # 他人より重い場合はtrue
  def heavier_than?(other_user)
    puts other_user.weight < @weight # privateだと呼べないし、publicだと外部から見える。。このときにprotectedを使う
  end

  protected

  def weight
    @weight
  end
end

alice = User.new('Alice', 45)
bob = User.new('Bob', 71)

alice.heavier_than?(bob)
bob.heavier_than?(alice)