class UserController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
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

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
