require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: false)
  end
  
  test "should be able to successfully create an article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {title: "test title", description: "description for test article", user_id: @user.id}
    end
    assert_template 'articles/show'
    assert_match 'test title', response.body
    assert_match 'description for test article', response.body
  end
end