require 'test_helper'

class AuthorsControllerTest < ActionController::TestCase
  setup do
    @author = authors(:bob)
  end

 test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end


  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create author" do
    assert_difference('Author.count') do
      post :create, author: { full_name: @author.full_name, password: @author.password, profile: @author.profile, username: @author.username }
    end

    assert_redirected_to author_path(assigns(:author))
  end

  test "should show author" do
    get :show, id: @author
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @author
    assert_response :success
  end

  test "should update author" do
    patch :update, id: @author, author: { full_name: @author.full_name, password: @author.password, profile: @author.profile, username: @author.username }
    assert_redirected_to author_path(assigns(:author))
  end

  test "should destroy author" do
    assert_difference('Author.count', -1) do
      delete :destroy, id: @author
    end
    assert_redirected_to authors_path
  end
 
  test "should redirect edit when not logged in" do
    get :edit, id: @author
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @author, author: { full_name: @author.full_name, email: @author.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
