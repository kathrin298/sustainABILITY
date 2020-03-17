require 'test_helper'

class DeveloperFavouritesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get developer_favourites_create_url
    assert_response :success
  end

end
