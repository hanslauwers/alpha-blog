require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  test "get new categorie form and create category" do
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: { name: "sports" }
    end
    assert_template 'categories/index'
    assert_match "sports", response.body
  end
  
  test "invalid category submission result in failure" do
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: { name: " " }
    end
    assert_template 'categories/new'
    assert_select 'h2.card-title'
    assert_select "div.card-text"
  end

end