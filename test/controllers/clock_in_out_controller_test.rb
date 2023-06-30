require 'test_helper'

class ClockInOutControllerTest < ActionController::TestCase
  def setup
    @user = User.create(name: "pirlo")
  end
  test "should create clock-in entry" do
    post :clock_in, params: { user_id: @user.id }
    assert_response :success
  end

  test "should create clock-out entry" do
    post :clock_out, params: { user_id: @user.id }

    assert_response :success

    # Additional assertions or validations can be added here
  end

  test "should return list" do
    post :clock_in, params: { user_id: @user.id }
    get :index

    assert_response :success
  end

  test "shold return list by following id" do
    post :clock_in, params: { user_id: @user.id }
    post :clock_out, params: { user_id: @user.id }
    get :index, params: { following_id: @user.id }

    assert_response :success
    result = JSON.parse(response.body)
    assert(result["count"] == 1)
  end
end
