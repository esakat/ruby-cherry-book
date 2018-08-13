require 'minitest/autorun'
require './lib/bank'
require './lib/team'


class DeepFreezableTest < Minitest::Test
  def test_deep_freeze_to_array
    # 配列の値チェック
    assert_equal ['Japan', 'US', 'India'], Team::COUNTRIES
    # 配列自身がfreezeされているか
    assert Team::COUNTRIES.frozen?
    # 配列の全要素がfreezeされているか
    assert Team::COUNTRIES.all? { |country| country.frozen? }
  end

  def test_deep_freeze_to_hash
    # ハッシュの値チェック
    assert_equal(
        {'Japan' => 'yen', 'US' => 'dollar', 'India' => 'rupee'},
        Bank::COUNTRIES
    )
    # ハッシュ自身がfreezeされているか
    assert Bank::COUNTRIES.frozen?
    # 配列の全要素がfreezeされているか
    assert Bank::COUNTRIES.all? { |key, value| key.frozen? && value.frozen? }
  end
end