class UserController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :follow, :unfollow, :followers_sleep_time]

  def index
    verify_authenticity_token
    @list = User.all
    render json: { count: @list.count, data: @list }
  end

  def show
    item = User.find(params[:id])
    render json: item
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  def follow
    @target_user = User.find(params[:target_user_id])
    @user.follow(@target_user)
    render json: { message: "You are now following user with ID: #{params[:target_user_id]}" }
  end

  def unfollow
    @target_user = User.find(params[:target_user_id])
    @user.unfollow(@target_user)
    render json: { message: "You have unfollowed user with ID: #{params[:target_user_id]}" }
  end

  def followers_sleep_time
    @list = ClockInOut.where(user_id: Follow.where(following_id: @user.id).pluck(:follower_id)).order(duration_ms: :desc)
    render json: { count: @list&.count.to_i, data: @list }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
