require 'test_helper'

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get applications_show_url
    assert_response :success
  end

  test "should get new" do
    get applications_new_url
    assert_response :success
  end

end
