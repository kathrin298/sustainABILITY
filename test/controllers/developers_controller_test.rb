require 'test_helper'

class DevelopersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get developers_new_url
    assert_response :success
  end

  test "should get index" do
    get developers_index_url
    assert_response :success
  end

  test "should get edit" do
    get developers_edit_url
    assert_response :success
  end

end
