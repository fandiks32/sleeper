require 'test_helper'

class UserControllerTest < ActionController::TestCase
  def setup
    @current_user = User.create(name: 'John Doe')
    @user_to_follow = User.create(name: 'Jane Smith')
  end

  test 'should create user' do
    assert_difference('User.count') do
      post :create, params: { user: { name: 'John Doe' }}
    end

    assert_response :success
  end

  test 'should update user' do
    user = User.create(name: 'John Doe')
    patch :update, params: { id: user.id, user: { name: 'Updated Name' } }
    assert_response :success
    user.reload
    assert_equal 'Updated Name', user.name
  end

  test 'should destroy user' do
    user = User.create(name: 'John Doe')

    assert_difference('User.count', -1) do
      delete :destroy, params: { id: user.id }
    end

    assert_response :no_content
  end

  test 'should get index' do
    post :create, params: { user: { name: 'John Doe' }}
    get :index
    assert_response :success
    assert_not_nil assigns(:list)
  end

  test 'should follow user' do
    post :follow, params: { id: @current_user, target_user_id: @user_to_follow.id }

    assert @current_user.following?(@user_to_follow)
    assert_response :success
  end

  test 'should unfollow user' do
    @current_user.follow(@user_to_follow) # Assume the user is already following

    post :unfollow, params: { id: @current_user.id, target_user_id: @user_to_follow.id }

    assert_not @current_user.following?(@user_to_follow)
    assert_response :success
  end

  test 'follower sleep times' do
    ClockingService.new(@current_user, Date.today).in
    ClockingService.new(@current_user, Date.today).out
    @current_user.follow(@user_to_follow)

    get :followers_sleep_time, params: { id: @current_user.id }
    assert_response :success
    assert_not_nil assigns(:list)
  end
end
