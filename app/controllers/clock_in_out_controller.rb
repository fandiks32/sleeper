class ClockInOutController < ApplicationController
  def index
    list = ClockInOut.order(created_at: :desc)

    render json: { count: list.count, data: list }
  end

  def clock_in
    user = User.find(params[:user_id])
    ClockingService.new(user, Date.today).in

    head :ok
  end

  def clock_out
    user = User.find(params[:user_id])
    ClockingService.new(user, Date.today).out

    head :ok
  end

  def show
    item = ClockInOut.find_by(id: params[:id])

    render json: item
  end
end
