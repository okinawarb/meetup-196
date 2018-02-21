require 'test/unit'

class Sample
  NUM = %w(零 一 二 三 四 五 六 七 八 九).freeze
  LEVEL1 = %w(
    十
    百
    千
  )

  def self.convert(str)
    ans = 0
    if str.include?("千")
      a, str = str.split("千")
      i = NUM.index(a) || 1
      ans += i * 1000
    end

    if str.include?("百")
      a, str = str.split("百")
      i = NUM.index(a) || 1
      ans += i * 100
    end

    if str.include?("十")
      a, str = str.split("十")
      i = NUM.index(a) || 1
      ans += i * 10
    end

    ans += NUM.index(str) || 0
    ans
  end
end

class TestSample < Test::Unit::TestCase
  def test_one
    assert_equal 1, Sample.convert('一')
    assert_equal 0, Sample.convert('零')
    assert_equal 11, Sample.convert('十一')
    assert_equal 1110, Sample.convert('千百十')
    assert_equal 1111, Sample.convert('千百十一')
  end
end
