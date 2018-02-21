require 'test/unit'

class Sample
  def self.convert(str)
    1 if str == '一'
  end
end

class TestSample < Test::Unit::TestCase
  def test_one
    assert_equal 1, Sample.convert('一')
  end
end
