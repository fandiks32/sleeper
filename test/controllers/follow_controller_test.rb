require 'test_helper'

class FollowControllerTest < ActionController::TestCase

  def setup
    @user1 = User.create(name: 'gladiator')
    @user2 = User.create(name: 'archer')
  end

  test 'should create with valid attributes' do
    post :create, params: { follower_id: @user1.id, following_id: @user2.id }
    assert_response :success
  end

  test 'should unfollow with valid attributes' do
    post :create, params: { follower_id: @user1.id, following_id: @user2.id }
    assert_response :success

    post :unfollow, params: { follower_id: @user1.id, following_id: @user2.id }
    assert_response :no_content
  end
end
