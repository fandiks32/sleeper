require 'test_helper'

class UserControllerTest < ActionController::TestCase
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
end
