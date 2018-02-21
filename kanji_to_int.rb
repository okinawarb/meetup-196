require 'test/unit'

class KanjiToInt
  NUM = %w(零 一 二 三 四 五 六 七 八 九).freeze
  LEVEL1 = %w(
    十
    百
    千
  )

  def self.ketanumber(str, keta_kanji, keta_num)
    if str.include?(keta_kanji)
      a, str = str.split(keta_kanji)
      i = NUM.index(a) || 1
      [i * keta_num, str]
    else
      [0, str]
    end
  end

  def self.convert(str)
    ans = 0

    a, str = ketanumber(str, '千', 1000)
    ans += a
    a, str = ketanumber(str, '百', 100)
    ans += a
    a, str = ketanumber(str, '十', 10)
    ans += a
    ans += NUM.index(str) || 0
    ans
  end
end

class TestSample < Test::Unit::TestCase
  def test_one
    assert_equal 1, KanjiToInt.convert('一')
    assert_equal 0, KanjiToInt.convert('零')
    assert_equal 11, KanjiToInt.convert('十一')
    assert_equal 1110, KanjiToInt.convert('千百十')
    assert_equal 1111, KanjiToInt.convert('千百十一')
    # assert_equal 2345, KanjiToInt.convert('二千三百四十五')
    # assert_equal 12345, KanjiToInt.convert('一万二千三百四十五')
  end
end
