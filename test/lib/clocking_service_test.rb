require 'test_helper'

class ClockingServiceTest < ActiveSupport::TestCase
  test "should create a clock-in entry" do
    user = User.create(name: "pirlo")
    clock_in_out = ClockingService.new(user, Date.today)

    assert clock_in_out.in
  end

  test "should create a clock-out entry" do
    user = User.create(name: "pirlo")
    clock_in_out = ClockingService.new(user, Date.today)

    assert clock_in_out.out
  end
end
