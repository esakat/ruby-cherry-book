require 'singleton'

class Configuration
  # Singletonモジュールのinclude
  include Singleton

  attr_accessor :base_url, :debug_mode

  def initialize
    # 設定の初期化
    @base_url = ''
    @debug_mode = false
  end
end

# new不可
# config = Configuration.new # => Error


# インスタンスメソッドで参照
config = Configuration.instance
# 値の変更
config.base_url = 'http://hoge.com'
config.debug_mode = true

# 再度インスタンスの取得
config_after = Configuration.instance
puts config_after.base_url
puts config_after.debug_mode

## => 実行結果
# http://hoge.com
# true