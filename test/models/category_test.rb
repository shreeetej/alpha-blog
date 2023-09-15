class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "Hello")
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "category should be present" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "category should be unique" do
    @category.save
    @category2 = Category.new(name: "Hello")
    assert_not @category2.valid?
  end

  test "category name should not be too long , more than 25 chars" do
    @category.name = "More than 25 characters in the name of category"
    assert_not @category.valid?
  end

  test "category name should not be too short , less than 10 char" do
    @category.name = "aa"
    assert_not @category.valid?
  end

end
