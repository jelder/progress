require 'rubygems'
require 'action_view'

# A trivial, reusable progress "bar."
class Progress
  include ActionView::Helpers::DateHelper
  def initialize(total = 0)
    @total = total.to_i
    @start = Time.now
    @done = 0
  end
  attr_accessor :start, :total, :done

  def to_s
    return self.inspect unless @done > 0
    sprintf "%.2f%% (#{self.done} of #{self.total}) at %.2f per second, #{time_remaining} (#{remaining}) remaining",
      self.progress,
      self.rate
  end

  def progress
    ( @done.to_f / @total ) * 100
  end

  def rate
    @done / ( Time.now - @start )
  end

  def remaining
    @total - @done
  end

  def time_remaining
    distance_of_time_in_words( Time.now, Time.now + (self.remaining / self.rate), :true)
  end

  def time_elapsed
    distance_of_time_in_words( @start, Time.now, :true)
  end
end
