module Loggable
  def log(text)
    puts "[LOG] #{text}"
  end
end

class Product

  # extendは特異メソッド(クラスメソッド)としてミックスインする
  extend Loggable
  # 直下内で呼べる
  log 'Defined Product class.'

  def self.create_products(names)
    # logもクラスメソッドになっている
    log 'create_products is called'
  end
end

Product.create_products([])