require 'test_helper'

class ClockInOutControllerTest < ActionController::TestCase
  def setup
    @controller = ClockInOutController.new
    # @request    = ActionController::TestRequest.new
    # @response   = ActionController::TestResponse.new
  end

  test "should create clock-in entry" do
    user = User.create(name: "pirlo")
    post :clock_in, params: { user_id: user.id }
    assert_response :success
  end

  test "should create clock-out entry" do
    user = User.create(name: "pirlo")
    post :clock_out, params: { user_id: user.id }

    assert_response :success

    # Additional assertions or validations can be added here
  end

  test "should return list" do
    get :index

    assert_response :success

    # Additional assertions or validations can be added here
  end
end
