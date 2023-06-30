class ClockInOutController < ApplicationController
  def index
    if params[:following_id].blank?
      list = ClockInOut.order(created_at: :desc)
    else
      list = ClockInOut.where(user_id: params[:following_id]).order(duration_ms: :desc)
    end

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
