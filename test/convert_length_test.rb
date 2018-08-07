require 'minitest/autorun'
require './lib/convert_length'

class ConvertLengthTest < Minitest::Test
  def test_convert_length
    assert_equal 39.97, convert_length(1, 'm', 'in')
  end
end