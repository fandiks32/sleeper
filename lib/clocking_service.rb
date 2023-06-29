class ClockingService
  attr_reader :clock_in_out, :user

  def initialize(user, target_date)
    @user = user
    @clock_in_out = ClockInOut.find_or_create_by(user: user, target_date: target_date)
  end

  def in
    clock_in_out.update(clock_in: Time.now)
  end

  def out
    clock_in_out.update(clock_out: Time.now)
  end
end
