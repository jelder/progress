require 'helper'
require 'timecop'

class TestProgress < Test::Unit::TestCase
  def test_half_way
    progress = Progress.new(60)
    progress.start = Time.gm(2011, 5, 6, 10, 0, 0)

    Timecop.travel(Time.gm(2011, 5, 6, 10, 1, 0)) do
      progress.done += 30 
      assert_match(progress.to_s, "50.00% (30 of 60) at 0.50 per second, 1 minute (30) remaining")
    end
  end

  def test_complete 
    progress = Progress.new(60)
    progress.start = Time.gm(2011, 5, 6, 10, 0, 0)

    Timecop.travel(Time.gm(2011, 5, 6, 10, 1, 0)) do
      progress.done += 60 
      assert_match(progress.to_s, "100.00% (60 of 60) at 1.00 per second, less than 5 seconds (0) remaining")
    end
  end

  def test_underestimation 
    progress = Progress.new(60)
    progress.start = Time.gm(2011, 5, 6, 10, 0, 0)

    Timecop.travel(Time.gm(2011, 5, 6, 10, 1, 0)) do
      progress.done += 120
      assert_match(progress.to_s, "200.00% (120 of 60) at 2.00 per second, half a minute (-60) remaining")
    end
  end
end
