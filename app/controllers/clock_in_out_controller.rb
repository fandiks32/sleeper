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
    clocking_service = ClockingService.new(user, Date.today)

    if clocking_service.in
      render json: clocking_service.clock_in_out
    else
      render json: { errors: clocking_service.clock_in_out.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def clock_out
    user = User.find(params[:user_id])
    clocking_service = ClockingService.new(user, Date.today)

    if clocking_service.out
      render json: clocking_service.clock_in_out
    else
      render json: { errors: clocking_service.clock_in_out.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    item = ClockInOut.find_by(id: params[:id])

    render json: item
  end
end
