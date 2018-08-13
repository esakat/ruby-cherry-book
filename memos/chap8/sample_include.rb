# 重複するログ機能をモジュールで定義する, (ProductとUserは継承関係にないので継承を使うべきではない)
module Loggable
  # クラス同様にprivateもできる
  private

  def log(text)
    puts "[LOG] #{text}"
  end
end

class Product

  include Loggable

  def title
    log 'title is called'
    'A great movie'
  end
end

class User

  include Loggable

  def name
    log 'name is called.'
    'Alice'
  end
end

product = Product.new
product.title

user = User.new
user.name

# privateなので呼べない
# user.log