require 'test_helper'

class SignUpUserTest < ActionDispatch::IntegrationTest
  
  test "user can successfully sign up" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {username: "tom", email: "tom@example.com", password: "password"}
    end
    assert_template 'users/show'
    assert_match "tom", response.body
  end
end