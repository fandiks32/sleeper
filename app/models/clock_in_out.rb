class ClockInOut < ApplicationRecord
  belongs_to :user
  before_save :calculate_duration_ms

  def calculate_duration_ms
    if (clock_in.present? && clock_out.present?) && (clock_out_changed?  || clock_in_changed?)
      self.duration_ms = clock_out - clock_in
    end
  end
end
