require 'test_helper'

class EdtfHumanizeTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Edtf::Humanize
  end
end

class HumanizeDecadeTest < ActiveSupport::TestCase
  test "should return a humanized decade string" do
    d = Date.edtf('199x')
    assert_equal "1990s", d.humanize
  end
end

class HumanizeCenturyTest < ActiveSupport::TestCase
  test "should return a humanized century string" do
    d = Date.edtf('19xx')
    assert_equal "1900s", d.humanize
  end
end

class HumanizeIntervalTest < ActiveSupport::TestCase
  test "should return a humanized interval string" do
    d = Date.edtf('1970/1980')
    assert_equal "1970 to 1980", d.humanize
  end
end

class HumanizeApproximateIntervalTest < ActiveSupport::TestCase
  test "should return a humanized approximate interval string" do
    d = Date.edtf('1970~/1980~')
    assert_equal "circa 1970 to 1980", d.humanize
  end
end

class HumanizeIsoDateTest < ActiveSupport::TestCase
  test "should return a humanized ISO date string" do
    d = Date.edtf('1975-07-01')
    assert_equal "July 1, 1975", d.humanize
  end
end

class HumanizeUncertainIsoDateTest < ActiveSupport::TestCase
  test "should return a humanized uncertain ISO date string" do
    d = Date.edtf('1975?')
    assert_equal "1975?", d.humanize
  end
end

class HumanizeUnspecifiedYearIsoDateTest < ActiveSupport::TestCase
  test "should return a humanized unspecified year ISO date string" do
    d = Date.edtf('197u')
    assert_equal "197x", d.humanize
  end
end

class HumanizeSeasonTest < ActiveSupport::TestCase
  test "should return a humanized season string" do
    d = Date.edtf('1975-22')
    assert_equal "summer 1975", d.humanize
  end
end

class HumanizeSetTest < ActiveSupport::TestCase
  test "should return a humanized set string" do
    d = Date.edtf('[1980, 1981, 1983]')
    assert_equal "1980, 1981 or 1983", d.humanize
  end
end

class HumanizeUnknownTest < ActiveSupport::TestCase
  test "should return a humanized unknown string" do
    d = Date.edtf('uuuu')
    assert_equal "unknown", d.humanize
  end
end

