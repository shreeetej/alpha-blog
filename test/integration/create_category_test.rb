require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = User.create(username:"John Doe", email:"hello@example2.com", password: "password123", admin: true)
  end
  test "get new page, create category and redirect to show page" do
    sign_in_as(@admin_user)
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

  test "get new page form, and reject invalid category submission" do
    sign_in_as(@admin_user)
    get '/categories/new'
    assert_response :success
    assert_no_difference 'Category.count', 1 do
      post categories_path, params: {category:{name: " "}}
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
  end


end
