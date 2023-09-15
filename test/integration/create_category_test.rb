require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new page, create category and redirect to show page" do
    get '/categories/new'
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: {category:{name: "New category"}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "New category", response.body
  end
end
