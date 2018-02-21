require 'test/unit'

class Sample
  NUM = %w(零 一 二 三 四 五 六 七 八 九)

  def self.convert(str)
    NUM.index(str)
  end
end

class TestSample < Test::Unit::TestCase
  def test_one
    assert_equal 1, Sample.convert('一')
    assert_equal 0, Sample.convert('零')
  end
end
