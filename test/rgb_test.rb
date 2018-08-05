require 'minitest/autorun'
require './lib/rgb'

class RgbTest < Minitest::Test
  def test_to_hex
    assert_equal '#000000', to_hex(0, 0, 0)
    assert_equal '#ffffff', to_hex(255, 255, 255)
    assert_equal '#10010f', to_hex(16, 1, 15)
  end
end