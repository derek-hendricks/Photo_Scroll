require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    @message = messages(:one)
  end

  test "should get index" do
    login('user1', 'password1')
    get :index
    assert_response :success
    assert_not_nil assigns(:messages)
  end

  test "should get new" do
    login('user1', 'password1')
    get :new
    assert_response :success
  end

  test "should create message" do
    login('user1', 'password1')
    assert_difference('Message.count') do
      post :create, message: { contents: @message.contents }
    end

    assert_redirected_to message_path(assigns(:message))
  end

  test "should show message" do
    login('user1', 'password1')
    get :show, id: @message
    assert_response :success
  end

  test "username and passwords are case insensitive" do 
    login('uSeR1', 'pAsswOrd1')
    get :new 
    assert_response :success
  end

  test "passwords must be correct for a user" do 
    login('user1', 'not my password')
    get :new 
    assert_response :unauthorized
  end


  
private
def login(username, password)
digest = Base64.encode64("#{username}:#{password}")
@request.env['HTTP_AUTHORIZATION'] = "Basic #{digest}"
end
end
