class FollowController < ApplicationController
  def create
    record = Follow.new(following_id: params[:following_id], follower_id: params[:follower_id])
    record.save
    render json: record
  end

  def unfollow
    record = Follow.find_by(following_id: params[:following_id], follower_id: params[:follower_id])
    record.destroy
    head :no_content
  end

  def index
    list = Follow.find_by(follower_id: params[:following_id])
    render json: { count: list.count, data: list }
  end
end
