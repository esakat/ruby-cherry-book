# helloメソッドをもつモジュール
module Greeter
  def hello
    'hello'
  end
end

# # 不可
# greeter = Greeter.new

# # これもだめ
# module AwesomeGreeter < Greeter
# end