require 'test/unit'

class KanjiToInt
  NUM = %w(零 一 二 三 四 五 六 七 八 九).freeze
  LEVEL1 = %w(十 百 千)

  UNITS = [
    ['兆', 1_0000_0000_0000],
    ['億', 1_0000_0000],
    ['万', 1_0000]
  ]

  def self.ketanumber(str, keta_kanji, keta_num)
    if str.include?(keta_kanji)
      a, b = str.split(keta_kanji, 2)
      i = NUM.index(a) || 1
      [i * keta_num, b]
    else
      [0, str]
    end
  end

  def self.convert(str)
    ans = 0

    UNITS.each do |ketakanji, num|
      if str.include?(ketakanji)
        a, str = str.split(ketakanji, 2)
        ans += parse_under_man(a) * num
      end
    end

    ans += parse_under_man(str)
  end

  def self.parse_under_man(str)
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
  def test_万未満
    assert_equal 0, KanjiToInt.convert('零')
    assert_equal 1, KanjiToInt.convert('一')
    assert_equal 11, KanjiToInt.convert('十一')
    assert_equal 1110, KanjiToInt.convert('千百十')
    assert_equal 1111, KanjiToInt.convert('千百十一')
    assert_equal 2000, KanjiToInt.convert('二千')
    assert_equal 2345, KanjiToInt.convert('二千三百四十五')
  end

  def test_万以上_億未満
    assert_equal 1_0000, KanjiToInt.convert('一万')
    assert_equal 1_2345, KanjiToInt.convert('一万二千三百四十五')
    assert_equal 21_2345, KanjiToInt.convert('二十一万二千三百四十五')
    assert_equal 1000_2345, KanjiToInt.convert('一千万二千三百四十五')
  end

  def test_億以上_兆未満
    assert_equal 1_0000_2345, KanjiToInt.convert('一億二千三百四十五')
    assert_equal 21_1122_2345, KanjiToInt.convert('二十一億一千百二十二万二千三百四十五')
  end

  def test_兆以上
    assert_equal 1_2345_0000_2345, KanjiToInt.convert('一兆二千三百四十五億二千三百四十五')
  end

  def test_コーナーケース
    assert_equal 21, KanjiToInt.convert('二十一です。五千兆円欲しい')
    assert_equal 123, KanjiToInt.convert('一二三')
  end
end
